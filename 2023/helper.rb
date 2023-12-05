# helper methods
module Helper
    def self.greet
        puts 'Hello from MyModule!'
    end
end

class Range
    def intersection(other)
        return nil if max < other.begin or other.max < self.begin

        [self.begin, other.begin].max..[max, other.max].min
    end
    alias & intersection
end
