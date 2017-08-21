
# Defines a node in the singly linked list
class Node(object):
    def __init__(self, value=None, next_node=None):
        self.__data = None  # protected
        self.next_node = next_node
        self.__set_data_once(value)

    def get_data(self):
        if self.__data:
            return self.__data
        else:
            return "Undefined"

    def __set_data_once(self, value):
        if self.__data == None:
            self.__data = value
        else:
            return ("You may not modify data.  Please add a node.")

# Defines the singly linked list
class LinkedList(object):
    def __init__(self):
        self.__head = None # keep the head private. Not accessible outside this class

    def __retrieve_head(self):
        return self.head

    def __set_head(self, new_value):
        self.head = new_value

    # method to add a new node with the specific data value in the linked list
    # insert the new node at the beginning of the linked list
    def insert(self, data):
        new_node = Node(value = data)
        new_node.next_node = self.__head
        self.__head = new_node
        print ("inserting {}".format(data))

    # method to find if the linked list contains a node with specified value
    # returns true if found, false otherwise
    def search(self, value):
        current_node = self.__head
        while current_node != None:
            if current_node.get_data() == value:
                return True
            current_node = current_node.next_node()
        return False

    # method to return the max value in the linked list
    # returns the data value and not the node
    def find_max(self):
        if self.__head == None:
            return "None"
        node = self.__head
        max = node.get_data()
        while node.next_node != None:
            if node.get_data() > max:
                max = node.get_data()
            node = node.next_node
        return(max)

    # # method to return the min value in the linked list
    # # returns the data value and not the node
    def find_min(self):
        if self.__head == None:
            return "None"

        node = self.__head
        min = node.get_data()
        while node.next_node != None:
            if node.get_data() < min:
                min = node.get_data()
            node = node.next_node
        return(min)
    # # method that returns the length of the singly linked list
    def length(self):
        node = self.__head
        counter = 0
        while node != None:
            counter += 1
            node = node.next_node
        return(counter)




    # # method to return the value of the nth element from the beginning
    # # assume indexing starts at 0 while counting to n
    def find_nth_from_end(self, n):
        if not self.__head:
            return

        curr_node = self.__head
        curr_node_plus_n = self.__head.next_node

        # initialize node_a_plus_n to n elements ahead of counter a
        for i in range(n):
            if curr_node_plus_n:
                curr_node_plus_n = curr_node_plus_n.next_node
            else:
                return 'None'

        while curr_node_plus_n:
            curr_node = curr_node.next_node
            curr_node_plus_n = curr_node_plus_n.next_node
        return  curr_node.get_data()

    # # method to insert a new node with specific data value, assuming the linked
    # # list is sorted in ascing order
    def insert_ascing(self, value):
        node = self.__head

        if not(node) or node.get_data() > value:
            self.insert(value)
            return

        while node.next_node and node.next_node.get_data() < value:
            node = node.next_node

        new_node = Node(value = value, next_node = node.next_node)
        node.next_node = new_node


    # method to print all the values in the linked list
    def visit(self):
        current_node = self.__head
        while True:
            print(current_node.get_data())
            if current_node.next_node == None: break
            current_node = current_node.next_node

    # # method to delete the first node found with specified value
    def delete(self, value):
        node = self.__head
        if not(node): return
        if node.get_data() == value:
            self.__head = node.next_node

        while node.next_node:
            if node.next_node.get_data() == value:
                node.next_node = node.next_node.next_node
                break
            node = node.next_node


    # # method to reverse the singly linked list
    # # note: the nodes should be moved and not just the values in the nodes
    def reverse(self):
        if self.__head == None or self.__head.next_node == None:
            return

        node = self.__head
        prev_node = None

        while node != None:

            # preserve next node for later use
            next_node = node.next_node

            # make node point to the value before it
            node.next_node = prev_node

            # move forward one node
            prev_node = node
            node = next_node
        self.__head = prev_node
        self.visit()


    # ## Advanced Exercises
    # # returns the value at the middle element in the singly linked list
    def find_middle_value(self):
        node = self.__head
        if not node:
            return
        else:
            mid_val = node.get_data()

        while node.next_node and node.next_node.next_node:
            mid_val = node.next_node.get_data()
            node = node.next_node.next_node

        return mid_val

    # # find the nth node from the  and return its value
    # # assume indexing starts at 0 while counting to n
    def find_nth_from_beginning(self, n):
        if self.__head == None:
            return "Undefined"
        node = self.__head

        for i in range(n):
            if node.next_node:
                node = node.next_node
            else:
                return "None"
        return node.get_data()

    # # checks if the linked list has a cycle. A cycle exists if any node in the
    # # linked list links to a node already visited.
    # # returns true if a cycle is found, false otherwise.
    def has_cycle(self):
        if not self.__head:
            return False
        slow_loop = self.__head
        fast_loop = self.__head.next_node
        while fast_loop.next_node.next_node:
            if fast_loop.next_node == slow_loop:
                return True
            slow_loop = slow_loop.next_node
            fast_loop = fast_loop.next_node.next_node
        return False

    # Creates a cycle in the linked list for testing purposes
    # Assumes the linked list has at least one node
    def create_cycle(self):
        if self.__head == None: return  # don't do anything if the linked list is empty

        # navigate to last node
        current = self.__head

        while current.next_node != None:
            current = current.next_node

        current.next_node = self.__head  # make the last node link to first node

