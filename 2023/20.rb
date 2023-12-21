chn = { 'rx' => ['&', 0, [], {}] }
$<.map { ch, *rcv = _1.tr('->,', '').split; chn[ch[1..]] = [ch[0], 0, rcv, {}] }

chn.map  do |name, ch|
    ch[2].map do |name2|
        ch2 = chn[name2]
        ch2[3][name] = 0 if ch2 && ch2[0] == '&'
    end
end

last = chn['rx'][3].keys[0]
mon = chn[last][3].keys.to_h { [_1, [0]] }

pulse = lambda { |name, freq, n|
    queue, count = Queue.new, [0, 0]
    queue << [name, freq]

    until queue.empty?
        name, freq, sender = queue.pop
        ch = chn[name]
        count[freq] += 1
        next if name == 'rx'

        mch = mon[name]
        if mch && chn[name][3].values.include?(0) && mch[-1] != n
            mch[-1] = n - mch.last; mch << n
            done = mon.values.none? { !_1[-3..-2]&.reduce(&:==) }
            return [0, 0, mon.values.map { _1[-2] }.reduce(&:lcm)] if done
        end

        if ch[0] == '%' && freq == 0
            ch[1] = 1 - ch[1]
            ch[2].map { queue << [_1, ch[1], name] }
        end

        if ch[0] == '&'
            ch[3][sender] = freq
            out = ch[3].values.all? { _1 == 1 }
            ch[2].map { queue << [_1, out ? 0 : 1, name] }
        end

        ch[2].map { queue << [_1, freq, name] } if ch[0] == 'b'
    end
    count
}

cnt = 1000.times.map { pulse.('roadcaster', 0, _1) }.transpose.map(&:sum)
puts "Part 1: #{cnt.reduce(:*)}"

res = 0
(0..).find { res = pulse.('roadcaster', 0, _1)[2] }
puts "Part 2: #{res}"
