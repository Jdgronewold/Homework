require 'byebug'
class Array

  # Monkey patch the Array class and add a my_inject method. If my_inject receives
  # no argument, then use the first element of the array as the default accumulator.

  def my_inject(accumulator = nil, &prc)
    accum = accumulator ||= self.dup.shift

    self.each do |el|
      accum = prc.call(accum, el)
    end
    accum
  end
end

# primes(num) returns an array of the first "num" primes.
# You may wish to use an is_prime? helper method.

def is_prime?(num)
  (2...num).none? do |el|
    num % el == 0
  end
end

def primes(num)

  found_primes = []
  val = 2
  until found_primes.length == num
    found_primes << val if is_prime?(val)
    val += 1
  end

  found_primes

end

# Write a recursive method that returns the first "num" factorial numbers.
# Note that the 1st factorial number is 0!, which equals 1. The 2nd factorial
# is 1!, the 3rd factorial is 2!, etc.


#### think about num - 1 when at home

def factorials_rec(num)
  # return [1] if num == 0
  return [1] if num == 1

  prev_factorial = factorials_rec(num - 1)
  current_factorial = (num-1) * prev_factorial.last

  prev_factorial + [current_factorial]


end

class Array

  # Write an Array#dups method that will return a hash containing the indices of all
  # duplicate elements. The keys are the duplicate elements; the values are
  # arrays of their indices in ascending order, e.g.
  # [1, 3, 4, 3, 0, 3, 0].dups => { 3 => [1, 3, 5], 0 => [4, 6] }

  def dups

    duplicates = self.select { |el| count(el) > 1 }.uniq
    dup_hash = Hash.new { |h, k| h[k] = [] }

    duplicates.each do |duplicate|
      self.each_with_index do |el, idx|
        dup_hash[el] << idx if el == duplicate
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
    symm_subs = []

    (length-1).times do |start|
      (1...length).each do |end_frag|
        substring = self[start..end_frag]
        add_sub = substring == substring.reverse && substring.length > 1
        symm_subs << substring if add_sub
      end
    end

    symm_subs

  end
end

class Array

  # Write an Array#merge_sort method; it should not modify the original array.

  def merge_sort(&prc)

    prc ||= Proc.new { |x, y| x <=> y }

    return self if length <= 1

    middle_idx = length / 2
    left_array = self.take(middle_idx)
    right_array = self.drop(middle_idx)

    sorted_left = left_array.merge_sort(&prc)
    sorted_right = right_array.merge_sort(&prc)

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
end
