const std = @import("std");

pub fn print(comptime fmt: []const u8, args: anytype) void {
    std.io.getStdOut().writer().print(fmt, args) catch {};
}

pub fn println(comptime fmt: []const u8, args: anytype) void {
    std.io.getStdOut().writer().print(fmt ++ "\n", args) catch {};
}

pub fn errexit(comptime fmt: []const u8, args: anytype) noreturn {
    std.debug.print(fmt, args);
    std.process.exit(1);
}

pub fn d2n(d: u8) u32 {
    return d - '0';
}

pub fn trim(s: []const u8) []const u8 {
    return std.mem.trim(u8, s, "\r\n\t ");
}

pub fn parseN(s: []const u8) !usize {
    return try std.fmt.parseInt(usize, trim(s), 10);
}

pub fn reverse_n(n: usize) usize {
    var x = n;
    var r: usize = 0;
    while (x != 0) : (x /= 10) r = r * 10 + x % 10;
    return r;
}
