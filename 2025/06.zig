const std = @import("std");
const a = std.heap.page_allocator;

const util = @import("util.zig");

var debug: bool = false;

fn calc(arr: []const []const u8, ops: []const u8, transpose: bool) !usize {
    var nums = std.ArrayList([]usize).init(a);
    defer nums.deinit();

    for (arr) |line| {
        const l = try util.splitScalar(a, line, ' ');
        const l2 = try util.map([]const u8, usize, a, l.items, util.parseN);
        try nums.append(l2.items);
    }

    const tnums: [][]usize = if (transpose) try util.transpose(usize, a, nums.items) else nums.items;
    var sum: usize = 0;
    for (0..tnums.len) |x| {
        const op: *const fn (usize, usize) usize = if (ops[x] == '+') util.add else util.mul;
        sum += util.reduce2(usize, tnums[x], op).?;
    }
    return sum;
}

fn solve(file: []const u8) ![2]usize {
    const buf = try std.fs.cwd().readFileAlloc(a, file, 1 << 20);
    defer a.free(buf);

    debug = std.mem.eql(u8, file, "test.txt");

    var lines = try util.splitScalar(a, buf, '\n');

    // last line = ops
    const ops_line = lines.pop().?;
    const sops = try util.splitScalar(a, ops_line, ' ');
    const ops = try util.flatten(u8, a, sops.items, "");

    const part1 = try calc(lines.items, ops, true);

    // transpose input and split on blanks
    const linesTrp = try util.transpose(u8, a, lines.items);
    for (0..linesTrp.len) |i| {
        if (util.trim(linesTrp[i]).len == 0) linesTrp[i] = "";
    }

    const str2 = try util.flatten(u8, a, linesTrp, ",");
    const lines2 = try util.splitSequence(a, str2, ",,");
    for (lines2.items) |l| {
        std.mem.replaceScalar(u8, l, ',', ' ');
    }

    const part2 = try calc(lines2.items, ops, false);

    return .{ part1, part2 };
}

pub fn main() !void {
    if (solve("test.txt") catch null) |result| {
        const test1, const test2 = result;
        std.debug.print("test 1: {} {}\n", .{ test1, test1 == 4277556 });
        std.debug.print("test 2: {} {}\n\n", .{ test2, test2 == 3263827 });
    }

    const result = try solve("input");
    const part1, const part2 = result;

    util.print("part 1: {} {}\n", .{ part1, part1 > 0 });
    util.print("part 2: {} {}\n", .{ part2, part2 > 0 });
}
