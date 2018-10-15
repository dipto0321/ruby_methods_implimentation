module Enumerable
# my_each
  def my_each
    for i in 0...self.size
      self.class == Hash ? yield(self.keys[i], self.values[i],i) : yield(self[i],i)
    end
  end

#   my_select
  def my_select
    output = self.class == Array ? [] : {}
    for i in 0...self.size
      output.push(self[i]) if self.class == Array && yield(self[i],i)
      output[self.keys[i]] = self.values[i] if self.class == Hash && yield(self.keys[i],self.values[i])
    end
    output
  end

  #my_all?
  def my_all?
    for i in 0...self.size
      return false if (self.class == Array && !yield(self[i],i)) || (self.class == Hash && !yield(self.keys[i],self.values[i]))
      # self.class == Array && !yield(self[i],i) || self.class == Hash && !yield(self.keys[i],self.values[i])
    end
    true
  end
  #my_any?
  def my_any?
    for i in 0...self.size
      return true if (self.class == Array && yield(self[i],i)) || (self.class == Hash && yield(self.keys[i],self.values[i]))
      # self.class == Array && !yield(self[i],i) || self.class == Hash && !yield(self.keys[i],self.values[i])
    end
    false
  end
  #my_none?
  def my_none?
    for i in 0...self.size
      return true if (self.class == Array && !yield(self[i],i)) || (self.class == Hash && !yield(self.keys[i],self.values[i]))
      # self.class == Array && !yield(self[i],i) || self.class == Hash && !yield(self.keys[i],self.values[i])
    end
    false
  end
  #my_count
  def my_count(arg = nil)
    count = 0
    return self.size if arg.nil? && !block_given?
    block_given? && arg.nil? ? self.my_each {|el| count += 1 if yield(el)} : self.my_each {|x| count += 1 if x == arg }
    count
  end
end

a = {
  :apple => "hello",
  :orange => "hi"
}
b = [5,4,7,9,8,6]

# a.my_each {|key , value| puts "#{key} : #{value}"}
# b.my_each {|value| puts "#{value}"}
# puts a.my_select {|k,v| k == :apple}
# p b.my_select {|x| x % 2 == 0}

# puts a.my_all? {|k,v| k == :apple}
# puts b.my_all? {|v,i| v > 0}
# puts a.my_any? {|k,v| k == :apple}
# puts b.my_any? {|v,i| v > 0}
# puts a.my_none? {|k,v| k == :banana}
# puts b.my_none? {|v,i| v < 0}

ary = [1, 2, 4, 2]
# puts ary.my_count(2)
puts ary.my_count{ |x| x % 2 ==0 }