package main

import (
	"errors"
	"fmt"
)

type LinkedList struct {
	head *Node
}

type Node struct {
	data int
	next *Node
}

func (ll LinkedList) Visit() {
	current := ll.head

	for current != nil {
		fmt.Printf("%v ", current.data)
		current = current.next
	}
	fmt.Println()
}

func (ll *LinkedList) Insert(val int) {
	newNode := Node{val, ll.head}
	ll.head = &newNode
}

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

func (ll LinkedList) FindMax() (int, error) {
	if ll.head == nil {
		return -1, errors.New("No maximum value found.")
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

func (ll LinkedList) FindMin() (int, error) {
	if ll.head == nil {
		return -1, errors.New("No minimum value found.")
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

func (ll LinkedList) Length() int {
	count := 0
	current := ll.head

	for current != nil {
		count++
		current = current.next
	}
	return count
}

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

func (ll *LinkedList) Delete(n int) {
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

func main() {
	myLinkedList := LinkedList{}

	// Inserting values into linked list
	fmt.Println("Adding 5, 3, and 1 to the linked list.")
	myLinkedList.Insert(5)
	myLinkedList.Insert(3)
	myLinkedList.Insert(1)

	// Confirming values were inserted
	fmt.Println("\nPrinting elements in the linked list:")
	myLinkedList.Visit()

	// Confirming that search returns true/false for vals that are there/not
	fmt.Println("\nIs 5 in the list?", myLinkedList.Search(5))
	fmt.Println("Is 10 in the list?", myLinkedList.Search(10))

	// Confirming that max val and min val work
	if max, e := myLinkedList.FindMax(); e != nil {
		fmt.Println("\nFAILURE:", e)
	} else {
		fmt.Println("\nMax value:", max)
	}
	if min, e := myLinkedList.FindMin(); e != nil {
		fmt.Println("FAILURE:", e)
	} else {
		fmt.Println("Min value:", min)
	}

	// Validating length
	fmt.Println("\nConfirming length of the linked list.")
	fmt.Println("Length is:", myLinkedList.Length())

	// Find the value at the nth node
	fmt.Println("\nConfirming values in the linked list using FindNthFromBeginning method.")
	for i := 0; i < 3; i++ {
		if num, e := myLinkedList.FindNthFromBeginning(i); e != nil {
			fmt.Println("FAILURE:", e)
		} else {
			fmt.Printf("Value at index %v is: %v\n", i, num)
		}
	}

	// Print all elements
	fmt.Println("\nPrinting elements in the linked list:")
	myLinkedList.Visit()

	// Insert ascending
	fmt.Println("\nAdding 4 in ascending order.")
	myLinkedList.InsertAscending(4)

	// Check newly inserted value
	fmt.Println("Printing array with 4 added:")
	myLinkedList.Visit()

	// Delete value
	fmt.Println("\nDeleting node with value 5 from the linked list:")
	myLinkedList.Delete(5)
	myLinkedList.Visit()

	// Delete value not present
	fmt.Println("\nDeleting node with value 10 should not change the list")
	myLinkedList.Delete(10)
	myLinkedList.Visit()

	// Inserting two 6s
	myLinkedList.InsertAscending(6)
	myLinkedList.InsertAscending(6)
	fmt.Println("\nInserting two 6s:")
	myLinkedList.Visit()

	// Deleting a 6
	fmt.Println("\nDeleting a 6:")
	myLinkedList.Delete(6)
	myLinkedList.Visit()

	// Reverse the linked list
	fmt.Println("\nReversing the list:")
	myLinkedList.Reverse()
	myLinkedList.Visit()

	// Testing that errors work
	fmt.Println("\nMaking sure errors work properly on an empty linked list.")

	emptyLinkedList := LinkedList{}

	// Shouldn't be able to access an index that's empty.
	if num, e := emptyLinkedList.FindNthFromBeginning(0); e != nil {
		fmt.Println("FAILURE:", e)
	} else {
		fmt.Printf("Value of emptyLinkedList at index 0 is: %v\n", num)
	}

	// Shouldn't be able to find min or max in an empty linked list.
	if max, e := emptyLinkedList.FindMax(); e != nil {
		fmt.Println("\nFAILURE:", e)
	} else {
		fmt.Println("\nMax value:", max)
	}
	if min, e := emptyLinkedList.FindMin(); e != nil {
		fmt.Println("FAILURE:", e)
	} else {
		fmt.Println("Min value:", min)
	}

	// Length should be 0
	fmt.Println("\nConfirming length of emptyLinkedList.")
	fmt.Println("Length is:", emptyLinkedList.Length())

	// Visit should print nothing
	fmt.Println("\nVisiting emptyLinkedList should print nothing:")
	emptyLinkedList.Visit()

	// Can AssertAscending on empty list
	fmt.Println("\nChecking that we can AssertAscending on emptyLinkedList.")
	fmt.Println("\nInserting 9:")
	emptyLinkedList.InsertAscending(9)
	emptyLinkedList.Visit()

	fmt.Println("\nInserting 2:")
	emptyLinkedList.InsertAscending(2)
	emptyLinkedList.Visit()
}
