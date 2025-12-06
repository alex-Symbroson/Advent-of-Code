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

pub fn transpose(
    comptime T: type,
    a: std.mem.Allocator,
    arr: []const []const T,
) ![][]T {
    const rows = arr.len;
    if (rows == 0) return &[_][]T{};

    const cols = arr[0].len;

    var result = try a.alloc([]T, cols);
    for (0..cols) |x| {
        result[x] = try a.alloc(T, rows);
        for (0..rows) |y| {
            result[x][y] = arr[y][x];
        }
    }
    return result;
}

pub fn reduce(comptime T: type, comptime V: type, arr: []const T, f: *const fn (type, type, V, T) V, initial: V) V {
    if (arr.len == 0) return initial;
    var res = initial;
    for (arr) |v| {
        res = f(T, V, res, v);
    }
    return res;
}

pub fn reduce2(comptime T: type, arr: []const T, f: *const fn (T, T) T) ?T {
    if (arr.len == 0) return null;
    var res = arr[0];
    for (1..arr.len) |i| {
        res = f(res, arr[i]);
    }
    return res;
}

pub fn add(a: usize, b: usize) usize {
    return a + b;
}

pub fn mul(a: usize, b: usize) usize {
    return a * b;
}

pub fn flatten(
    comptime T: type,
    allocator: std.mem.Allocator,
    matrix: []const []const T,
    sep: []const T,
) ![]T {
    var total: usize = 0;
    for (matrix) |row| total += row.len;
    if (matrix.len > 1) total += sep.len * (matrix.len - 1);

    var out = try allocator.alloc(T, total);
    var p: usize = 0;

    for (matrix, 0..) |row, i| {
        if (i > 0) {
            std.mem.copyForwards(T, out[p..][0..sep.len], sep);
            p += sep.len;
        }

        std.mem.copyForwards(T, out[p..][0..row.len], row);
        p += row.len;
    }

    return out;
}

pub fn splitSequence(
    a: std.mem.Allocator,
    input: []const u8,
    delimiter: []const u8,
) !std.ArrayList([]u8) {
    var out = std.ArrayList([]u8).init(a);

    var it = std.mem.splitSequence(u8, input, delimiter);
    while (it.next()) |chunk| {
        if (chunk.len > 0)
            try out.append(try a.dupe(u8, chunk));
    }
    return out;
}

pub fn splitScalar(
    allocator: std.mem.Allocator,
    input: []const u8,
    delimiter: u8,
) !std.ArrayList([]const u8) {
    var out = std.ArrayList([]const u8).init(allocator);

    var it = std.mem.splitScalar(u8, input, delimiter);
    while (it.next()) |chunk| {
        if (chunk.len > 0)
            try out.append(chunk);
    }
    return out;
}

pub fn map(
    comptime T: type,
    comptime U: type,
    allocator: std.mem.Allocator,
    items: []const T,
    func: anytype,
) !std.ArrayList(U) {
    var out = std.ArrayList(U).init(allocator);
    for (items) |item| {
        try out.append(try func(item));
    }
    return out;
}
