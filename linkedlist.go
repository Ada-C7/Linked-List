package linkedlist

import (
	"errors"
	"fmt"
)

// LinkedList stores the head Node of a linked list
type LinkedList struct {
	head *Node
}

// Node stores the data and pointer to the next Node in a linked list
type Node struct {
	data int
	next *Node
}

// Insert inserts a new node with specified value into the linked list
func (ll *LinkedList) Insert(val int) {
	newNode := Node{val, ll.head}
	ll.head = &newNode
}

// InsertAscending insert a node into into a linked list in ascending order
func (ll *LinkedList) InsertAscending(n int) {
	if ll.head == nil || n <= ll.head.data {
		newNode := Node{n, ll.head}
		ll.head = &newNode
		return
	}

	current := ll.head
	for current.next != nil {
		if n <= current.next.data {
			newNode := Node{n, current.next}
			current.next = &newNode
			return
		}
		current = current.next
	}
	current.next = &Node{n, nil}
}

// Visit returns a string of the values of a linked list and prints them
func (ll LinkedList) Visit() string {
	dataStr := ""
	current := ll.head
	for current != nil {
		dataStr += fmt.Sprintf("%d", current.data)
		if current.next != nil {
			dataStr += " "
		}
		fmt.Printf("%v ", current.data)

		current = current.next
	}
	fmt.Println()

	return dataStr
}

// Search returns true if the specified value is found in the linked list
// and false if not
func (ll LinkedList) Search(val int) bool {
	current := ll.head
	for current != nil {
		if current.data == val {
			return true
		}
		current = current.next
	}

	return false
}

// FindMax finds the maximum value in the linked list
func (ll LinkedList) FindMax() (int, error) {
	if ll.head == nil {
		return -1, errors.New("no maximum value found")
	}

	current := ll.head
	max := ll.head.data
	for current != nil {
		if current.data > max {
			max = current.data
		}
		current = current.next
	}

	return max, nil
}

// FindMin finds the minimum value in the linked list
func (ll LinkedList) FindMin() (int, error) {
	if ll.head == nil {
		return -1, errors.New("no minimum value found")
	}

	current := ll.head
	min := ll.head.data
	for current != nil {
		if current.data < min {
			min = current.data
		}
		current = current.next
	}

	return min, nil
}

// Length returns the number of nodes in the linked list
func (ll LinkedList) Length() int {
	count := 0
	current := ll.head

	for current != nil {
		count++
		current = current.next
	}
	return count
}

// FindNthFromBeginning returns the value of nth node from the beginning
func (ll LinkedList) FindNthFromBeginning(n int) (int, error) {
	count := 0
	current := ll.head
	for current != nil {
		if count == n {
			return current.data, nil
		}

		count++
		current = current.next
	}

	return -1, fmt.Errorf("There is no element at index %v", n)
}

// FindNthFromEnd returns the value of the nth from the end node in the linked list
func (ll LinkedList) FindNthFromEnd(n int) (int, error) {
	current := ll.head
	for i := 0; i <= n; i++ {
		if current == nil {
			return -1, fmt.Errorf("There is no element %v from the end.", n)
		}
		current = current.next
	}

	nthBehind := ll.head
	for current != nil {
		current = current.next
		nthBehind = nthBehind.next
	}

	return nthBehind.data, nil
}

// FindMiddleValue returns the value of the middle node in the linked list
func (ll LinkedList) FindMiddleValue() (int, error) {
	if ll.head == nil {
		return -1, errors.New("cannot find middle value")
	}

	middle := ll.head
	end := ll.head.next
	for end != nil {
		if end.next != nil {
			middle = middle.next
			end = end.next.next
		} else {
			end = nil
		}
	}

	return middle.data, nil
}

// Reverse reverses the nodes in the linked list
func (ll *LinkedList) Reverse() {
	if ll.head == nil || ll.head.next == nil {
		return
	}

	prev := ll.head
	current := ll.head.next
	prev.next = nil
	for current != nil {
		temp := current.next
		current.next = prev
		prev = current
		current = temp
	}

	ll.head = prev
}

// Delete deletes the first node in a linked list that holds the specified value
func (ll *LinkedList) Delete(n int) {
	if ll.head.data == n {
		ll.head = ll.head.next
		return
	}

	temp := ll.head
	current := ll.head
	for current != nil {
		if current.data == n {
			temp.next = current.next
			return
		}

		temp = current
		current = current.next
	}
}

// CreateCycle creates a cycle in the linked list
func (ll *LinkedList) CreateCycle() error {
	if ll.Length() == 0 {
		return errors.New("cannot create a cycle with no nodes")
	}

	current := ll.head
	for current.next != nil {
		current = current.next
	}

	current.next = ll.head
	return nil
}

// HasCycle returns true if the linked list has a cycle and false otherwise
func (ll LinkedList) HasCycle() bool {
	if ll.head == nil {
		return false
	}

	slow := ll.head
	fast := ll.head.next
	for fast != nil {
		if fast.next != nil {
			fast = fast.next.next
		} else {
			return false
		}

		slow = slow.next
		if slow == fast {
			return true
		}
	}

	return false
}
