
# Defines a node in the singly linked list
class Node
  attr_reader :data # allow external entities to read value but not write
  attr_accessor :next # allow external entities to read or write next node

  def initialize(value)
    @data = value
    @next = nil
  end
end

# Defines the singly linked list
class LinkedList
  def initialize
    @head = nil # keep the head private. Not accessible outside this class
  end

  # method to add a new node with the specific data value in the linked list
  # insert the new node at the beginning of the linked list
  def insert(value)
    node = Node.new(value)
    if @head == nil
      @head = node
    else
      node.next = @head
      @head = node
    end

    # puts "Not implemented"
  end

  # method to find if the linked list contains a node with specified value
  # returns true if found, false otherwise
  def search(value)
    current = @head
    while current != nil
      if current.data == value
        return true
      else
        current = current.next
      end

    end
    return false

    # puts "Not implemented"
  end

  # method to return the max value in the linked list
  # returns the data value and not the node
  def find_max

    current = @head
    max = current.data
    while current != nil
      if current.data > max
        max = current.data
      else
        current = current.next
      end
    end
    return max
    # puts "Not implemented"
  end

  # method to return the min value in the linked list
  # returns the data value and not the node
  def find_min
    current = @head
    min = current.data
    while current != nil
      if current.data < min
        min = current.data
      else
        current = current.next
      end
    end
    return min
    # puts "Not implemented"
  end

  # method that returns the length of the singly linked list
  def length
    return 0 if @head == nil
    current = @head
    size = 0
    while current != nil do
      size += 1
      current = current.next
    end
    return size
  end

  # method to return the value of the nth element from the beginning
  # assume indexing starts at 0 while counting to n
  def find_nth_from_beginning(n)
    current = @head
    size = 0
    until size == n do
      size += 1
      current = current.next
    end
    return current.data
  end

  # method to insert a new node with specific data value, assuming the linked
  # list is sorted in ascending order
  def insert_ascending(value)
    node = Node.new(value)
    current = @head
    # puts "helloooo #{current.data}"
    # puts "Value: #{value}"
    inserted = false
    while current != nil && !inserted do
      # puts "Count: #{count}"
      if current.data < value
        # puts "Current.data: #{current.data}"
        if current.next == nil
          # puts "Reached the end"
          current.next = node
          inserted = true
        elsif current.next.data > value
          # puts "Found the magic spot"
          node.next = current.next
          current.next = node
          inserted = true
        else
          current = current.next
        end
      else
        current = current.next
      end
    end

    # puts "Not implemented"
  end

  # method to print all the values in the linked list
  def visit
    current = @head
    while current != nil do
        print "#{current.data}  "
        current = current.next
    end
    puts
    # puts "Not implemented"
  end

  # method to delete the first node found with specified value
  def delete(value)
    return if @head == nil
    if @head.data == value
      @head = @head.next
    else
      current = @head
      while current.next != nil do
        if current.next.data == value
            current.next = current.next.next
        else
          current = current.next
        end
      end
    end

  end

  # method to reverse the singly linked list
  # note: the nodes should be moved and not just the values in the nodes
  def reverse
    current = @head
    previous = nil

    until current == nil do
      temp = current.next
      current.next = previous
      previous = current
      current = temp
    end
    @head = previous
    # puts "Not implemented"
  end

  ## Advanced Exercises
  # returns the value at the middle element in the singly linked list
  def find_middle_value
    return if @head == nil
    return @head.data if @head.next == nil

    slow = @head
    fast = @head.next

    while fast != nil do
      slow = slow.next
      fast = fast.next
      if fast != nil
        fast = fast.next
      end
    end
    return slow.data
    # puts "Not implemented"
  end

  # find the nth node from the end and return its value
  # assume indexing starts at 0 while counting to n
  def find_nth_from_end(n)
    return if @head == nil
    i = 0
    current = @head

    until i == n do
      current = current.next
      i += 1
    end

    trailing_current = @head
    # puts "current: #{current.data}"
    # puts "trailing: #{trailing_current.data}"
    until current.next == nil do
      current = current.next
      trailing_current = trailing_current.next
      # puts "current: #{current.data}"
      # puts "trailing: #{trailing_current.data}"
    end

    # puts "****Trailing: #{trailing_current.data}"
    return trailing_current.data# puts "Not implemented"
  end

  # checks if the linked list has a cycle. A cycle exists if any node in the
  # linked list links to a node already visited.
  # returns true if a cycle is found, false otherwise.
  def has_cycle
    return false if @head == nil
    return false if @head.next == nil

    slow = @head
    fast = @head

    while fast != nil do
      slow = slow.next
      fast = fast.next
      fast = fast.next if fast != nil
      return true if fast == slow
    end
    return false
    # puts "Not implemented"
  end

  # Creates a cycle in the linked list for testing purposes
  # Assumes the linked list has at least one node
  def create_cycle
    return if @head == nil # don't do anything if the linked list is empty

    # navigate to last node
    current = @head
    while current.next != nil
      current = current.next
    end

    current.next = @head # make the last node link to first node
  end
end

## --- END of class definitions --- ##

