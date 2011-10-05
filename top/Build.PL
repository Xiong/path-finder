use 5.008008;
use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Test::Ranger',
    license             => 'artistic_2',
    dist_author         => 'Xiong Changnian <xiong@cpan.org>',
    dist_version_from   => 'lib/Path/Finder.pm',
    requires            => {
        'perl'                      => 5.008008,
        'version'                   => 0.94,
#~         'parent'                    => 0,
        'Carp'                      => 0,
#~         'Cwd'                       => 0,
#~         'Data::Dumper'              => 0,
#~         'Data::Lock'                => 0,
#~         'File::Spec'                => 0,
#~         'File::Spec::Functions'     => 0,
#~         'IO::File'                  => 0,
#~         'List::MoreUtils'           => 0,
#~         'POSIX'                     => 0,
#~         'Scalar::Util'              => 0,
#~         'Scalar::Util::Reftype'     => 0,
#~         'Test::Builder2::Tester'    => 2.00_07,
#~         'Test::Deep'                => 0,
        'Test::More'                => 0.94,
        'Test::Trap'                => 0,
#~         ''  => 0,
    },
    recommends          => {
        'Devel::Comments'           => '1.1.4',
    },
    build_requires      => {
        'Acme::Teddy'               => 1.002003,
    },
    add_to_cleanup      => [ 'Path-Finder-*' ],
    meta_merge          => {
        resources           => {
            repository          => 'http://github.com/Xiong/path-finder',
        },
        keywords            => [ qw(
            devel   development 
            
            module  build   module-build
            install installer
            config  configuration
            prefs   preferences
            options
            internal    storage
            file    files
            path    paths
            system  platform
            cross-platform  linux freebsd   windows mac macintosh   osx
            
        ) ],
    },
);

$builder->create_build_script();
