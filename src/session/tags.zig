const ftypes = @import("./../datatypes/fundamental.zig");
const tagvalue = @import("./../datatypes/tagvalue.zig");

const StandardHeaderComponent = struct {
    begin_string: tagvalue.FieldType(ftypes.StringBufferType(16)),
    body_length: tagvalue.FieldType(ftypes.Length),
    msg_type: tagvalue.FieldType(8),
    secure_data_len: ?tagvalue.FieldType(ftypes.Length),
    secure_data: ?tagvalue.FieldType(ftypes.StringBufferType(64)),
    message_encoding: ?tagvalue.FieldType(ftypes.DefaultString),
};

const StandardTrailerComponent = struct {
    signature_length: ?tagvalue.FieldType(ftypes.Length),
    signature: ?tagvalue.FieldType(ftypes.StringBufferType(64)),
    checksum: tagvalue.FieldType(ftypes.StringBufferType(3)),
};
