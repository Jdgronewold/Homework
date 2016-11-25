class Array
  def bubble_sort!
    # Without a proc
    sorted = false
    until sorted
      sorted = true

      each_index do |i|
        next if i + 1 == self.length
        j = i + 1
        if self[i] > self[j]
          sorted = false
          self[i], self[j] = self[j], self[i]
        end
      end
    end

    self
  end

#   def bubble_sort(list)
#   return list if list.size <= 1 # already sorted
#   swapped = true
#   while swapped do
#     swapped = false
#     0.upto(list.size-2) do |i|
#       if list[i] > list[i+1]
#         list[i], list[i+1] = list[i+1], list[i] # swap values
#         swapped = true
#       end
#     end
#   end
#
#   list
# end

  def bubble_sort!(&prc)
    # With a proc
    prc ||= Proc.new { |x, y| x <=> y }

    sorted = false
    until sorted
      sorted = true

      each_index do |i|
        next if i + 1 == self.length
        j = i + 1
        if prc.call(self[i], self[j]) == 1
          sorted = false
          self[i], self[j] = self[j], self[i]
        end
      end
    end

    self
  end

  def bubble_sort(&prc)
    self.dup.bubble_sort!(&prc)
  end
end

def my_quick_sort(&prc)
  prc ||= proc {|a,b| a <=> b}
  return self if length < 2

  pivot = first
  less = self[1..-1].select{|el| prc.call(el, pivot) == -1}
  more = self[1..-1].select{|el| prc.call(el, pivot) >= 0}

  less.my_quick_sort(&prc) + [pivot] + more.my_quick_sort(&prc)
end

def merge_sort_proc(&prc)
  prc ||= Proc.new {|x,y| x <=> y} #set proc conditionally equal to spec-described proc

  return self if self.length <= 1
  midpoint = self.length/2
  l = self.take(midpoint).merge_sort_proc(&prc)
  r = self.drop(midpoint).merge_sort_proc(&prc)
  Array.merge(l, r, &prc)
end

private
def self.merge(l, r, &prc)
  res =[]

  until l.empty? || r.empty?
    case prc.call(l.first, r.first)
    when -1
      res.push(l.shift)
    when 0 #doesn't matter either way
      res.push(l.shift)
    when 1
      res.push(r.shift)
    end
  end

  res.concat(l); res.concat(r) #add remaining, if any

  res
end
end

# class Array
#   def merge_sort
#     return self if count < 2
#
#     middle = count / 2
#
#     left, right = self.take(middle), self.drop(middle)
#     sorted_left, sorted_right = left.merge_sort, right.merge_sort
#
#     merge(sorted_left, sorted_right)
#   end
#
#   def merge(left, right)
#     merged_array = []
#     until left.empty? || right.empty?
#       merged_array <<
#         ((left.first < right.first) ? left.shift : right.shift)
#     end
#
#     merged_array + left + right
#   end
# end
