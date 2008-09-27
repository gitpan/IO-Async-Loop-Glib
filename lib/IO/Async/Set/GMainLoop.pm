#  You may distribute under the terms of either the GNU General Public License
#  or the Artistic License (the same terms as Perl itself)
#
#  (C) Paul Evans, 2007,2008 -- leonerd@leonerd.org.uk

package IO::Async::Set::GMainLoop;

use strict;

our $VERSION = '0.10';

use base qw( IO::Async::Loop::Glib IO::Async::Set );

use warnings qw();

=head1 NAME

C<IO::Async::Set::GMainLoop> - backward-compatibility wrapper around
C<IO::Async::Loop::Glib>

=head1 SYNOPSIS

This class should not be used in new code. It has been renamed to
C<IO::Async::Loop::Glib>. Any application using this class should simply
change

 use IO::Async::Set::GMainLoop;

 my $set = IO::Async::Set::GMainLoop->new( .... );

into

 use IO::Async::Loop::Glib;

 my $loop = IO::Async::Loop::Glib->new( .... );

The behaviour has not otherwise changed.

=cut

die "IO::Async::Set::GMainLoop is now deprecated. Please use IO::Async::Loop::GLib instead\n";

__END__

=head1 SEE ALSO

=over 4

=item *

L<IO::Async::Loop::Glib> - a Loop using the C<Glib::MainLoop> object

=back

=head1 AUTHOR

Paul Evans E<lt>leonerd@leonerd.org.ukE<gt>
