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
  # time complexity: O(1); space complexity: O(1) -> memory allocation constant regardless of size of linked list.
  # O(N)? -> memory allocation depends on size of input value??
  def insert(value)
    # First instantiate the new node with the given value
    newNode = Node.new(value)

    # If there are already nodes in the list, have the newNode point to them
    unless @head == nil
      newNode.next = @head
    end

    # Set the head to point to the new node
    @head = newNode
  end

  # method to find if the linked list contains a node with specified value
  # returns true if found, false otherwise
  # time complexity: O(N) => By average, visit half of elements and the constant of 1/2 drops out. Worst case, visit all elements.
  # space complexity: O(1) => No matter the size of the list, only need 1 temp.
  def search(value)
    # return false if the list is empty
    return false if @head == nil

    curr = @head
    # Iterate through the list looking for the given value, stopping if value is found
    while curr != nil
      return true if curr.data == value
      curr = curr.next
    end

    # Value not found, so return false
    return false
  end

  # method to return the max value in the linked list
  # returns the data value and not the node
  # Assume list is not sorted
  # time complexity: O(N) => Have to visit each element
  # space complexity: O(1) => Regardless of list size, just have 1 temp var
  def find_max
    # Return nil if the list is empty
    return nil if @head == nil

    # Set a temp variable to the first node and max to the first node's value
    curr = @head
    max = curr.data

    # Iterate through the list, looking for a larger value to update max
    until curr.next == nil
      max = curr.next.data if curr.next.data > max
      curr = curr.next
    end

    # Return the largest value found
    return max
  end

  # method to return the min value in the linked list
  # returns the data value and not the node
  # Big O same as max
  def find_min
    return nil if @head == nil

    curr = @head
    min = curr.data

    while curr.next != nil
      min = curr.next.data if curr.next.data < min
      curr = curr.next
    end

    return min
  end

  # method that returns the length of the singly linked list
  # time complexity: O(N) => have to visit each element to determine length
  # space complexity: O(1) => Have two temps, regardless of linked list size
  def length
    # Keep track of current place in linked list, starting at the head*
    curr = @head
    # Initiate a count
    count = 0

    # Iterate through the list, adding one to the count until reached the end (curr == nil)
    until curr == nil
      count += 1
      curr = curr.next
    end

    # Return the count of nodes in the list
    return count
  end

  # method to return the value of the nth element from the beginning
  # assume indexing starts at 0 while counting to n
  # If cant use times loop, need a count of the indices
  # time complexity: ?? Not dependent on linked list size, but index passed in. O(n), where n = index to find
  # space complexity: O(1) => memory allocation constant regardless of list size. Just need a temp var.
  def find_nth_from_beginning(n)
    # Check if the list is empty
    return nil if @head == nil

    # Keep track of current place in list, starting at head
    curr = @head
    # Iterate through the lined list from the start to nth node
    n.times do
      # Only progress down the list if there is a next node. If there isnt (curr.next == nil), return nil.
      return nil if curr.next == nil
      curr = curr.next
    end

    # Found it!
    return curr.data
  end

  # method to insert a new node with specific data value, assuming the linked
  # list is sorted in ascending order
  # time complexity: O(N) => may have to visit each node
  # space complexity: O(1) => Always creating just 1 new node and 1 temp var if linked list size is 1 or 100
  def insert_ascending(value)
    # Instantiate new node with given value
    newNode = Node.new(value)

    if @head == nil # Case where the list is empty
      @head = newNode
    elsif value < @head.data  # Case of inseration at first element
      newNode.next = @head
      @head = newNode
    else # Insertion occurs after 1st element
      curr = @head
      until curr.next == nil

        # Case where insertion occurs in the middle of the list
        if value < curr.next.data
          newNode.next = curr.next
          curr.next = newNode
          return
        end
        curr = curr.next
      end

      # Case where insert at the end of the list
      curr.next = newNode
    end
  end

  # method to print all the values in the linked list
  # time complexity: O(N) => have to visit each element in the linked list once
  # space complexity: O(1) => regardless of size of list, only need to create one temp variable
  def visit
    # Set a temp value to keep track of the current node, starting at the head
    curr = @head

    # Iterate throught the list and print node values until reach the end of the list (current value is nil)
    until curr == nil
      print "#{curr.data} "
      curr = curr.next
    end

    # Add a line break for readability
    puts
  end

  def visitWithCommas # fencepost
    # Check if the list is empty. If so, return nothing
    return if @head == nil

    # Iterate through list and print node values with commas until reach the last node (current node's next value is nil)
    curr = @head
    until curr.next == nil
      print "#{curr.data}, "
      curr = curr.next
    end

    # print last node value with a line break
    print "#{curr.data}\n"
  end

  # method to delete the first node found with specified value
  # Not found, return nil or unmodified list? If found, return value or modified list?
  # time complexity: O(N) => may have to iterate over entire list looking for value. Ave case?
  # depends on context. What is contract with the caller? Api -> return T or F
  # do you want to let the caller know?
  # space complexity: O(1) => memory allocation constant regardless of list size
  def delete(value)
    # Case where the list is empty
    return if @head == nil

    # Case where delete the 1st node
    if @head.data == value
      @head = @head.next
      return
    end

    curr = @head
    # Check that there is another node after current
    until curr.next == nil
      # If the next node contains the value, have the current node point to next next node
      if curr.next.data == value
        curr.next = curr.next.next
        return
      end

      # If not, keep searching the list for the given value.
      curr = curr.next
    end

    # curr = @head.next
    # prev = @head
    #
    # until curr == nil
    #   # Value found in the list. Delete that node.
    #   if curr.data == value
    #     prev.next = curr.next
    #     return
    #   end
    #
    #   # Else, keep searching.
    #   prev = curr
    #   curr = curr.next
    # end

    return nil # Value not found in the list
  end

  # method to reverse the singly linked list
  # note: the nodes should be moved and not just the values in the nodes
  # time complexity: O(N) => Iterate througth the linked list once
  # space complexity: O(1) => memory allocation not dependent on linked list size
  def reverse
    # Do nothing if the list is empty or only has one element
    return if @head == nil || @head.next == nil

    # Start with prev set to nil, so that 1st node will point to nil
    prev = nil
    curr = @head

    # Iterate through linked list until reach the end of the list (curr == nil),
    # Have the current node point to the previous node while keeping track of the next node in a temp var.
    until curr == nil
      temp = curr.next
      curr.next = prev
      prev = curr
      curr = temp
    end

    # Have the head point to the front of the reversed list.
    @head = prev
  end

  ## Advanced Exercises
  # returns the value at the middle element in the singly linked list
  # time complexity: O(N) => constant of 1/2 will drop in bigO
  # space complexity: O(1) => memory needed not dependent on linked list size.
  def find_middle_value
    return nil if @head == nil

    slow = @head
    fast = @head

    # even(greater) || odd
    # fast.next == nil || fast.next.next == nil => odd || even(less)
    until fast == nil || fast.next == nil
    # until fast.next = nil
      slow = slow.next
      fast = fast.next.next
    end
    return slow.data
  end

  # This gives under value when list has even number of nodes.
  # What modification would provide the upper value?
  def find_middle_value2
    return nil if @head == nil

    s = @head
    f = @head.next

    until f == nil
      s = s.next
      f = f.next
      f = f.next if f != nil
    end

    return s.data
  end

  # find the nth node from the end and return its value
  # assume indexing starts at 0 while counting to n
  # Ask: does indexing start at 0 or 1
  # same solution as: fast = @head.next and change loop condition to f == nil
  # time complexity: O(N)
  # space complexity: O(1)
  # Is curr and trailing curr more descriptive than fast and slow? Can fast and slow only be used in the context where both are moving, one slower than the other?
  def find_nth_from_end(n)
    return nil if @head == nil

    slow = @head
    fast = @head
    count = 0

    until fast.next == nil
      fast = fast.next
      count += 1
      slow = slow.next if count > n
    end

    return nil if count < n
    return slow.data
  end

  # checks if the linked list has a cycle. A cycle exists if any node in the
  # linked list links to a node already visited.
  # returns true if a cycle is found, false otherwise.
  def has_cycle
    # No cycle if head does not exit or has only node that points to nil
    return false if @head == nil || @head.next == nil

    slow = @head
    fast = @head

    until fast == nil
      slow = slow.next
      fast = fast.next
      fast = fast.next if fast != nil

      return true if fast == slow
    end

    # reached the end of the list (nil)
    return false
  end

  # Creates a cycle in the linked list for testing purposes
  # Assumes the linked list has at least one node
  # time complexity: O(N) => seems worse than this? How do you not know it is N^2?
  # space complexity: O(1)
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
my_linked_list.visit

