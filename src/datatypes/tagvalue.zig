const ftypes = @import("fundamental.zig");

// We have no guarantee that the ValueType passed will be a valid one
// so take care how you use it.
pub fn FieldType(comptime ValueType: type) type {
    return struct { Tag: ftypes.TagNum, Value: ValueType };
}
