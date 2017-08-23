
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
    node_to_insert = Node.new(value) # setting up our new node

    node_to_insert.next = @head # telling new node to point at current head

    @head = node_to_insert # setting up the new head
  end

  # method to find if the linked list contains a node with specified value
  # returns true if found, false otherwise
  def search(value)
    current = @head

    while current != nil
      if current.data == value
        return true
      end
      current = current.next
    end
    return false # we have checked everything
  end

  # method to return the max value in the linked list
  # returns the data value and not the node
  def find_max
    max = 0
    current = @head

    while current != nil
      if current.data > max
        max = current.data
      end
      current = current.next
    end
    return max
  end

  # method to return the min value in the linked list
  # returns the data value and not the node
  def find_min
    current = @head

    if current == nil
      return nil
    end

    min = current.data

    while current != nil
      if current.data < min
        min = current.data
      end
      current = current.next
    end
    return min
  end

  # method that returns the length of the singly linked list
  def length
    current = @head
    count = 0

    if @head == nil
      return 0
    end

    while current != nil
      count += 1
      current = current.next
    end
    return count
  end

  # method to return the value of the nth element from the beginning
  # assume indexing starts at 0 while counting to n
  def find_nth_from_beginning(n)
    current = @head
    count = 0

    while current != nil
      if count == n
        return current.data
      end
      current = current.next
      count += 1
    end
    return nil
  end

  # method to insert a new node with specific data value, assuming the linked
  # list is sorted in ascending order
  def insert_ascending(value)
    current = @head
    previous = nil

    node_to_insert = Node.new(value)

    if current == nil
      @head = node_to_insert
      return
    end

    if @head.data > node_to_insert.data
      insert(value)
      return
    end

    while current != nil
      if current.data > node_to_insert.data
        previous.next = node_to_insert
        node_to_insert.next = current
        return
      end
      previous = current
      current = current.next
    end
    previous.next = node_to_insert # we went throught the whole list and didn't find a larger value
  end

  # method to print all the values in the linked list
  def visit
    current = @head # we have to tell it where to start (similar to starting at 0)

    while current != nil
      print current.data
      current = current.next # increments
    end
  end

  # method to delete the first node found with specified value
  def delete(value)
    current = @head
    previous = nil

    if @head.data == value
      @head = @head.next
      return
    end

    while current != nil
      if current.data == value
        previous.next = current.next
        return
      end
      previous = current
      current = current.next
    end
  end

  # method to reverse the singly linked list
  # note: the nodes should be moved and not just the values in the nodes
  def reverse
    current = @head
    previous = nil


    while current != nil
      temp = current.next # holding the place of current next
      current.next = previous
      previous = current # pointing at the one behind it
      current = temp # incrementing current
    end
    @head = previous # reassign head to the last node I touched
  end

  ## Advanced Exercises
  # returns the value at the middle element in the singly linked list
  def find_middle_value

    if @head == nil
      return
    end

    if @head.next == nil
      return @head.data
    end

    slow = @head
    fast = @head.next

    while fast != nil
      slow = slow.next
      fast = fast.next
      if fast != nil
        fast = fast.next
      end
      return slow.data
    end

  end

  # find the nth node from the end and return its value
  # assume indexing starts at 0 while counting to n
  def find_nth_from_end(n)
    current = @head
    length = length()
    count = 0
    # length - n is the node we are looking for
    spot = length - n - 1

    if @head == nil
      return nil
    end

    if n > length
      return nil
    end

    # while count is less than that nth spot, increment it
    while count < spot
      # current needs to get to that nth spot
      current = current.next
      count += 1
    end
    # when it is that nth spot, return it's value
    return current.data
  end

  # checks if the linked list has a cycle. A cycle exists if any node in the
  # linked list links to a node already visited.
  # returns true if a cycle is found, false otherwise.
  def has_cycle

    if @head == nil || @head.next == nil
      return false
    end

    slow = @head
    fast = @head

    while fast != nil
      slow = slow.next
      fast = fast.next

      if fast != nil
        fast = fast.next
      end
      if fast == slow
        return true
      end
    end
    return false
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

# Add some values to the linked list
puts "Adding 5, 3 and 1 to the linked list."
my_linked_list.insert(5)
my_linked_list.insert(3)
my_linked_list.insert(1)

# print all elements
puts "Printing elements in the linked list:"
my_linked_list.visit

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

# find min and max
puts "Confirming min and max values in the linked list."
min = my_linked_list.find_min
puts "BUG: Min value should be 1 and not #{min}" if min != 1
max = my_linked_list.find_max
puts "BUG: Max value should be 5 and not #{max}" if max != 6

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

# find middle element
puts "Confirming middle value in the linked list."
middle = my_linked_list.find_middle_value
puts "BUG: Middle value should be 4 and not #{middle}" if middle != 4

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

# nth from the end
puts "Verifying find_nth_from_end method."
value = my_linked_list.find_nth_from_end(0)
puts "BUG: Value at index 0 from the end, should be 3 and is #{value}" if value != 3
value = my_linked_list.find_nth_from_end(1)
puts "BUG: Value at index 1 from the end, should be 4 and is #{value}" if value != 4
value = my_linked_list.find_nth_from_end(2)
puts "BUG: Value at index 2 from the end, should be 6 and is #{value}" if value != 6

# check for cycle
puts "Checking the linked list for cycle."
puts "BUG: Should not have a cycle." if my_linked_list.has_cycle

# create cycle and then test for it
puts "Creating a cycle in the linked list."
my_linked_list.create_cycle
puts "Checking the linked list for cycle."
puts "BUG: Should not have a cycle." if !(my_linked_list.has_cycle)
