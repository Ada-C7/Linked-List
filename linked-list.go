package main

import "fmt"

type LinkedList struct {
	head *Node
}

type Node struct {
	data int
	next *Node
}

func (ll LinkedList) visit() {
	fmt.Println("VISITNG")
	current := ll.head

	for current != nil {
		fmt.Printf("%v ", current.data)
		current = current.next
	}
	fmt.Println()
}

func (ll *LinkedList) insert(val int) {
	newNode := Node{val, ll.head}
	ll.head = &newNode
}

func main() {
	myLinkedList := LinkedList{}

	fmt.Println("Adding 5, 3 and 1 to the linked list.")
	myLinkedList.insert(5)
	myLinkedList.insert(3)
	myLinkedList.insert(1)

	fmt.Println("Printing elements in the linked list:")
	myLinkedList.visit()
}
