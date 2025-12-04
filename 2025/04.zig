const std = @import("std");
const util = @import("util.zig");

var debug: bool = true;
var map2: [][]u8 = undefined;

fn step(map: [][]u8) ?u32 {
    var sum: u32 = 0;

    for (0..map.len) |y| {
        for (0..map[y].len) |x| {
            var adj: u32 = 0;
            if (map[y][x] != '@') continue;

            if (debug) std.debug.print("{c} ", .{map[y][x]});
            for (0..3) |dy| {
                for (0..3) |dx| {
                    if (dx == 1 and dy == 1) continue;
                    if (y + dy <= 0 or y + dy - 1 >= map.len) continue;
                    if (x + dx <= 0 or x + dx - 1 >= map[y + dy - 1].len) continue;
                    const c: u8 = map[y + dy - 1][x + dx - 1];
                    // if (debug) std.debug.print("({} {} {c})", .{ dy, dx, map[y + dy - 1][x + dx - 1] });
                    if (debug) std.debug.print("{c}", .{map[y + dy - 1][x + dx - 1]});
                    if (c == '@') adj += 1;
                }
            }
            if (adj < 4) sum += 1;
            if (adj < 4) map2[y][x] = '.';
            if (debug) std.debug.print(" {}\n", .{adj});
        }
        if (debug) std.debug.print("{}\n", .{sum});
    }

    for (0..map.len) |y|
        @memcpy(map[y], map2[y]);

    return if (sum == 0) null else sum;
}

const a = std.heap.page_allocator;
fn solve(file: []const u8) ![2]usize {
    const buf = try std.fs.cwd().readFileAlloc(a, file, 1 << 20);
    defer a.free(buf);

    var part1: usize = 0;
    var part2: usize = 0;

    part2 = 0;

    var list = std.ArrayList([]u8).init(a);
    var list2 = std.ArrayList([]u8).init(a);
    var it = std.mem.splitScalar(u8, buf, '\n');
    while (it.next()) |val| {
        try list.append(try a.dupe(u8, val));
        try list2.append(try a.dupe(u8, val));
    }

    map2 = list2.items;
    part1 = step(list.items) orelse 0;

    part2 = part1;
    while (step(list.items)) |n| part2 += n;

    return .{ part1, part2 };
}

pub fn main() !void {
    if (solve("test.txt") catch null) |result| {
        const test1, const test2 = result;
        std.debug.print("test 1: {} {}\n", .{ test1, test1 == 13 });
        std.debug.print("test 2: {} {}\n\n", .{ test2, test2 == 43 });
    }

    debug = false;

    const result = try solve("input");
    const part1, const part2 = result;

    util.print("Part 1: {} {}\n", .{ part1, part1 == 1493 });
    util.print("Part 2: {} {}\n", .{ part2, part2 == 9194 });
}
