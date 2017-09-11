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
    # keep the head private. Not accessible outside this class
    @head = nil
  end

  # ----------
  # time: O(1) / Constant
  # the node is always added at the beginning so the time
  # it takes is independent of how long the linked list is

  # space: O(1) / Constant
  # the variables are independent of the size of the linked list
  def insert(value)
    # create a new node
    next_node = Node.new(value)

    # if the head is empty, make the head the new node
    if @head == nil
      @head = next_node

    # if there's an exisiitng head
    # update the new node's next to be the existing head
    # and make the new node the head
    else
      next_node.next = @head
      @head = next_node
    end

    return
  end

  # ----------
  # time: O(n) / Linear
  # the time it takes to search all nodes is dependent
  # on the length of the linked list (n)

  # space: O(1) / Constant
  # the variables are independent of the size of the linked list
  def search(value)
    current = @head

    while current != nil
      if current.data == value
        return true
      end

      current = current.next
    end

    return false
  end

  # ----------
  # time: O(n) / Linear
  # the time it takes to search all nodes for the max value
  # is dependent on the length of the linked list (n)

  # space: O(1) / Constant
  # the variables are independent of the size of the linked list
  def find_max
    if @head == nil
      puts "empty head. max is nil"
      return nil
    end

    current = @head
    max = current.data

    while current != nil
      if current.data > max
        max = current.data
      end

      current = current.next
    end

    return max
  end

  # ----------
  # time: O(n) / Linear
  # the time it takes to search all nodes for the min value
  # is dependent on the length of the linked list (n)

  # space: O(1) / Constant
  # the varaibles used are independent of the size of the linked list
  def find_min
    if @head == nil
      puts "head empty. min is nil"
      return nil
    end

    current = @head
    min = current.data

    while current != nil
      if current.data < min
        min = current.data
      end

      current = current.next
    end

    return min
  end

  # ----------
  # time: O(n) / Linear
  # the time it takes to count all nodes is
  # dependent on the size of the linked list

  # space: O(1) / Constant
  # the variables used are independet of the size of the linked list
  def length
    current = @head
    length = 0

    while current != nil
      length += 1
      current = current.next
    end

    return length
  end

  # ----------
  # time: O(n) / linear
  # is dependent on the size of the linked list

  # space: O(1) / Constant
  # vairables used are independent of the size of the linked list
  # QUESTION: what is this supposed to do if x > linkedlist length?
  def find_nth_from_beginning(n)
    current = @head
    index = 0

    while current != nil
      if index == n
        return current.data
      else
        current = current.next
        index += 1
      end
    end
  end

  # ----------
  # time: O(n) / linear
  # the time it takes to insert in ascending order
  # is dependent on the size of the linked list

  # space: O(1) / Constant
  # the variables used are independent of the size of the linked list
  def insert_ascending(value)
    current = @head
    new_node = Node.new(value)

    if @head == nil || @head.data > value
      new_node.next = @head
      @head = new_node
      return
    end

    while current.next != nil && current.next.data <= value
      current = current.next
    end

    new_node.next = current.next
    current.next = new_node
  end

  # ----------
  # time: 0(n) / Linear
  # the time it takes to visit each node in the linked
  # list is dependent on the size of the linked list

  # space: 0(1) / Constant
  # the variables used are independent of the size of the linked list
  def visit
    current = @head

    while current != nil
      puts current.data

      current = current.next
    end
  end

  # ----------
  # time: 0(n) / Linear
  # Each node may be visited to determine if there's a node to be deleted

  # space: 0(1) / Constant
  # the variables used are independent of the size of the linked list
  def delete(value)
    if @head == nil
      puts "Error: Linked list empty - nothing to delete!"
      return
    end

    if @head.data == value
      @head = @head.next
      return
    end

    current = @head
    while current.next != nil
      if current.next.data == value
        current.next = current.next.next
        return
      end

      current = current.next
    end
  end

  # ----------
  # note: the nodes should be moved and not just the values in the nodes
  # adjusting the link to point to 'previous' rather than next

  # time: O(n) / Linear
  # To reverse  a linked list each node is visited once,
  # therefore the time is dependent on the size of the linked list

  # space: O(1) / Constant
  # the variables used are independent of the size of the linked list
  def reverse
    current = @head
    previous = nil

    if current == nil # doesn't need to be reversed if empty
      return
    end

    while current != nil
      temp = current.next
      current.next = previous

      # move to next
      previous = current
      current = temp
    end

    @head = previous
  end

  # ----------
  # time: O(n) / linear
  # the time it takes to find the middle value is
  # dependent on the size of the linked list

  # space: O(1) / Constant
  # the variables used are independent of the size of the linked list
  def find_middle_value
    if @head == nil
      return
    end

    if @head.next == nil
      return @head
    end

    slow = @head
    fast = @head.next

    while fast != nil
      slow = slow.next
      fast = fast.next

      if fast != nil
        fast = fast.next
      end
    end

    return slow.data
  end

  # ----------
  # time: O(n) / Linear
  # time is dependent on the size of the linked list

  # space: O(1) / Constant
  # variables used are independent of the size of the linked list
  def find_nth_from_end(n)
    # approach with going through the linked list just once
    # assume indexing starts at 0 while counting to n
    current = @head
    index = 0

    # count to n from the beginning
    while current != nil && index != n
      current = current.next
      index += 1
    end

    # check that we didn't reach the end
    if current == nil
      puts "Error: The linked list has less than #{n} indexable nodes"
      return
    end

    # the previous while loop exited because of index == n condition
    # start a new traverser at the beginning.
    # when current reaches the end, new_current will be at index n from the end
    new_current = @head
    while current.next != nil
      current = current.next
      new_current = new_current.next
    end

    return new_current.data
  end

  # ----------
  # uses Floyd's cycle algorithm

  # time: O(n) / linear
  # the time it takes to determine if there is a
  # cycle is dependent on the size of the linked list

  # space: O(1) / Constant
  # the variables used are independent of the size of the linked list
  def has_cycle
    # if the linked list is empty or contains
    # only one node there is no cycle
    if @head == nil || @head.next == nil
     return false
    end

    # create a fast pointer and a slow pointer
    # both pointing to the head node
    slow = @head
    fast = @head

    # move the slow pointer one step and the fast pointer
    # two steps in a loop
    # if they point to the same node then there is a loop
    while fast != nil
     slow = slow.next
     fast = fast.next
     if fast != nil
       fast = fast.next
     end

     # cycle found
     if slow == fast
       return true
     end
    end

    # if we have reached the end there's no cycle
    return false
  end

  # ----------
  # time: O(n) / Linear
  # the amounf of time is dependent on the size of the
  # linked list because we must go through all nodes
  # in order to find the end

  # space: O(1) / Constant
  # The variables used are independent of the
  # size of the linked list
  def create_cycle
    # exit if the linked list is empty
    if @head == nil
      return
    end

    # find the last node
    current = @head
    while current.next != nil
      current = current.next
    end

    # make the last node's 'next' point to the head
    current.next = @head
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

# search for element
value = my_linked_list.search(5)
puts "Found 5? #{value}"
value = my_linked_list.search(100)
puts "Found 100? #{value}"

# length test
value = my_linked_list.length
puts "Length of list: #{value}"

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
