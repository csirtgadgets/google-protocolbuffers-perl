use inc::Module::Install;

name        'Google-ProtocolBuffers';
version     5.05;
license     'perl';
all_from    'lib/Google/ProtocolBuffers.pm';

author  'Igor Gariev <gariev@hotmail.com>','the CISRT Gadgets Foundation <csirtgadgets.org>';

requires    'Parse::RecDescent' => 1.94;
requires    'Test::More'        => 0.52;
requires    'Math::BigInt';
requires    'Class::Accessor';
requires    'constant';
requires    'Config';

install_script  'bin/protoc-perl';

homepage    'https://github.com/csirtgadgets/google-protocolbuffers-perl';
bugtracker  'https://github.com/csirtgadgets/google-protocolbuffers-perl/issues';
repository  'https://github.com/csirtgadgets/google-protocolbuffers-perl.git';

WriteAll();
