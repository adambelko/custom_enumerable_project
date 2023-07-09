module Enumerable
  def my_all?
    my_each { |item| return false unless yield(item) }
    true
  end

  def my_any?
    my_each { |item| return true if yield(item) }
    false
  end

  def my_count
    count = 0
    if block_given?
      my_each { |item| count += 1 if yield(item) }
    else
      count = size
    end
    count
  end

  def my_each_with_index
    index = 0
    my_each do |item|
      yield(item, index)
      index += 1
    end
  end

  def my_inject(initial = nil)
    return unless block_given?

    arr = to_a
    accumulator = initial || arr.shift

    arr.my_each do |item|
      accumulator = yield(accumulator, item)
    end

    accumulator
  end

  def my_map
    new_array = []

    my_each do |item|
      current = yield(item)
      new_array << current
    end

    new_array
  end

  def my_none?
    my_each { |item| return false if yield(item) }
    true
  end

  def my_select
    new_array = []

    my_each { |item| new_array << item if yield(item) }

    new_array
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  def my_each
    for item in self
      yield(item)
    end
  end
end
