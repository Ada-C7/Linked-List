package main

import (
	"fmt"
)

type Node struct {
	data int
	next *Node
}

type LList struct {
	head *Node
}

// NEW_LIST(): creates new linked list and returns its pointer
func newList() *LList {
	head := &Node{0, nil}
	list := &LList{head}
	return list
}

// INSERT(): add new node with value to the beginning of linked list
func (l *LList) insert(val int) {
	newNode := &Node{val, l.head}
	// point head of the linked list to the inserted node
	l.head = newNode
}

// SEARCH: returns true if input value is found in linked list
func (l *LList) search(val int) bool {
	current := l.head
	// Note: no `while` loops in Golang so using `for`
	for current.next != nil {
		if current.data == val {
			return true
		}
		current = current.next
	}
	return false
}

// FINDMAX(): returns the largest value in linked list
func (l *LList) findMax() int {
	current := l.head
	max := current.data
	for current.next != nil {
		if current.data > max {
			max = current.data
		}
		current = current.next
	}
	return max
}

// FINDMIN(): returns the smallest value in linked list
func (l *LList) findMin() int {
	current := l.head
	min := current.data
	for current.next != nil {
		if current.data < min {
			min = current.data
		}
		current = current.next
	}
	return min
}

// LENGTH(): returns number of nodes in linked list
func (l *LList) length() int {
	current := l.head
	length := 0
	for current.next != nil {
		length++
		current = current.next
	}
	return length
}

// FIND_NTH_FROM_BEG(): returns value of nth node from beginning
func (l *LList) findNthFromBeg(n int) int {
	current := l.head
	for i := 1; i < n; i++ {
		current = current.next
	}
	return current.data
}

// INSERT_ASCENDING(): insert value alrady sorted linked list (ascending)
// returns true for breakpoints
func (l *LList) insertAscending(val int) bool {
	current := l.head
	next := current.next
	// if value is minimum, use already existing method to insert at beg.
	if val < current.data {
		l.insert(val)
		return true
	}
	for next != nil {
		if next.data > val {
			newNode := &Node{val, next}
			current.next = newNode
			return true
		}
		current = next
		next = current.next
	}
	// if it was never added until the end, add as tail
	tailNode := &Node{val, nil}
	current.next = tailNode
	return true
}

// VISIT(): prints each value delimited by a space in a linked list
func (l *LList) visit() {
	current := l.head
	for current.next != nil {
		fmt.Print(current.data)
		fmt.Print(" ")
		current = current.next
	}
	fmt.Println("")
}

// LENGTH(): returns number of nodes in a linked list
func (l *LList) deleteNode(val int) {
	current := l.head
	previous := l.head
	for current.next != nil {
		if current.data == val {
			// set parent's pointer to next before deleting current
			previous.next = current.next
			// dereference for GC to take care of
			current = nil
			// reasign current
			current = previous.next
		} else {
			previous = current
			current = current.next
		}
	}
}

// REVERSE(): method traverses linked list once and reserses each of the pointers
// and sets the head as the previous tail node
func (l *LList) reverse() {
	// initialize temp vars
	current := l.head
	var prev = &Node{0, nil}
	// while loop to traverse linked list
	for {
		// keep track of next node as 'after'
		tNext := current.next
		// reverse pointer of current node to previous
		current.next = prev
		// shift both prev and current by one node
		prev = current
		current = tNext
		if current.next == nil {
			break
		}
	}
	// assigns head of the reversed linked list with last node
	l.head = prev
}

// FIND_MIDDLE_VALUE(): two temp with one traversing the linked list in double
// the speed
func (l *LList) findMiddleValue() int {
	single := l.head
	double := l.head
	for double.next != nil {
		single = single.next
		// double is next, next node (+2)
		double = single.next
	}
	return single.data
}

// FIND_NTH_FROM_END():
func (l *LList) findNthFromEnd(n int) int {
	current := l.head
	nAhead := l.head
	// move second pointer ahead by n nodes
	for i := 0; i < n; i++ {
		nAhead = nAhead.next
	}
	// stop when second pointer reaches tail
	for nAhead.next != nil {
		current = current.next
		nAhead = nAhead.next
	}
	return current.data
}

// HAS_CYCLE(): returns true if linked list is self-referential, otherwise returns false
func (l *LList) hasCycle() bool {
	// initialize temp vars
	fast := l.head.next
	slow := l.head
	cycles := false

	for {
		// if either reach the tail it does not have a cycle
		if slow.next == nil || fast.next == nil {
			break
		}
		// if they line up then there is a cycle
		if slow == fast {
			cycles = true
			break
		}
		// fast moves two nodes while slow moves one node
		fast = fast.next.next
		slow = slow.next
	}
	return cycles
}

func main() {
	list := newList()
	fmt.Println("Current head: ")
	fmt.Println(list.head)

	list.insert(2)
	list.insert(5)
	list.insert(3)
	list.insert(1)
	list.insert(-1)
	list.insert(7)

	fmt.Println("Print list: ")
	list.visit()
	fmt.Println("Current head: ")
	fmt.Println(list.head)

	fmt.Println("Search: expect true: ")
	fmt.Println(list.search(2))
	fmt.Println("Search: expect false: ")
	fmt.Println(list.search(10))

	fmt.Println("FindMax: expect 7: ")
	fmt.Println(list.findMax())

	fmt.Println("FindMin: expect -1: ")
	fmt.Println(list.findMin())

	fmt.Println("Find2FromEnd: expect 5: ")
	fmt.Println(list.findNthFromEnd(2))

	fmt.Println("Length: expect 6: ")
	fmt.Println(list.length())

	fmt.Println("Delete value 2: ")
	list.deleteNode(2)
	list.visit()

	fmt.Println("Reverse list: ")
	list.reverse()
	list.visit()
	fmt.Println("Current head: ")
	fmt.Println(list.head)

	fmt.Println("Has cycle: expect false: ")
	fmt.Printf("%t", list.hasCycle())
	// TODO: figure out a way to test true case - must implement circular list
}
