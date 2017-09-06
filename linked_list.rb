
# Defines a node in the singly linked list
class Node
  attr_reader :data # allow external entities to read value but not write
  attr_accessor :next # allow external entities to read or write next node

  def initialize(value)
    @data = value
    # @next = next
    @next = nil
  end
end

# Defines the singly linked list
class LinkedList
  def initialize
    # keep the head private. Not accessible outside this class.
    @head = nil
  end

  # method to add a new node with the specific data value in the linked list
  # insert the new node at the beginning of the linked list
  def insert(value)
    if @head == nil
      @head = Node.new(value)
    else
      current = @head
      @head = Node.new(value)
      @head.next = current
    end
  end
  # if order doesn't matter and you make the new value at the head.
  # Time complexity: O(1) because only add one thing at the beginning.
  # Space complexity: O(1) because the space complexity doesn't change no matter the length of the linked list.

  # method to find if the linked list contains a node with specified value
  # returns true if found, false otherwise
  def search(value)
    current = @head
    #traverse through all the nodes until the end
    while current != nil
      #check if this node's data is the value
      if current.data == value
        #return true if found
        return true
      else
        current = current.next
        #end traversing through the list
      end
    end
    #return false because didn't find the value
    return false
  end

  # method to return the max value in the linked list
  # returns the data value and not the node
  def find_max
    return nil if @head == nil
    max = @head.data
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
    return nil if @head == nil
    min = @head.data
    current = @head
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
    if @head == nil
      return 0
    else
      current = @head
      count = 0
      while current != nil
        count += 1
        current = current.next
      end
      return count
    end
  end

  # method to return the value of the nth element from the beginning
  # assume indexing starts at 0 while counting to n
  def find_nth_from_beginning(n)
    if @head == nil
      return "Empty list"
    else
      counter = 0
      current = @head
      until counter == n
        current = current.next
        counter += 1
      end
    # print current.data
    return current.data
    end
  end

  # method to insert a new node with specific data value, assuming the linked
  # list is sorted in ascending order
  def insert_ascending(value)
    if @head == nil
      @head = Node.new(value)
    else
      current = @head
      while current != nil
        if current.next == nil
          current.next = Node.new(value)
          return
        elsif current.next.data > value && current.next != nil
          temp = current.next
          current.next = Node.new(value)
          current.next.next = temp
          return
        end
        current = current.next
      end
    end
  end

  # method to print all the values in the linked list
  def visit
    current = @head
    while current != nil
      print current.data
      current = current.next
    end
    print "\n"
  end

  # method to delete the first node found with specified value
  def delete(value)
    if @head == nil
      return
    elsif @head.data == value
      @head = @head.next
    else
     current = @head
     while current.next != nil
       if current.next.data == value
         current.next = current.next.next
       end
       current = current.next
     end
     return
   end
  end
  # time complexity: O(n).  O(n) for searching (if it's at the end - have to traverse the whole list to find the item to delete.)
  # space complexity: O(1). Storage won't change at all no matter the length of the list.

  # method to reverse the singly linked list
  # note: the nodes should be moved and not just the values in the nodes
  def reverse
    current = @head
    previous = nil
    temp = current.next
    until current == nil
      temp = current.next
      current.next = previous
      previous = current
      current = temp
    end
      @head = previous
  end
  # time complexity O(n)
  # space compelxity O(1)

  ## Advanced Exercises
  # returns the value at the middle element in the singly linked list
  # slow reference points at head, fast reference points at head's next
  # while fast is not nil
  # update slow to slow's next
  # update fast to fast's next
    # if fast != nil
    # update fast to fast's next
  def find_middle_value
    if @head == nil
      return
    elsif @head.next == nil
      return @head.data
    else
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
  end
  # time complexity O(n), go through the list 1.5 times.  But ultimately, only go through the one loop one time.
  # space complexity O(1), not creating anything, size we are alocating doesn't change anything

  # find the nth node from the end and return its value
  # assume indexing starts at 0 while counting to n
  # this doesn't handle the condition when the LL is not as long as n, does it?  Can you please advise?
  def find_nth_from_end(n)
    if @head == nil
      return
    else
      i = 0
      current = @head
      until i == n
         current = current.next
         i += 1
      end
      trailingCurrent = @head
      until current.next == nil
        current = current.next
        trailingCurrent = trailingCurrent.next
      end
      return trailingCurrent.data
    end
  end
  # time complexity Tamiko's: O(count), twice through O(2n)
  # space complexity Tamiko's: O(1)

  # checks if the linked list has a cycle. A cycle exists if any node in the
  # linked list links to a node already visited.
  # returns true if a cycle is found, false otherwise.
  # use slow and fast
  # both start at head
  # slow moves one
  # fast moves twice as fast
  # if fast == slow we have a cycle
  # if fast gets to nil, not a cycle
  def has_cycle
    if @head == nil
      return false
    elsif @head.next == nil
      return false
    else
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
  end
  # time complexity O(n) - because it's still a factor of n
  # space complexity O(1) - because we only have fast and slow
  # test cases?
  # if head is nil
  # even number of nodes, odd number of nodes
  # if one node that points at itself...

  # Creates a cycle in the linked list for testing purposes
  # Assumes the linked list has at least one node
  def create_cycle
    #   return if @head == nil # don't do anything if the linked list is empty
    if @head == nil
      return
    else
    # navigate to last node
    current = @head
    while current.next != nil
      current = current.next
    end
    # make the last node link to first node
    current.next = @head
    end
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
