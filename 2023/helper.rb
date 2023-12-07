# helper methods
module Helper
    def self.greet
        puts 'Hello from MyModule!'
    end
end

class Range
    def intersect?(other)
        !(max < other.begin || other.max < self.begin)
    end

    def intersection(other)
        return nil unless intersect?(other)

        [self.begin, other.begin].max..[max, other.max].min
    end

    def empty?
        size.zero?
    end

    def split(other)
        return nil unless s = self & other

        [self.begin...s.begin, max...s.max].filter { |v| !v.empty? }
    end

    def +(other)
        self.begin + other..max + other
    end
    alias & intersection
end

class Symbol
    def call(*, &)
        ->(caller, *rest) { caller.send(self, *rest, *, &) }
    end
end
