require 'byebug'
class Array

  # Monkey patch the Array class and add a my_inject method. If my_inject receives
  # no argument, then use the first element of the array as the default accumulator.

  def my_inject(accumulator = nil, &prc)
    self_dup = self.dup

    accum = accumulator ||= self_dup.shift

    self_dup.each do |el|
      accum = prc.call(accum, el)
    end

    accum

  end

end

# primes(num) returns an array of the first "num" primes.
# You may wish to use an is_prime? helper method.

def is_prime?(num)
  (2...num).none? do |number|
    num % number == 0
  end

end

def primes(num)
  found_primes = []

  number = 2
  until found_primes.length == num
    found_primes << number if is_prime?(number)
    number += 1
  end

  found_primes
end

# Write a recursive method that returns the first "num" factorial numbers.
# Note that the 1st factorial number is 0!, which equals 1. The 2nd factorial
# is 1!, the 3rd factorial is 2!, etc.


#### think about num - 1 when at home

def factorials_rec(num)
  return [] if num == 0
  return [1] if num == 1

  prev_factorial = factorials_rec(num - 1)
  current_factorial = (num - 1) * prev_factorial[-1]

  prev_factorial + [current_factorial]

end


class Array

  # Write an Array#dups method that will return a hash containing the indices of all
  # duplicate elements. The keys are the duplicate elements; the values are
  # arrays of their indices in ascending order, e.g.
  # [1, 3, 4, 3, 0, 3, 0].dups => { 3 => [1, 3, 5], 0 => [4, 6] }

  def dups

    duplicates = self.select { |el| self.count(el) > 1 }.uniq
    dup_hash = Hash.new { |h, k| h[k] = [] }

    duplicates.each do |duplicate|
      self.each_with_index do |el, idx|
        dup_hash[duplicate] << idx if el == duplicate
      end
    end

    dup_hash

  end


end

class String

  # Write a String#symmetric_substrings method that returns an array of substrings
  # that are palindromes, e.g. "cool".symmetric_substrings => ["oo"]
  # Only include substrings of length > 1.

  def symmetric_substrings
    sym_subs = []

    length.times do |start|
      (start..length).each do |end_pos|
        substring = self[start...end_pos]
        if substring.length > 1 && substring.reverse == substring
          sym_subs << substring
        end
      end
    end
    sym_subs

  end

end

class Array

  # Write an Array#merge_sort method; it should not modify the original array.

  def merge_sort(&prc)

    prc = prc ||= Proc.new { |x, y| x <=> y }

    return self if self.length <= 1

    midpoint = length / 2
    sorted_left = self.take(midpoint).merge_sort(&prc)
    sorted_right = self.drop(midpoint). merge_sort(&prc)

    Array.merge(sorted_left, sorted_right, &prc)


  end

  private

  def self.merge(left, right, &prc)
    merged = []

    until left.empty? || right.empty?
      case prc.call(left.first, right.first)
      when -1
        merged << left.shift
      when 0
        merged << left.shift
      when 1
        merged << right.shift
      end
    end

    merged.concat(left)
    merged.concat(right)

    merged

  end

  def quick_sort(&prc)

    prc = prc ||= Proc.new { |x, y| x <=> y }

    return self if self.length == 1

    pivot = self.first

    left = select { |el| prc.call(el, pivot) == -1 }
    middle = select { |el| prc.call(el, pivot) == 0}.drop(1)
    right = select { |el| prc.call(el, pivot) == 1 }

    left.quick_sort(&prc) + [pivot].concat(middle) + right.quick_sort(&prc)

  end

end
