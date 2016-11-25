require 'byebug'
class Array
  # Write an Array method that returns a bubble-sorted copy of an array.
  # Do NOT call the built-in Array#sort method in your implementation.
  def bubble_sort(&prc)

    self.dup.bubble_sort!(&prc)
  end

  # You are not required to implement this; it's here as a suggestion :-)
  def bubble_sort!(&prc)
    prc = prc ||= Proc.new { |x, y| x <=> y }

    sorted = false

    until sorted
      sorted = true
      j = 1
      self.each_index do |i|
        next if i + 1 == self.length
        if prc.call(self[i], self[j]) == 1
          sorted = false
          self[i], self[j] = self[j], self[i]
        end
        j += 1
      end
    end
    self
  end

end

# Write a method that will transpose a rectangular matrix (array of arrays)
def transpose(matrix)
  array_new = Array.new(matrix.first.length) { Array.new(matrix.length) }

  array_new.each_index do |row_idx|
    matrix.length.times do |col_idx|
      array_new[row_idx][col_idx] = matrix[col_idx][row_idx]
    end
  end
  array_new

end

# Write a method called 'sum_rec' that
# recursively calculates the sum of an array of values
def sum_rec(nums)
  return 0 if nums.empty?
  # debugger
  nums.last + sum_rec(nums[0..-2])
end

class String
  # This method returns true if the string can be rearranged to form the
  # sentence passed as an argument.

  # Example:
  # "cats are cool".shuffled_sentence_detector("dogs are cool") => false
  # "cool cats are".shuffled_sentence_detector("cats are cool") => true

  def shuffled_sentence_detector(other)

    self_words = self.split(" ")
    other_words = other.split(" ")

    return false if self_words.length != other_words.length

    testing = true

    self_words.each do |word|
      testing = false unless other_words.include?(word)
    end

    testing

    other_words.each do |word|
      testing = false unless self_words.include?(word)
    end

    testing

  end

end

# Write a method that returns the largest prime factor of a number
def largest_prime_factor(num)
  return nil if num <= 1
  biggest_prime = 0
  count = 1

  factors = (2..num).select { |el| num % el == 0 }

  factors.each do |fact|
    biggest_prime = fact if is_prime?(fact)
  end

  biggest_prime

end

def is_prime?(num)
  (2...num).none? do |number|
    num % number == 0
  end
end

# You are not required to implement this; it's here as a suggestion :-)


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
  # Write an array method that returns an array made up of the
  # elements in the array that return `true` from the given block
  def my_select(&prc)
    array = []
    each do |el|
      array << el if prc.call(el)
    end
    array
  end

end
