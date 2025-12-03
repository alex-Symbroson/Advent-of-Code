const std: type = @import("std");
const util: type = @import("util.zig");

var debug: bool = false;

const a = std.heap.page_allocator;
fn solve(file: []const u8) ![2]usize {
    const buf = try std.fs.cwd().readFileAlloc(a, file, 1 << 20);
    defer a.free(buf);

    debug = std.mem.eql(u8, file, "test.txt");

    var part1: usize = 0;
    var part2: usize = 0;

    part1 = 0;
    part2 = 0;

    var it = std.mem.splitScalar(u8, buf, '\n');
    while (it.next()) |bufline| {
        const line = std.mem.trim(u8, bufline, "\r\n");
        if (line.len == 0) continue;

        const num = try std.fmt.parseInt(usize, line, 10);

        if (debug) std.debug.print("{}\n", .{num});
    }

    return .{ part1, part2 };
}

pub fn main() !void {
    if (solve("test.txt") catch null) |result| {
        const test1, const test2 = result;
        std.debug.print("test 1: {} {}\n", .{ test1, test1 > 0 });
        std.debug.print("test 2: {} {}\n\n", .{ test2, test2 > 0 });
    }

    const result = try solve("input");
    const part1, const part2 = result;

    util.print("part 1: {} {}\n", .{ part1, part1 > 0 });
    util.print("part 2: {} {}\n", .{ part2, part2 > 0 });
}
