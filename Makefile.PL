use inc::Module::Install;

name        'Google-ProtocolBuffers';
all_from    'lib/Google/ProtocolBuffers.pm';
version     5.05;
license     'perl';

author  'Igor Gariev <gariev@hotmail.com>','the CISRT Gadgets Foundation <csirtgadgets.org>';

requires    'Parse::RecDescent' => 1.94;
requires    'Test::More'        => 0.52;
requires    'Math::BigInt';
requires    'Class::Accessor';
requires    'constant';
requires    'Config';

homepage    'https://github.com/csirtgadgets/google-protocolbuffers-perl';
bugtracker  'https://github.com/csirtgadgets/google-protocolbuffers-perl/issues';
repository  'https://github.com/csirtgadgets/google-protocolbuffers-perl.git';

WriteAll();