## ---  of class definitions --- ##

# Create an object of linked list class
my_linked_list = LinkedList()

# Add some values to the linked list
print("Adding 5, 3 and 1 to the linked list.")
my_linked_list.insert(5)
my_linked_list.insert(3)
my_linked_list.insert(1)

# print all elements
print("Printing elements in the linked list:")
my_linked_list.visit()

# # Find the value at the nth node
print("Confirming values in the linked list using find_nth_from_beginning method.")
value = my_linked_list.find_nth_from_beginning(2)
if value != 5: print("BUG: Value at index 2 should be 5 and is {}".format(value))
value = my_linked_list.find_nth_from_beginning(1)
if value != 3: print("BUG: Value at index 1 should be 3 and is {}".format(value))
value = my_linked_list.find_nth_from_beginning(0)
if value != 1: print("BUG: Value at index 0 should be 1 and is {}".format(value))

# # print all elements
print("Printing elements in the linked list:")
my_linked_list.visit()

# # Insert ascing
# "Adding 4 in ascing order."
my_linked_list.insert_ascing(4)
# check newly inserted value
print("Checking values by calling find_nth_from_beginning method.")
value = my_linked_list.find_nth_from_beginning(2)
if value != 4: print("BUG: Value at index 2 should be 4 and is {}".format(value))
value = my_linked_list.find_nth_from_beginning(3)
if value != 5: print("BUG: Value at index 3 should be 5 and is {}".format(value))
value = my_linked_list.find_nth_from_beginning(1)
if value != 3: print("BUG: Value at index 1 should be 3 and is {}".format(value))

# # Insert ascing
print("Adding 6 in ascening order.")
my_linked_list.insert_ascing(6)
# # print all elements
print("Printing elements in the linked list:")
my_linked_list.visit()
# # validate length
print("Confirming length of the linked list.")
my_linked_list_length = my_linked_list.length()
if my_linked_list_length != 5: print("BUG: Length should be 5 and not {}".format(my_linked_list_length))


# # find min and max
print("Confirming min and max values in the linked list.")
min = my_linked_list.find_min()
if min != 1: print("BUG: Min value should be 1 and not {}", format(min))
max = my_linked_list.find_max()
if max != 5: print("BUG: Max value should be 5 and not {}", format(max))

# # delete value
print("Deleting node with value 5 from the linked list.")
my_linked_list.delete(5)
# # print all elements
print("Printing elements in the linked list:")
my_linked_list.visit()
# # validate length
print("Confirming length of the linked list.")
my_linked_list_length = my_linked_list.length()
if my_linked_list_length != 4: print("BUG: Length should be 4 and not {}".format(my_linked_list_length))


# # delete value
print("Deleting node with value 1 from the linked list.")
my_linked_list.delete(1)
# print all elements
print("Printing elements in the linked list:")
my_linked_list.visit()
# # validate length
print("Confirming length of the linked list.")
my_linked_list_length = my_linked_list.length()
if my_linked_list_length != 3: print("BUG: Length should be 3 and not {}".format(my_linked_list_length))

# # find middle element
print("Confirming middle value in the linked list.")
middle = my_linked_list.find_middle_value()
if middle != 4: print("BUG: Middle value should be 4 and not {}".format(middle))

# # reverse the linked list
print("Reversing the linked list.")
my_linked_list.reverse()
# print all elements
print("Printing elements in the linked list:")
my_linked_list.visit()

# # verify the reversed list
print("Verifying the reveresed linked list by calling find_nth_from_beginning method.")
value = my_linked_list.find_nth_from_beginning(2)
if value != 3: print("BUG: Value at index 2 should be 3 and is {}".format(value))
value = my_linked_list.find_nth_from_beginning(1)
if value != 4: print("BUG: Value at index 1 should be 4 and is {}".format(value))
value = my_linked_list.find_nth_from_beginning(0)
if value != 6: print("BUG: Value at index 0 should be 6 and is {}".format(value))

# # nth from the end
print("Verifying find_nth_from_end method.")
value = my_linked_list.find_nth_from_end(0)
if value != 3: print("BUG: Value at index 0 from end should be 3 and is {}".format(value))
value = my_linked_list.find_nth_from_end(1)
if value != 4: print("BUG: Value at index 1 from end should be 4 and is {}".format(value))
value = my_linked_list.find_nth_from_end(2)
if value != 6: print('BUG: Value at index 2 from end should be 6 and is {}'.format(value))

# # check for cycle
print("Checking the linked list for cycle.")
if my_linked_list.has_cycle(): print("BUG: Should not have a cycle.")

# # create cycle and then test for it
print("Creating a cycle in the linked list.")
my_linked_list.create_cycle()
print("Checking the linked list for cycle.")
if not my_linked_list.has_cycle(): print("BUG: Should not have a cycle.")