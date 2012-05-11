use Test::More tests => 46;
use strict;
use warnings;
use Google::ProtocolBuffers;

BEGIN{ $SIG{__DIE__} = \&Carp::confess; }

Google::ProtocolBuffers->parsefile(
    "google/protobuf/unittest.proto", 
    {include_dir => 't', create_accessors => 1 }
);

my $data = ProtobufUnittest::TestAllTypes->decode("\x{08}\x{00}");
is($data->{optional_int32}, 0, "optional_int32=0");
ok(defined $data->{optional_int32});
ok(exists $data->{optional_int32});

##optional    int32 default_int32    = 61 [default =  41    ];

## no value is set, accessor must return the default one
ok(!exists $data->{default_int32});
is($data->default_int32, 41);

## after setting a value, the value must be returned instead
$data->default_int32(0);
ok(exists $data->{default_int32});
is($data->{default_int32}, 0);
is($data->default_int32, 0);

## undef will not be serialized, so after decoding, a default value there will be.
## so, it make sense that after setting an undef, we get a default value
$data->default_int32(undef);
ok(!exists $data->{default_int32});
is($data->default_int32, 41);

## Data object may be get from Class::Accessor's new:
$data = ProtobufUnittest::TestAllTypes->new;
ok(!exists $data->{default_int32});
is($data->default_int32, 41);

$data = ProtobufUnittest::TestAllTypes->new({default_int32=>0});
ok(exists $data->{default_int32});
is($data->default_int32, 0);
is($data->{default_int32}, 0);

$data = ProtobufUnittest::TestAllTypes->new({default_int32=>undef});
ok(exists $data->{default_int32});
ok(!defined $data->{default_int32});
is($data->default_int32, 41);


##  optional    int64 default_int64    = 62 [default =  42    ];
is($data->default_int64, 42);

##  optional   uint32 default_uint32   = 63 [default =  43    ];
is($data->default_uint32, 43);

##  optional   uint64 default_uint64   = 64 [default =  44    ];
is($data->default_uint64, 44);

##  optional   sint32 default_sint32   = 65 [default = -45    ];
is($data->default_sint32, -45);

##  optional   sint64 default_sint64   = 66 [default =  46    ];
is($data->default_sint64, 46);

##  optional  fixed32 default_fixed32  = 67 [default =  47    ];
is($data->default_fixed32, 47);

##  optional  fixed64 default_fixed64  = 68 [default =  48    ];
is($data->default_fixed64, 48);

##  optional sfixed32 default_sfixed32 = 69 [default =  49    ];
is($data->default_fixed64, 48);

##  optional sfixed64 default_sfixed64 = 70 [default = -50    ];
is($data->default_sfixed64, -50);

##  optional    float default_float    = 71 [default =  51.5  ];
is($data->default_float, 51.5);

##  optional   double default_double   = 72 [default =  52e3  ];
cmp_ok($data->default_double, '==', 52000);

##  optional     bool default_bool     = 73 [default = true   ];
is($data->default_bool, 1);

##  optional   string default_string   = 74 [default = "hello"];
is($data->default_string, "hello");

##  optional    bytes default_bytes    = 75 [default = "world"];
is($data->default_bytes, "world");

##  optional NestedEnum  default_nested_enum  = 81 [default = BAR        ];
is($data->default_nested_enum, ProtobufUnittest::TestAllTypes::NestedEnum::BAR());

##  optional ForeignEnum default_foreign_enum = 82 [default = FOREIGN_BAR];
is($data->default_foreign_enum, ProtobufUnittest::ForeignEnum::FOREIGN_BAR());

##  optional protobuf_unittest_import.ImportEnum
##      default_import_enum = 83 [default = IMPORT_BAR];
is($data->default_import_enum, ProtobufUnittestImport::ImportEnum::IMPORT_BAR());

##  optional string default_string_piece = 84 [ctype=STRING_PIECE,default="abc"];
is($data->default_string_piece, "abc");

##  optional string default_cord = 85 [ctype=CORD,default="123"];
is($data->default_cord, "123");

##
## TestAllExtensions
##
$data = ProtobufUnittest::TestAllExtensions->new;
is($data->getExtension('default_int32_extension'), 41);
is($data->getExtension('default_string_extension'), "hello");
is($data->getExtension('default_nested_enum_extension'), ProtobufUnittest::TestAllTypes::NestedEnum::BAR());

##
## TestExtremeDefaultValues
## 
$data = ProtobufUnittest::TestExtremeDefaultValues->new;

##  optional bytes escaped_bytes = 1 [default = "\0\001\a\b\f\n\r\t\v\\\'\"\xfe"];
is($data->escaped_bytes, "\0\001\a\b\f\n\r\t\x{0b}\\\'\"\xfe");

##  optional uint32 large_uint32 = 2 [default = 0xFFFFFFFF];
is($data->large_uint32, 0xFFFFFFFF);

##  optional uint64 large_uint64 = 3 [default = 0xFFFFFFFFFFFFFFFF];
is($data->large_uint64, Math::BigInt->new("0xFFFFFFFFFFFFFFFF"));

##  optional  int32 small_int32  = 4 [default = -0x7FFFFFFF];
is($data->small_int32, -0x7FFFFFFF);

##  optional  int64 small_int64  = 5 [default = -0x7FFFFFFFFFFFFFFF];
is($data->small_int64, Math::BigInt->new("-0x7FFFFFFFFFFFFFFF"));

##  optional string utf8_string = 6 [default = "\341\210\264"];
is($data->utf8_string, "\341\210\264");

__END__

}

__END__

