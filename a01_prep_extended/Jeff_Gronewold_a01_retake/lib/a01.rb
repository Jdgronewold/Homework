require 'byebug'
class Array
  # Write a method that binary searches an array for a target and returns its
  # index if found. Assume a sorted array

  # NB: YOU MUST WRITE THIS RECURSIVELY (searching half of the array every time).
  # We will not give you points if you visit every element in the array every time
  # you search.

  # For example, given the array [1, 2, 3, 4], you should NOT be checking
  # 1 first, then 2, then 3, then 4.

  def binary_search(target, &prc)
    return nil if self.empty?
    prc = prc ||= Proc.new { |x, y| x <=> y }
    middle = length / 2

    case prc.call(target, self[middle])
    when -1
      self.dup.take(middle).binary_search(target)
    when 0
      return middle
    when 1
      search_result = self.dup.drop(middle + 1).binary_search(target)
      search_result.nil? ? nil : search_result + middle + 1
    end


  end
end

class Array
  # Write an array method that returns a hash where the keys are any element
  # that appears in the array more than once, and the values are sorted arrays
  # of indices for those elements.
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



# Write a method that finds the first `n` Fibonacci numbers recursively.
def fibs_rec(count)
  if count <= 2
    [0,1].take(count)
  else
    fibs_prev = fibs_rec(count-1)
    fibs_prev << fibs_prev[-2] + fibs_prev[-1]
  end
end

class String
  # Write a method that finds all the unique substrings for a word

  def uniq_subs
    subs = []

    self.length.times do |start_pos|
      (start_pos..self.length).each do |end_pos|
        substring = self[start_pos..end_pos]
        subs << substring unless subs.include?(substring)
      end
    end
    subs
  end
end

def is_prime?(num)
  return true if num == 1
  return true if num == 2

  (2...num).none? do |number|
    num % number == 0
  end

end

# Write a method that sums the first n prime numbers starting with 2.
def sum_n_primes(n)
  return 0 if n == 0
  return 2 if n == 1

  primes = []
  # debugger
  count = 2
  until primes.length == n
    primes << count if is_prime?(count)
    count += 1
  end

  primes.inject(&:+)
end

class Array
  # Write a method that calls a passed block for each element of the array
  def my_each(&prc)
    i = 0
    until i == self.length
      prc.call(self[i])
      i += 1
    end
    self
  end
end

class Array
  # Write an array method that returns `true` if all elements in an array
  # return `true` for the passed block and `false` otherwise
  def my_all?(&prc)
    condition = true

    self.each do |el|
      condition = false unless prc.call(el)
    end

    condition
  end
end
