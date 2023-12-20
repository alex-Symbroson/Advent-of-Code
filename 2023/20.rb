chn = { 'rx' => ['&', 0, []] }
$<.map { ch, *rcv = _1.tr('->,', '').split; chn[ch[1..]] = [ch[0], 0, rcv] }

chn.map  do |name, ch|
    ch[2].map do |name2|
        ch2 = chn[name2]
        next unless ch2 && ch2[0] == '&';

        ch2[3] ||= {}
        ch2[3][name] = 0
    end
end

last = chn['rx'][3].keys[0]
mon = chn[last][3].keys.map { [_1, [0]] }.to_h

pulse = lambda { |name, freq, n|
    queue, count = Queue.new, [0, 0, 0]
    queue << [name, freq]

    until queue.empty?
        name, freq, sender = queue.pop
        ch = chn[name]
        count[freq] += 1
        count[2] += 1 if name == 'rx' && freq == 0

        mon2 = mon.keys.filter { chn[_1][3].values.include?(0) }
        mon2.map { next if mon[_1][-1] == n; mon[_1][-1] = n - mon[_1].last; mon[_1] << n }
        p([n, mon2, mon]) if name == 'rx' && !mon2.empty?
        next if name == 'rx'

        # p queue.size if queue.size % 100_000 == 0

        if ch[0] == '%' && freq == 0
            ch[1] = 1 - ch[1]
            ch[2].map { queue << [_1, ch[1], name] }
            next
        end

        if ch[0] == '&'
            ch[3][sender] = freq
            out = ch[3].values.all? { _1 == 1 }
            ch[2].map { queue << [_1, out ? 0 : 1, name] }
            next
        end

        ch[2].map { queue << [_1, freq, name] } if ch[0] == 'b'
    end
    # p count if count[2] > 0
    count
}

# cnt = 1000.times.map { pulse.('roadcaster', 0) }.transpose.map(&:sum)
# puts "Part 1: #{cnt.reduce(:*)}"

puts "Part 2: #{(0..).find { pulse.('roadcaster', 0, _1)[2] == 1 }}"

# < 249709299106751
