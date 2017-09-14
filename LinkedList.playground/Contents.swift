public class Node {
    let data: Int
    var next: Node? = nil
    
    init(data: Int) {
        self.data = data
    }
}

public class LinkedList {
    private var head: Node?
    
    //  method to add a new node with the specific data value in the linked list
    //  insert the new node at the beginning of the linked list
    public func insert(_ value: Int) {
        let node = Node(data: value)
        node.next = head
        head = node
    }
    
    //  method to find if the linked list contains a node with specified value
    //  returns true if found, false otherwise
    public func search(value: Int) -> Bool {
        var node = head
        
        while node != nil {
            if node?.data == value {
                return true
            }
            node = node?.next
        }
        return false
    }
    
    //  method to return the max value in the linked list
    //  returns the data value and not the node
    public func find_max() -> Int? {
        if head == nil {
            return nil
        }
        
        var max = head?.data
        var node = head
        
        while node != nil {
            if node!.data > max! {
                max = node!.data
            }
            node = node?.next
        }
        
        return max
    }
    
    //  method to return the min value in the linked list
    //  returns the data value and not the node
    public func find_min() -> Int? {
        if head == nil {
            return nil
        }
        
        var min = head?.data
        var node = head
        
        while node != nil {
            if node!.data < min! {
                min = node!.data
            }
            node = node?.next
        }
        
        return min
    }
    
    //  method that returns the length of the singly linked list
    public func length() -> Int? {
        var node = head
        var length = 0
        
        if node == nil {
            return nil
        }
        
        while node != nil {
            length += 1
            node = node?.next
        }
        
        return length
    }
    
    //  method to return the value of the nth element from the beginning
    //  assume indexing starts at 0 while counting to n
    public func find_nth_from_beginning(_ index: Int) -> Int? {
        var node = head
        var counter = 0
        
        while node != nil {
            if index == counter {
                return node?.data
            }
            counter += 1
            node = node?.next
        }
        
        return nil
    }
    
    //  method to insert a new node with specific data value, assuming the linked
    //  list is sorted in ascending order
    public func insert_ascending(_ value: Int) {
        let newNode = Node(data: value)
        
        if head == nil {
            head = newNode
        } else if newNode.data <= head!.data {
            let temp = head
            head = newNode
            head!.next = temp
        } else {
            var node = head
            while node?.next != nil && node!.next!.data < newNode.data {
                node = node?.next
            }
            
            newNode.next = node?.next
            node?.next = newNode
        }
        
    }
    
    //  method to print all the values in the linked list
    public func visit() {
        var node = head
        
        while node != nil {
            if let data = node?.data {
                print(data)
            }
            node = node?.next
        }
    }
    
    //  method to delete the first node found with specified value
    public func delete(_ value: Int) {
        if head?.data == value {
            head = head?.next
        } else {
            var node = head
            
            while node?.next != nil && node?.next!.data != value {
                node = node?.next
            }
            
            if node!.next != nil {
                if node?.next!.next == nil {
                    node?.next = nil
                } else {
                    node?.next = node?.next?.next
                }
            }
        }
    }
    
    //  method to reverse the singly linked list
    //  note: the nodes should be moved and not just the values in the nodes
    public func reverse() {
        var node = head
        var prevNode: Node? = nil
        
        while node != nil {
            let tempNode = node?.next
            node?.next = prevNode
            prevNode = node
            node = tempNode
        }
        
        head = prevNode
    }
    
    //  returns the value at the middle element in the singly linked list
    public func  find_middle_value() -> Int? {
        var byOne = head
        var byTwo = head?.next
        
        while byTwo != nil {
            byOne = byOne?.next
            byTwo = byTwo?.next?.next
        }
        
        return byOne?.data
    }
    
    //  find the nth node from the end and return its value
    //  assume indexing starts at 0 while counting to n
    public func find_nth_from_end(_ index: Int) -> Int? {
        var node = head
        
        if index == 0 {
            while node?.next != nil {
                node = node?.next
            }
            return node?.data
        }
        
        var byIndex = head?.next
        
        for _ in 0..<index {
            byIndex = byIndex?.next
        }
        
        while byIndex != nil {
            node = node?.next
            byIndex = byIndex?.next
        }
        
        return node?.data
    }
    
    //  checks if the linked list has a cycle. A cycle exists if any node in the
    //  linked list links to a node already visited.
    //  returns true if a cycle is found, false otherwise.
    public func has_cycle() -> Bool {
        var i = head
        var j = head
        while j!.next != nil {
            i = i?.next
            j = j?.next?.next
            if i === j {
                return true
            }
        }
        return false
    }
    
    //  Creates a cycle in the linked list for testing purposes
    //  Assumes the linked list has at least one node
    public func create_cycle() {
        if head != nil {
            //  navigate to last node
            var current = head
            while current?.next != nil {
                current = current?.next
            }
            
            current?.next = head //  make the last node link to first node
        }
    }
}


