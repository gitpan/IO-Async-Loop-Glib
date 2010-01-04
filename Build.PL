use strict;
use warnings;

use Module::Build;

my $build = Module::Build->new
  (
   module_name => 'IO::Async::Loop::Glib',
   requires => {
      'Glib' => 0,
      'IO::Async::Loop' => 0.24,
      'Time::HiRes' => 0,
   },
   build_requires => {
      'Test::More' => 0,
      'IO::Async::LoopTests' => '0.24',
   },
   license => 'perl',
   create_makefile_pl => 'traditional',
   create_license => 1,
   create_readme  => 1,
  );

$build->create_build_script;
