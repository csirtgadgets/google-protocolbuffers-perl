use 5.0060000;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'Google::ProtocolBuffers',
    VERSION_FROM      => 'lib/Google/ProtocolBuffers.pm', # finds $VERSION
    PREREQ_PM         => {
    	Parse::RecDescent => 1.94,
    	Math::BigInt	  => 0,
    	Class::Accessor	  => 0,
        constant          => 1.04, 
        Config            => 0,
        Data::Dumper      => 0,
        Test::More        => 0.52,
    }, 
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/Google/ProtocolBuffers.pm', # retrieve abstract from module
       AUTHOR         => 'Igor Gariev <gariev@hotmail.com>') : ()),
);
