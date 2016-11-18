###
require 'byebug'

class Stack

  def initialize
    @stack = []
  end

  def add(el)
    @stack << el
  end

  def remove
    @stack.pop
  end

  def show
    puts @stack
  end
end


class Queue

  def initialize
    @queue = []
  end

  def add(el)
    @queue.unshift(el)
  end

  def remove
    @queue.pop
  end

  def show
    puts @queue
  end
end

class Map

  def initialize
    @map = []
  end

  def assign(new_key, new_value)

    @map << [new_key, new_value] if @map.empty?

    exists = false
    @map.delete_if do |key, _|
      key == new_key
    end

    @map << [new_key, new_value]

  end

  def show
    p @map
  end

  def remove(new_key)

    @map.delete_if do |key, _|
      key == new_key
    end

  end

  def lookup(new_key)
    show_entry = []
    @map.each do |key, value|
      show_entry << [key, value] if key == new_key
    end
    show_entry
  end

end
