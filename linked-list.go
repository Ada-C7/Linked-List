package main

import (
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

func (ll LinkedList) FindMax() int {
	current := ll.head
	max := ll.head.data

	for current != nil {
		if current.data > max {
			max = current.data
		}
		current = current.next
	}
	return max
}

func (ll LinkedList) FindMin() int {
	current := ll.head
	min := ll.head.data

	for current != nil {
		if current.data < min {
			min = current.data
		}
		current = current.next
	}
	return min
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
	fmt.Println("\nMax value:", myLinkedList.FindMax())
	fmt.Println("Max value:", myLinkedList.FindMin())

	// Validating length
	fmt.Println("\nConfirming length of the linked list.")
	fmt.Println("Length is:", myLinkedList.Length())

	// Find the value at the nth node
	fmt.Println("\nConfirming values in the linked list using FindNthFromBeginning method.")
	for i := 0; i < 4; i++ {
		if num, e := myLinkedList.FindNthFromBeginning(i); e != nil {
			fmt.Println("FAILURE:", e)
		} else {
			fmt.Printf("Value at index %v is: %v\n", i, num)
		}
	}
}
