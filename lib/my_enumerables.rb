# frozen_string_literal: true

module Enumerable
  def my_each_with_index
    index = 0
    my_each do |element|
      yield(element, index)
      index += 1
    end
    self
  end

  def my_all?
    my_each do |element|
      return false unless yield(element)
    end
    true
  end

  def my_any?
    my_each do |element|
      return true if yield(element)
    end
    false
  end

  def my_count
    if block_given?
      counter = 0
      my_each do |element|
        counter += 1 if yield(element)
      end
      counter
    else
      length
    end
  end

  def my_inject(initial_value = nil)
    accumulator = initial_value || self[0]

    start_index = initial_value ? 0 : 1

    self[start_index..].my_each do |element|
      accumulator = yield(accumulator, element)
    end
    accumulator
  end

  def my_map
    mapped_array = []
    my_each do |element|
      mapped_array << yield(element)
    end
    mapped_array
  end

  def my_none?
    my_each do |element|
      return false if yield(element)
    end
    true
  end

  def my_select
    selected_array = []
    my_each do |element|
      selected_array << element if yield(element)
    end
    selected_array
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  def my_each
    for element in self
      yield(element)
    end
    self
  end
end
