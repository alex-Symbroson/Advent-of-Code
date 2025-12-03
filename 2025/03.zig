const std: type = @import("std");
const util: type = @import("util.zig");

var debug: bool = true;

fn select(line: []const u8, rem: u32) usize {
    if (rem == 0) return 0;
    const idx = std.mem.indexOfMax(u8, line[0 .. line.len - rem + 1]);
    return util.d2n(line[idx]) + 10 * select(line[idx + 1 ..], rem - 1);
}

const a = std.heap.page_allocator;
fn solve(file: []const u8) ![2]usize {
    const buf = try std.fs.cwd().readFileAlloc(a, file, 1 << 20);
    defer a.free(buf);

    var part1: usize = 0;
    var part2: usize = 0;

    var it = std.mem.splitScalar(u8, buf, '\n');
    while (it.next()) |bufline| {
        const line = std.mem.trim(u8, bufline, "\r\n");
        if (line.len == 0) continue;

        part1 += @intCast(util.reverse_n(select(line, 2)));
        part2 += @intCast(util.reverse_n(select(line, 12)));
    }

    return .{ part1, part2 };
}

pub fn main() !void {
    if (solve("test.txt") catch null) |result| {
        const test1, const test2 = result;
        std.debug.print("test 1: {} {}\n", .{ test1, test1 == 357 });
        std.debug.print("test 2: {} {}\n\n", .{ test2, test2 == 3121910778619 });
    }

    debug = false;
    const result = try solve("input");
    const part1, const part2 = result;

    util.print("Part 1: {} {}\n", .{ part1, part1 == 17229 });
    util.print("Part 2: {} {}\n", .{ part2, part2 == 170520923035051 });
}
