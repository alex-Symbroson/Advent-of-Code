const std: type = @import("std");
const util: type = @import("util.zig");

var debug = true;

const a = std.heap.page_allocator;
fn solve(file: []const u8) ![2]i32 {
    const buf = try std.fs.cwd().readFileAlloc(a, file, 1 << 20);
    defer a.free(buf);

    var pos: i32 = 50;
    var it = std.mem.splitScalar(u8, buf, '\n');
    var part1: i32 = 0;
    var part2: i32 = 0;

    if (debug) std.debug.print("{}\n", .{pos});

    while (it.next()) |bufline| {
        const line = std.mem.trim(u8, bufline, "\r\n");
        if (line.len == 0) continue;

        const bufIdx = it.index.? - bufline.len - 1;
        buf[bufIdx] = if (line[0] == 'R') '+' else '-';
        const n = std.fmt.parseInt(i32, line, 10) catch 0;

        var during: i32 = 0;
        var after0: i32 = 0;
        const fix0: bool = pos == 0;

        pos += n;

        if (debug) std.debug.print("line: {s}\t= {}\t=> ", .{ line, pos });

        while (pos < 0) {
            pos += 100;
            if (pos != 0) during += 1;
        }
        if (fix0 and during > 0) during -= 1;

        while (pos >= 100) {
            pos -= 100;
            if (pos != 0) during += 1;
        }

        if (pos == 0) {
            part1 += 1;
            after0 += 1;
        }
        part2 += during + after0;
        if (debug) std.debug.print("{}\t({}, {} = {}+{} {})\n", .{ pos, part1, part2, during, after0, fix0 });
    }

    return .{ part1, part2 };
}

pub fn main() !void {
    if (solve("test.txt") catch null) |result| {
        const test1, const test2 = result;
        std.debug.print("test 1: {} {}\n", .{ test1, test1 == 3 });
        std.debug.print("test 2: {} {}\n", .{ test2, test2 == 6 });
    }

    // debug=false;

    if (solve("input") catch null) |result| {
        const part1, const part2 = result;

        util.print("Part 1: {} {}\n", .{ part1, part1 == 1165 });
        util.println("Part 2: {} {}\n", .{ part2, part2 > 5921 and part2 < 6528 and
            part2 != 6513 and part2 != 6399 and part2 != 6267 and part2 != 6367 });
    }
}
