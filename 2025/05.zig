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

    var ranges = std.ArrayList([2]usize).init(a);
    var checkIngs = false;

    var it = std.mem.splitScalar(u8, buf, '\n');
    while (it.next()) |bufline| {
        const line = util.trim(bufline);
        if (line.len == 0) {
            checkIngs = true;
            continue;
        }

        if (!checkIngs) {
            var it2 = std.mem.splitScalar(u8, line, '-');
            const n1 = try util.parseN(it2.next().?);
            const n2 = try util.parseN(it2.next().?);
            try ranges.append(.{ n1, n2 });
            continue;
        }

        const num = try util.parseN(line);
        for (ranges.items) |itm| {
            if (num >= itm[0] and num <= itm[1]) {
                part1 += 1;
                break;
            }
        }
    }

    for (0..ranges.items.len) |i| {
        for (0..ranges.items.len) |j| {
            if (i == j) continue;

            var r1 = &ranges.items[i];
            var r2 = &ranges.items[j];

            if ((r1[1] >= r2[0] and r1[1] <= r2[1]) or (r1[0] <= r2[1] and r1[0] >= r2[0])) {
                r1[0] = if (r1[0] < r2[0]) r1[0] else r2[0];
                r1[1] = if (r1[1] > r2[1]) r1[1] else r2[1];
                r2[1] = r2[0] - 1; // effectively delete
            }
        }
    }

    for (ranges.items) |itm| {
        if (debug) std.debug.print("sum: {}-{}\n", .{ itm[0], itm[1] });
        part2 += itm[1] + 1 - itm[0];
    }

    return .{ part1, part2 };
}

pub fn main() !void {
    if (solve("test.txt") catch null) |result| {
        const test1, const test2 = result;
        std.debug.print("test 1: {} {}\n", .{ test1, test1 == 3 });
        std.debug.print("test 2: {} {}\n\n", .{ test2, test2 == 14 });
    }

    const result = try solve("input");
    const part1, const part2 = result;

    util.print("part 1: {} {}\n", .{ part1, part1 == 520 });
    util.print("part 2: {} {}\n", .{ part2, part2 > 0 });
}