# Create an object of linked list class
my_linked_list = LinkedList.new()

puts "\n*******  Add Values to List *******"
# Add some values to the linked list
puts "Adding 5, 3 and 1 to the linked list."
my_linked_list.insert(5)
my_linked_list.insert(3)
my_linked_list.insert(1)

# print all elements
puts "Printing elements in the linked list:"
my_linked_list.visit

puts "\n*******  Find Value at Nth Node *******"
# Find the value at the nth node
puts "Confirming values in the linked list using find_nth_from_beginning method."
value = my_linked_list.find_nth_from_beginning(2)
puts "BUG: Value at index 2 should be 5 and is #{value}" if value != 5
value = my_linked_list.find_nth_from_beginning(1)
puts "BUG: Value at index 1 should be 3 and is #{value}" if value != 3
value = my_linked_list.find_nth_from_beginning(0)
puts "BUG: Value at index 0 should be 1 and is #{value}" if value != 1

# print all elements
puts "Printing elements in the linked list:"
my_linked_list.visit
puts "length #{my_linked_list.length}"

puts "\n*******  Insert Ascending *******"
# Insert ascending
puts "Adding 4 in ascending order."
my_linked_list.insert_ascending(4)

# check newly inserted value
puts "Checking values by calling find_nth_from_beginning method."
value = my_linked_list.find_nth_from_beginning(2)
puts "BUG: Value at index 2 should be 4 and is #{value}" if value != 4
value = my_linked_list.find_nth_from_beginning(3)
puts "BUG: Value at index 3 should be 5 and is #{value}" if value != 5
value = my_linked_list.find_nth_from_beginning(1)
puts "BUG: Value at index 1 should be 3 and is #{value}" if value != 3

# Insert ascending
puts "Adding 6 in ascening order."
my_linked_list.insert_ascending(6)

# print all elements
puts "Printing elements in the linked list:"
my_linked_list.visit

# vaidate length
puts "Confirming length of the linked list."
my_linked_list_length = my_linked_list.length
puts "BUG: Length should be 5 and not #{my_linked_list_length}" if my_linked_list_length != 5


puts "\n*******  Find Min & Max *******"
# find min and max
puts "Confirming min and max values in the linked list."
min = my_linked_list.find_min
puts "BUG: Min value should be 1 and not #{min}" if min != 1
max = my_linked_list.find_max
puts "BUG: Max value should be 5 and not #{max}" if max != 6

puts "\n*******  Delete Value *******"
# delete value
puts "Deleting node with value 5 from the linked list."
my_linked_list.delete(5)
# print all elements
puts "Printing elements in the linked list:"
my_linked_list.visit
# validate length
puts "Confirming length of the linked list."
my_linked_list_length = my_linked_list.length
puts "BUG: Length should be 4 and not #{my_linked_list_length}" if my_linked_list_length != 4

# delete value
puts "Deleting node with value 1 from the linked list."
my_linked_list.delete(1)
# print all elements
puts "Printing elements in the linked list:"
my_linked_list.visit
# validate length
puts "Confirming length of the linked list."
my_linked_list_length = my_linked_list.length
puts "BUG: Length should be 3 and not #{my_linked_list_length}" if my_linked_list_length != 3

puts "\n*******  Find Middle Element *******"
# find middle element
puts "Confirming middle value in the linked list."
middle = my_linked_list.find_middle_value
puts "BUG: Middle value should be 4 and not #{middle}" if middle != 4

puts "\n*******  Reverse Linked List *******"
# reverse the linked list
puts "Reversing the linked list."
my_linked_list.reverse
# print all elements
puts "Printing elements in the linked list:"
my_linked_list.visit
# verify the reversed list
puts "Verifying the reveresed linked list by calling find_nth_from_beginning method."
value = my_linked_list.find_nth_from_beginning(2)
puts "BUG: Value at index 2 should be 3 and is #{value}" if value != 3
value = my_linked_list.find_nth_from_beginning(1)
puts "BUG: Value at index 1 should be 4 and is #{value}" if value != 4
value = my_linked_list.find_nth_from_beginning(0)
puts "BUG: Value at index 0 should be 6 and is #{value}" if value != 6

puts "\n*******  Find Nth From End *******"
# nth from the end
puts "Verifying find_nth_from_end method."
value = my_linked_list.find_nth_from_end(0)
puts "BUG: Value at index 0 from the end, should be 3 and is #{value}" if value != 3
value = my_linked_list.find_nth_from_end(1)
puts "BUG: Value at index 1 from the end, should be 4 and is #{value}" if value != 4
value = my_linked_list.find_nth_from_end(2)
puts "BUG: Value at index 2 from the end, should be 6 and is #{value}" if value != 6

puts "\n*******  Create Cycle *******"
# check for cycle
puts "Checking the linked list for cycle."
puts "BUG: Should not have a cycle." if my_linked_list.has_cycle

# create cycle and then test for it
puts "Creating a cycle in the linked list."
my_linked_list.create_cycle
puts "Checking the linked list for cycle."
puts "BUG: Should not have a cycle." if !(my_linked_list.has_cycle)