// test code
var my_linked_list = LinkedList()

// Add some values to the linked list
print("Adding 5, 3 and 1 to the linked list.")
my_linked_list.insert(5)
my_linked_list.insert(3)
my_linked_list.insert(1)

// print all elements
print("Printing elements in the linked list:")
my_linked_list.visit()

// Find the value at the nth node
print("Confirming values in the linked list using find_nth_from_beginning method.")
var value = my_linked_list.find_nth_from_beginning(2)
if value != 5 {
    print("BUG: Value at index 2 should be 5 and is \(value!)")
}
value = my_linked_list.find_nth_from_beginning(1)
if value != 3 {
    print("BUG: Value at index 1 should be 3 and is \(value!)")
}
value = my_linked_list.find_nth_from_beginning(0)
if value != 1 {
    print("BUG: Value at index 0 should be 1 and is \(value!)")
}

// print all elements
print("Printing elements in the linked list:")
my_linked_list.visit()

// Insert ascending
print("Adding 4 in ascending order.")
my_linked_list.insert_ascending(4)

// check newly inserted value
print("Checking values by calling find_nth_from_beginning method.")
value = my_linked_list.find_nth_from_beginning(2)
if value != 4 {
    print("BUG: Value at index 2 should be 4 and is \(value!)")
}
value = my_linked_list.find_nth_from_beginning(3)
if value != 5 {
    print("BUG: Value at index 3 should be 5 and is \(value!)")
}
value = my_linked_list.find_nth_from_beginning(1)
if value != 3 {
    print("BUG: Value at index 1 should be 3 and is \(value!)")
}

// Insert ascending
print("Adding 6 in ascening order.")
my_linked_list.insert_ascending(6)

// print all elements
print("Printing elements in the linked list:")
my_linked_list.visit()

// vaidate length
print("Confirming length of the linked list.")
var my_linked_list_length = my_linked_list.length()
if my_linked_list_length != 5 {
    print("BUG: Length should be 5 and not \(my_linked_list_length!)")
}

// find min and max
print("Confirming min and max values in the linked list.")
var min = my_linked_list.find_min()
if min != 1 {
    print("BUG: Min value should be 1 and not \(min!)")
}
var max = my_linked_list.find_max()
if max != 6 {
    print("BUG: Max value should be 5 and not \(max!)")
}

// delete value
print("Deleting node with value 5 from the linked list.")
my_linked_list.delete(5)
// print all elements
print("Printing elements in the linked list:")
my_linked_list.visit()
// validate length
print("Confirming length of the linked list.")
my_linked_list_length = my_linked_list.length()
if my_linked_list_length != 4 {
    print("BUG: Length should be 4 and not \(my_linked_list_length!)")
}

// delete value
print("Deleting node with value 1 from the linked list.")
my_linked_list.delete(1)
// print all elements
print("Printing elements in the linked list:")
my_linked_list.visit()
// validate length
print("Confirming length of the linked list.")
my_linked_list_length = my_linked_list.length()
if my_linked_list_length != 3 {
    print("BUG: Length should be 3 and not \(my_linked_list_length!)")
}

// find middle element
print("Confirming middle value in the linked list.")
var middle = my_linked_list.find_middle_value()
if middle != 4 {
    print("BUG: Middle value should be 4 and not \(middle!)")
}

// reverse the linked list
print("Reversing the linked list.")
my_linked_list.reverse()

// print all elements
print("Printing elements in the linked list:")
my_linked_list.visit()

// verify the reversed list
print("Verifying the reveresed linked list by calling find_nth_from_beginning method.")
value = my_linked_list.find_nth_from_beginning(2)
if value != 3 {
    print("BUG: Value at index 2 should be 3 and is \(value!)")
}

value = my_linked_list.find_nth_from_beginning(1)
if value != 4 {
    print("BUG: Value at index 1 should be 4 and is \(value!)")
}
value = my_linked_list.find_nth_from_beginning(0)
if value != 6 {
    print("BUG: Value at index 0 should be 6 and is \(value!)")
}

// nth from the end
print("Verifying find_nth_from_end method.")
value = my_linked_list.find_nth_from_end(0)
if value != 3 {
    print("BUG: Value at index 0 from the end, should be 3 and is \(value!)")
}
value = my_linked_list.find_nth_from_end(1)
if value != 4 {
    print("BUG: Value at index 1 from the end, should be 4 and is \(value!)")
}
value = my_linked_list.find_nth_from_end(2)
if value != 6 {
    print("BUG: Value at index 2 from the end, should be 6 and is \(value!)")
}

// check for cycle
print("Checking the linked list for cycle.")
if my_linked_list.has_cycle() {
    print("BUG: Should not have a cycle.")
}

// create cycle and then test for it
print("Creating a cycle in the linked list.")
my_linked_list.create_cycle()
print("Checking the linked list for cycle.")
if !my_linked_list.has_cycle() {
    print("BUG: Should not have a cycle.")
}
