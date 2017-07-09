# Rebuilding Enumerable Methods
# we've rebuilt all the most-often used Enumerable methods and 
# added them to the Enumerable module.

module Enumerable

# For #each, we iterate through an object's elements
# one at a time, using an index variable.
# since #each doesn't really need to return anything,
# it returns itself when it's done.
  
  def my_each
    i = 0
    while i < self.size
      yield(self[i])
      i += 1
    end
    self
  end
  
# #each_with_index is similar, but allows us to call
# a block with two arguments, the item and its index.
  
  def my_each_with_index
    i = 0
    while i < self.size
      yield(self[i], i)
      i += 1
    end
    self
  end
  
# #select builds an array from the elements that
# return true after passing through the given block.
  
  def my_select
    new_arr = []
    self.my_each do |ele|
      new_arr << ele if yield ele
    end
    new_arr
  end
  
# #all? returns true unless a pass through the block
# returns false. If no block is given, it returns true
# when none of the items are false or nil.
  
  def my_all?
    return unless block_given?
    self.my_each do |ele|
      if not yield ele then return false
      end
    end
    return true
  end
    
# #any? is almost identical to #all? except it returns
# true if ANY iteration returns true.
  
  def my_any?
    return unless block_given?
    self.my_each do |ele|
      if yield ele then return true
      end
    end
    return false
  end
    
# #none? is very similar as well, but it only returns
# true if every pass through the block returns false.
  
  def my_none?
    return unless block_given?
    self.my_each do |ele|
      if yield ele then return false
      end
    end
    return true
  end
    
# #count takes an optional block or parameter and adds
# up all the elements in a collection. If a block is passed,
# #count will only count the iterations that return true.
# If an argument is passed, count will only add the elements
# that match it. Otherwise it just counts the total elements.
  
  def my_count(a = nil)
    total = 0
    if block_given?
      self.my_each do |ele|
        total += 1 if yield ele
      end
    elsif a
      self.my_each do |ele|
        if ele == a
          total += 1
        end
      end
    else
      self.my_each do |ele|
        total += 1
      end
    end
    total
  end
    
# #map builds an array with the results of each iteration
# through the block. It can also perform the same task
# using a proc. If given neither a proc nor a block, it
# returns an enumerator.
  
  def my_map(proc = nil)
    new_arr = []
    if proc
      self.my_each do |ele|
        new_arr << proc.call(ele)
      end
    elsif block_given?
      self.my_each do |ele|
        new_ele = yield ele
        new_arr << new_ele
      end
    else
      new_arr = self.to_enum
    end
    new_arr
  end
    
# #inject combines all the elements of a collection with a
# binary operation, using a block and an optional argument
# for its initial value. If no initial value is given,
# #inject will use the first element of the collection.
  
  def my_inject(*args)
    if args
      memo = args[0]
      s = 0
    else
      memo = self[0]
      s = 1
    end
    self[s..self.length].my_each do |ele|
      memo = yield(memo,ele)
    end
    memo
  end
  
  def multiply_els
    self.my_inject(1){|memo,ele| memo * ele}
  end  
end