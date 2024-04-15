const ftypes = @import("./../../../datatypes/fundamental.zig");
const tagvalue = @import("./../../../datatypes/tagvalue.zig");

const UserRequestType = enum(u8) { Logon = 1, Status = 2, Logout = 3, PasswordChange = 4 };
const UserStatus = enum(u8) { LoggedIn = 1, NotLoggedIn = 2, UserNotRecognised = 3, PasswordIncorrect = 4, PasswordChanged = 5, Other = 6 };

const UserRequest = struct {
    const msg_type = "BE";
    user_request_id: tagvalue.FieldType(ftypes.StringBufferType(16)),
    user_request_type: tagvalue.FieldType(ftypes.Int),
    username: tagvalue.FieldType(ftypes.StringBufferType(128)),
    password: ?tagvalue.FieldType(ftypes.StringBufferType(32)),
    new_password: ?tagvalue.FieldType(ftypes.StringBufferType(32)),
    raw_data_length: ?tagvalue.FieldType(ftypes.Length),
    raw_data: ?tagvalue.FieldType(ftypes.StringBufferType(256)),
};

const UserResponse = struct {
    const msg_type = "BF";
    user_request_id: tagvalue.FieldType(ftypes.StringBufferType(16)),
    username: tagvalue.FieldType(ftypes.StringBufferType(128)),
    user_status: ?tagvalue.FieldType(ftypes.Int),
    user_status_text: ?tagvalue.FieldType(ftypes.StringBufferType(128)),
};
