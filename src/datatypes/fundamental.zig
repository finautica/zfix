const std = @import("std");

const ArgumentError = error{
    InvalidArgument,
};

/// Value Spaces as defined in ISO/IEC 144042007
// Using i32 to represent an integer, i believe this is enough
fn NumericalType(comptime T: type) type {
    return struct {
        value: T,

        pub fn init(value: T) NumericalType(T) {
            return .{ .value = value };
        }
    };
}

fn BufferType(comptime size: usize) type {
    return struct {
        value: [size]u8,

        pub fn init(value: []const u8) type {
            return .{ .value = value };
        }
    };
}

const Integer = NumericalType(i64);
const Size = NumericalType(usize);
const FloatingPoint = NumericalType(f64);
const Real = NumericalType(f64);
// Just lazy here
const Character = NumericalType(u8);
const BooleanType = NumericalType(bool);

const IntegerRangeError = error{OutOfBounds};
fn IntegerRange(comptime min: i64, comptime max: i64) type {
    return struct {
        pub fn init(value: i64) Integer {
            if (value < min or value > max) return IntegerRangeError.OutOfBounds;

            return .{ .value = value };
        }
    };
}

const OrdinalError = error{InvalidOrdinal};
const Ordinal = IntegerRange(1, std.math.maxInt(i64));

const Scaled = union(enum) {
    int: Integer,
    float: FloatingPoint,

    pub fn init(value: anytype) Scaled {
        return switch (value) {
            i64 => .{ .int = Integer.init(value) },
            f64 => .{ .float = FloatingPoint.init(value) },
            else => unreachable,
        };
    }
};

// We need to define a default buffer size
// Probably wasteful and not perfomant
const StringBufferError = error{InvalidRange};
pub fn StringBufferType(comptime maxsize: usize) type {
    return struct {
        value: [maxsize]u8,
        size: usize,
        pub fn init(value: []const u8) StringBufferError!type {
            try checkRange(value.len);

            return .{ .value = value, .size = value.len };
        }

        pub fn get(self: StringBufferType(maxsize)) StringBufferError![]const u8 {
            try checkRange(self.size);

            return self.value[0..self.size];
        }

        fn checkRange(size: usize) !void {
            if (size > maxsize) return StringBufferError.InvalidRange;
        }
    };
}

// Derived Types
pub const Int = Integer;
pub const TagNum = Ordinal;
pub const SeqNum = Ordinal;
pub const NumInGroup = Size;
pub const DayOfMonth = IntegerRange(1, 31);
pub const Float = FloatingPoint;
pub const Qty = Scaled;
pub const Price = Scaled;
pub const PriceOffset = Scaled;
pub const Amt = Scaled;
pub const Percentage = FloatingPoint;
pub const Char = Character;
pub const Boolean = BooleanType;
pub const Currency = BufferType(3);
pub const Country = BufferType(2);
pub const Exchange = BufferType(4);
pub const Length = Size;
// This is the base size, if you need more, you can just use the StringBufferType
pub const DefaultString = StringBufferType(64);
