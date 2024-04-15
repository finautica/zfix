const ftypes = @import("./../datatypes/fundamental.zig");
const tagvalue = @import("./../datatypes/tagvalue.zig");

const Heartbeat = struct {
    const msg_type = "BE";
    user_request_id: tagvalue.FieldType(ftypes.StringBufferType(16)),
    user_request_type: tagvalue.FieldType(ftypes.Int),
    username: tagvalue.FieldType(ftypes.StringBufferType(128)),
    password: ?tagvalue.FieldType(ftypes.StringBufferType(32)),
    new_password: ?tagvalue.FieldType(ftypes.StringBufferType(32)),
    raw_data_length: ?tagvalue.FieldType(ftypes.Length),
    raw_data: ?tagvalue.FieldType(ftypes.StringBufferType(256)),
};

const Logon = struct {
    const msg_type = "BF";
    user_request_id: tagvalue.FieldType(ftypes.StringBufferType(16)),
    username: tagvalue.FieldType(ftypes.StringBufferType(128)),
    user_status: ?tagvalue.FieldType(ftypes.Int),
    user_status_text: ?tagvalue.FieldType(ftypes.StringBufferType(128)),
};

const TestRequest = struct {
    const msg_type = "1";
    test_req_id: tagvalue.FieldType(ftypes.StringBufferType()),
};

const ResendRequest = struct {
    const msg_type = "2";
    begin_seq_no: tagvalue.FieldType(ftypes.StringBufferType()),
    end_seq_no: tagvalue.FieldType(ftypes.StringBufferType()),
};

// TODO: Add sessio reject reasons struct
const Reject = struct {
    const msg_type = "3";
    ref_seq_num: tagvalue.FieldType(ftypes.StringBufferType()),
    ref_tag_id: ?tagvalue.FieldType(ftypes.StringBufferType()),
    ref_msg_type: ?tagvalue.FieldType(ftypes.StringBufferType()),
    session_reject_reason: ?tagvalue.FieldType(ftypes.StringBufferType()),
    text: ?tagvalue.FieldType(ftypes.StringBufferType()),
    encoded_text_len: ?tagvalue.FieldType(ftypes.StringBufferType()),
    encoded_text: ?tagvalue.FieldType(ftypes.StringBufferType()),
};

const SequenceReset = struct {
    const msg_type = "4";
    gap_fill_flag: ?tagvalue.FieldType(ftypes.StringBufferType()),
    new_seq_no: tagvalue.FieldType(ftypes.StringBufferType()),
};

const Logout = struct {
    const msg_type = "5";
    text: ?tagvalue.FieldType(ftypes.StringBufferType()),
    encoded_text_len: ?tagvalue.FieldType(ftypes.StringBufferType()),
    encoded_text: ?tagvalue.FieldType(ftypes.StringBufferType()),
};
