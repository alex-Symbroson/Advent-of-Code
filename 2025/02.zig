const std: type = @import("std");

var debug: bool = false;
var sum: usize = 0;

fn testnum(len: usize, begin: usize, end: usize) ![2]usize {
    var n1: usize = 0;
    var n2: usize = 0;

    for (@intCast(begin)..@intCast(end + 1)) |i| {
        var has_part2: bool = false;

        for (0..len / 2 + 1) |l| {
            if (l == 0 or len % l != 0) continue;
            const base = try std.math.powi(usize, 10, l);

            var num: usize = 0;
            for (0..len / l) |_| num = num * base + i % base;

            if (l * 2 == len and i == num and i % base >= base / 10) n1 += i;
            if (l * 2 >= len and has_part2) break;

            if (i == num and i % base >= base / 10 and has_part2 == false) {
                n2 += i;
                sum += i;
                has_part2 = true;
            }
        }
    }
    return .{ n1, n2 };
}

const a = std.heap.page_allocator;
fn solve(file: []const u8) ![2]usize {
    const buf = try std.fs.cwd().readFileAlloc(a, file, 1 << 20);
    defer a.free(buf);

    debug = std.mem.eql(u8, file, "test.txt");

    var part1: usize = 0;
    var part2: usize = 0;
    sum = 0;

    var it = std.mem.splitScalar(u8, buf, ',');
    while (it.next()) |bufline| {
        const line = std.mem.trim(u8, bufline, "\r\n");
        if (line.len == 0) continue;

        var it2 = std.mem.splitScalar(u8, line, '-');
        const beginStr = it2.next() orelse "";
        const endStr = it2.next() orelse "";

        const begin = try std.fmt.parseInt(usize, beginStr, 10);
        const end = try std.fmt.parseInt(usize, endStr, 10);

        const res1 = try testnum(beginStr.len, begin, end);
        part1 += res1[0];
        part2 += res1[1];

        if (beginStr.len != endStr.len) {
            const res2 = try testnum(endStr.len, begin, end);
            part1 += res2[0];
            part2 += res2[1];
        }
    }

    return .{ part1, part2 };
}

pub fn main() !void {
    if (solve("test.txt") catch null) |result| {
        const test1, const test2 = result;
        std.debug.print("test 1: {} {}\n", .{ test1, test1 == 1227775554 });
        std.debug.print("test 2: {} {}\n\n", .{ test2, test2 == 4174379265 });
    }

    const result = try solve("input");
    const part1, const part2 = result;

    std.debug.print("part 1: {} {}\n", .{ part1, part1 == 64215794229 });
    std.debug.print("part 2: {} {}\n", .{ part2, part2 == 85513235135 });
}
