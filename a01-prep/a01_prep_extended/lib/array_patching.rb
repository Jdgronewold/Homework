require 'byebug'
class Array

  def my_each(&prc)
    i = 0

    until i == self.length
      prc.call(self[i])
      i += 1
    end

  end

  def my_each_with_index(&prc)

    i = 0

    until i == self.length
      prc.call(self[i], i)
      i += 1
    end

  end

  def my_select(&prc)
    new_arr = []

    my_each do |el|
      new_arr << el if prc.call(el)
    end
    new_arr

  end

  def my_reject(&prc)
    new_arr = []

    my_each do |el|
      new_arr << el unless prc.call(el)
    end
    new_arr

  end

  def my_any?(&prc)
    boolean = false

    my_each do |el|
      boolean = true if prc.call(el)
    end
    boolean

  end

  def my_all?(&prc)
    boolean = true

    my_each do |el|
      boolean = false unless prc.call(el)
    end
    boolean

  end

  # Takes a multi-dimentional array and returns a single array of all the elements
  # [1,[2,3], [4,[5]]].my_controlled_flatten(1) => [1,2,3,4,5]
  def my_flatten

    return self.first if self.length == 1
    add = []

    my_each do |el|
      el.is_a?(Array) ? add += el.my_flatten : add << el
    end

    add

  end

  # Write a version of flatten that only flattens n levels of an array.
  # E.g. If you have an array with 3 levels of nested arrays, and run
  # my_flatten(1), you should return an array with 2 levels of nested
  # arrays
  #
  # [1,[2,3], [4,[5]]].my_controlled_flatten(1) => [1,2,3,4,[5]]
  def my_controlled_flatten(n)
    if n == 0
      my_flatten
    else
      return self if n <= 0
      return self.first if self.length == 1
      add = []

      my_each do |el|
        if el.is_a?(Array)
          n -= 1

          one_lower = el.my_controlled_flatten(n)
          add += one_lower
        else
          add << el
        end
      end
      add
    end

  end

  def my_zip(*arrs)
    keep_arr = []

    self.length.times do |i|
      zipped = []
      zipped << self[i]
      arrs.each do |arr|
        zipped << arr[i]
      end
      keep_arr << zipped
    end
    keep_arr
  end

  def my_rotate(num = 1)
    total_rotate = num % self.length
    self.drop(total_rotate) + self.take(total_rotate)

  end

  def my_join(str = "")
    build = ""

    self.each_with_index do |thing, idx|
      build += thing.to_s
      build += str unless idx == self.length-1
    end
    build

  end

  def my_reverse
    self_dup = self.dup
    self_reverse = []

    self.length.times do
      self_reverse << self_dup.pop
    end
    self_reverse

  end

  #Write a monkey patch of quick sort that accepts a block
  # use a pivot
  def my_quick_sort(&prc)

    return self if self.length <= 1

    prc = prc ||= Proc.new { |x, y| x <=> y }

    pivot = self.first
    left = self[1..-1].select { |el| prc.call(el, pivot) <= 0 }
    right = self[1..-1].select { |el| prc.call(el, pivot) == 1 }

    left.my_quick_sort(&prc) + [pivot] + right.my_quick_sort(&prc)


  end

  # Write a monkey patch of binary search that accepts a comparison block:
  # E.g. [1, 2, 3, 4, 5, 7].my_bsearch(6) {|el, targ| el+1 <=> targ} => 4
  # sort in the middle and move to left or right
  def my_bsearch(target, &prc)
    return nil if self.empty?

    middle_idx = length / 2

    case prc.call(self[middle_idx], target)
    when -1
      self.dup.take(middle_idx).my_bsearch(target, &prc)
    when 0
      return middle_idx
    when 1
      search_res = self.dup.drop(middle_idx + 1).my_bsearch(target, &prc)
      search_res.nil? ? nil : search_res + middle_idx + 1
    end


  end

  def merge_sort(&prc)
    return self if self.length <= 1

    prc = prc ||= Proc.new { |x, y| x <=> y }

    middle = lenth / 2
    sorted_left = self.take(middle).merge_sort(&prc)
    sorted_right = self.drop(middle).merge_sort(&prc)

    Array.merge(left, right, &prc)


  end

  def self.merge

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
