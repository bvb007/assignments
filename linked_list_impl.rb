


class LinkedList
  def initialize
    @elements = []
   end
   attr_accessor :elements
   
   def add(obj)
     elements.push(obj)
   end
   
   def list
     puts elements.join(", ")
   end
end

Car = Class.new

l = LinkedList.new
l.add(1)
l.add("a")
l.list
l.add(Car.new)
l.list
