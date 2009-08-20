#!/usr/bin/perl -w

use strict;

use Test::More tests => 5;

use Time::HiRes qw( time );

use IO::Socket::UNIX;

use IO::Async::Loop::Glib;

my $loop = IO::Async::Loop::Glib->new();

my $done = 0;

$loop->enqueue_timer( delay => 2, code => sub { $done = 1; } );

my $id = $loop->enqueue_timer( delay => 3, code => sub { die "This timer should have been cancelled" } );
$loop->cancel_timer( $id );

undef $id;

my ( $now, $took );

$SIG{ALRM} = sub { die "Test timed out" };
alarm 4;

$now = time;
# GLib might return just a little early, such that the TimerQueue
# doesn't think anything is ready yet. We need to handle that case.
$loop->loop_once( 0.1 ) while !$done;
$took = time - $now;

alarm 0;

is( $done, 1, '$done after iteration while waiting for timer' );

cmp_ok( $took, '>', 1.9, 'iteration while waiting for timer takes at least 1.9 seconds' );
cmp_ok( $took, '<', 10, 'iteration while waiting for timer no more than 10 seconds' );
if( $took > 2.5 ) {
   diag( "iteration while waiting for timer took more than 2.5 seconds.\n" .
         "This is not itself a bug, and may just be an indication of a busy testing machine" );
}

$id = $loop->enqueue_timer( delay => 1, code => sub { $done = 2; } );
$id = $loop->requeue_timer( $id, delay => 2 );

$done = 0;

alarm 3;

$loop->loop_once( 1 );

is( $done, 0, '$done still 0 so far' );

$loop->loop_once( 5 );

# GLib might return just a little early, such that the TimerQueue
# doesn't think anything is ready yet. We need to handle that case.
$loop->loop_once( 0.1 ) while !$done;

is( $done, 2, '$done is 2 after requeued timer' );