# Add some values to the linked list
puts "Adding 5, 3 and 1 to the linked list."
my_linked_list.insert(5)
my_linked_list.insert(3)
my_linked_list.insert(1)

# print all elements
print "Printing elements in the linked list: "
my_linked_list.visit

# search for value
print "Searching elements in the linked list for 7: "
puts(my_linked_list.search(7))
print "Searching elements in the linked list for 5: "
puts(my_linked_list.search(5))

# Find the value at the nth node
puts "Confirming values in the linked list using find_nth_from_beginning method."
value = my_linked_list.find_nth_from_beginning(2)
puts "BUG: Value at index 2 should be 5 and is #{value}" if value != 5
value = my_linked_list.find_nth_from_beginning(1)
puts "BUG: Value at index 1 should be 3 and is #{value}" if value != 3
value = my_linked_list.find_nth_from_beginning(0)
puts "BUG: Value at index 0 should be 1 and is #{value}" if value != 1

# print all elements
print "Printing elements in the linked list: "
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
print "Printing elements in the linked list: "
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
print "Printing elements in the linked list: "
my_linked_list.visit
# validate length
puts "Confirming length of the linked list."
my_linked_list_length = my_linked_list.length
puts "BUG: Length should be 4 and not #{my_linked_list_length}" if my_linked_list_length != 4

# delete value
puts "Deleting node with value 1 from the linked list."
my_linked_list.delete(1)
# print all elements
print "Printing elements in the linked list: "
my_linked_list.visit
# validate length
puts "Confirming length of the linked list."
my_linked_list_length = my_linked_list.length
puts "BUG: Length should be 3 and not #{my_linked_list_length}" if my_linked_list_length != 3

# # find middle element
puts "Confirming middle value in the linked list."
middle = my_linked_list.find_middle_value
puts "BUG: Middle value should be 4 and not #{middle}" if middle != 4

# reverse the linked list
puts "Reversing the linked list."
my_linked_list.reverse
# print all elements
print "Printing elements in the linked list: "
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
