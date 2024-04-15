const std = @import("std");
const FIXTypes = @import("datatypes/fundamental.zig");
const Int = FIXTypes.Int;

const writer = std.io.getStdOut().writer();
const Address = std.net.Address;

pub fn main() !void {
    const ip = [_]u8{ 127, 0, 0, 1 };
    const localhost = Address.initIp4(ip, 5555);

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();
    _ = allocator;

    var server = std.net.StreamServer.init(.{ .reuse_port = true });
    try server.listen(localhost);
    defer server.deinit();

    try writer.print("Listening on {} \n", .{server.listen_address.getPort()});

    while (true) {
        var client = try server.accept();
        defer client.stream.close();

        try writer.print("Connection received from addr {} \n", .{client.address});
        try writer.print("{} says  \n", .{client.address});
        try client.stream.reader().streamUntilDelimiter(writer, '\n', 1024);

        try writer.print("\n", .{});
        _ = try client.stream.writer().write("Hey now brown cow \n");
    }
}
