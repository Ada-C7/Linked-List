
# Defines a node in the singly linked list
class Node
  attr_reader :data # allow external entities to read value but not write
  attr_accessor :next_node # allow external entities to read or write next_node node

  def initialize(value, next_node = nil)
    @data = value
    @next_node = next_node
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
    # create new node w value 
    new_node = Node.new(value)
    
    # sets head to new node
    if @head == nil
      @head = new_node
    else 
      new_node.next_node = @head
      @head = new_node
    end

    return

    # time O(1), space O(1)
  end

  # method to find if the linked list contains a node with specified value
  # returns true if found, false otherwise
  def search(value)
    # returns false if head is empty
    return false if @head == nil

    # start pointing at head
    current = @head

    # traverse linked list until value found or end of list
    while current != nil
      return true if current.data == value 
      current = current.next_node
    end 

    # if value not found, return false
    return false

    # time O(n), space O(1)
  end

  # method to return the max value in the linked list
  # returns the data value and not the node
  def find_max
    # returns nothing if head is empty
     return if @head == nil

    # start at head with head's value as max
    current = @head
    max = @head.data

    # traverse list
    while current != nil
      max = current.data if current.data > max
      current = current.next_node
    end 

    return max

    # time O(n), space O(1)
  end

  # method to return the min value in the linked list
  # returns the data value and not the node
  def find_min
     return if @head == nil

    current = @head
    min = @head.data

    while current != nil
      min = current.data if current.data < min
      current = current.next_node
    end 

    return min

    # time O(n), space O(1)
  end

  # method that returns the length of the singly linked list
  def length
    return 0 if @head == nil

    current = @head
    i = 0

    while current != nil
      i += 1
      current = current.next_node
    end 

    return i

    # time O(n), space O(1)
  end

  # method to return the value of the nth element from the beginning
  # assume indexing starts at 0 while counting to n
  def find_nth_from_beginning(n)
    return if @head == nil
    current = @head
    i = 0

    # Loop while end of linked list is not reached
    while current
      if i == n 
        return current.data
      else
        i += 1
        current = current.next_node
      end
    end

    return nil

    # time O(n), space O(1)
  end

  # method to insert a new node with specific data value, assuming the linked
  # list is sorted in ascending order
  def insert_ascending(value)
    new_node = Node.new(value)

    return @head.data = new_node if @head == nil
    current = @head
    
    while current.next_node != nil && current.next_node.data < value
      current = current.next_node 
    end 

    new_node.next_node = current.next_node
    current.next_node = new_node

    return 

    # time O(n), space O(1)
  end

  # method to print all the values in the linked list
  def visit
    return if @head == nil

    current = @head

    while current != nil
      puts current.data
      current = current.next_node
    end 

    # time O(n), space O(1)
  end

  # method to delete the first node found with specified value
  def delete(value)
    # return nothing is head is empty
    return if @head == nil

    # if head has value to delete, make next node the new head
    # this doesn't handle any garbage collecting
    if @head.data == value
      @head = @head.next_node
    end 

    # otherwise, search through list starting at head
    current = @head
    
    # traverse the list until data found
    # this doesn't handle garbage collecting
    while current.next_node != nil
      if current.next_node.data == value
        # once data found in next node
        # make current's next node the next next node (skipping the value to delete)
        current.next_node = current.next_node.next_node
        return
      end
      current = current.next_node
    end

    return

    # time O(n), space O(1)
  end

  # method to reverse the singly linked list
  # note: the nodes should be moved and not just the values in the nodes
  def reverse
    # start at head, create prev
    current = @head
    prev = nil
    
    # traverse the list
    while current != nil
      temp = current.next_node # save next node
      current.next_node = prev # update linked list by switching values
      prev = current # move on to next node
      current = temp
    end

    # head is now previous last value
    @head = prev

    # time O(n), space O(1)
  end

  ## Advanced Exercises
  # returns the value at the middle element in the singly linked list
  def find_middle_value
    # return head if empty or only 1 value
    return if @head == nil
    return @head.data if @head.next_node == nil

    slow = @head
    fast = @head.next_node
    
    # slow goes 1 node at a time, fast goes 2 nodes at a time
    while fast != nil
      slow = slow.next_node
      fast = fast.next_node
      if fast
        fast = fast.next_node
      end 
    end
    
    # once fast is at end, slow is in middle
    return slow.data

    # time O(n), space O(1)
  end

  # find the nth node from the end and return its value
  # assume indexing starts at 0 while counting to n
  def find_nth_from_end(n)
    # return if empty
    return nil if @head == nil

    current = @head
    i = 0
    
    # traverse until i == n
    while i != n
      i += 1
      current = current.next_node
    end

    # set trailing to head once current is at n
    trailing = @head 

    # continue traversing
    while current.next_node
      trailing = trailing.next_node
      current = current.next_node
    end

    # once end reached, trailing is at length - n - 1
    return trailing.data

    # time O(n), space O(1)
  end

  # checks if the linked list has a cycle. A cycle exists if any node in the
  # linked list links to a node already visited.
  # returns true if a cycle is found, false otherwise.
  def has_cycle
   # return head if empty or only 1 value
    return false if @head == nil
    return false if @head.next_node == nil

    slow = @head 
    fast = @head.next_node

    # slow travels 1 node at a time
    while fast != nil
      slow = slow.next_node
      fast = fast.next_node

      # fast travels 2 nodes at a time
      if fast
        fast = fast.next_node
      end 
      # eventually, slow catches up to fast if there's a cycle
      if fast == slow # cycle detected
        return true
      end
    end

    return false

    # time O(n), space O(1)
  end

  # Creates a cycle in the linked list for testing purposes
  # Assumes the linked list has at least one node
  def create_cycle
    return if @head == nil # don't do anything if the linked list is empty

    # navigate to last node
    current = @head
    while current.next_node != nil
      current = current.next_node
    end

    current.next_node = @head # make the last node link to first node
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

# validates search
puts "5 is in the linked list: #{my_linked_list.search(5)}"
puts "100 is in the linked list: #{my_linked_list.search(100)}"

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
puts "BUG: Max value should be 6 and not #{max}" if max != 6

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
