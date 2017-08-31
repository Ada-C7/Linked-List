class Node {
  constructor(data) {
    this._data = data;
    this.nextNode = null;
  }

  getData() {
    return this._data;
  }


}

class LinkedList {
  constructor() {
    this.head = null;
  }

  length() {
    var currentNode = this.head;
    var length = 0;

    if(!currentNode) {
      return null;
    }

    while(currentNode) {
      length++;
      currentNode = currentNode.nextNode;
    }
    return length;
  }

  insert(value) {
    var node = new Node(value);
    var currentNode = this.head;

    if(!currentNode) {
      this.head = node;

      return node;
    }

    currentNode = this.head;
    node.nextNode = currentNode;
    this.head = node;

    this._length++;
    return node;
  }

  search(value) {
    var currentNode = this.head;
    if(!currentNode) {
      return false;
    }

    while(currentNode.nextNode) {
      if(currentNode.getData() === value) {
        return true;
      }
      currentNode = currentNode.nextNode;
    }

    return false;
  }

  findMax() {
    var currentNode = this.head;
    var max = this.head.getData();
    if(!currentNode) {
      return null;
    }

    for(var i = 0; i < this.length(); i++) {
      if(currentNode.getData() > max) {
        max = currentNode.getData();
      }
      currentNode = currentNode.nextNode;
    }

    return max;
  }

  findMin() {
    var currentNode = this.head;
    var min = this.head.getData();

    if(!currentNode) {
      return null;
    }

    for(var i = 0; i < this.length(); i++) {
      if(currentNode.getData() < min) {
        min = currentNode.getData();
      }
      currentNode = currentNode.nextNode;
    }

    return min;
  }

  findNthFromBeginning(index) {
    var currentNode = this.head;
    if(!currentNode) {
      return null;
    }
    for(var i = 0; i < index; i++) {
      currentNode = currentNode.nextNode;
    }

    return (currentNode ? currentNode.getData() : null);
  }

  visit() {
    var printString = "";
    var currentNode = this.head;
    if(!currentNode) {
      return null;
    }

    for(var i = 0; i < this.length(); i++) {
      printString += currentNode.getData() + " ";
      currentNode = currentNode.nextNode;
    }

    console.log(printString);
  }

  insertAscending(value) {
    var currentNode = this.head;
    var node = new Node(value);
    var inserted = false;



    if(!currentNode) {
      return null;
    }

    while(currentNode.nextNode) {
      var nextNode = currentNode.nextNode;

      if(currentNode.getData() < value && nextNode.getData() > value) {
        var tempNode = currentNode.nextNode;
        node.nextNode = tempNode;
        currentNode.nextNode = node;
        inserted = true;

      }
      currentNode = currentNode.nextNode;
    }

    if(!inserted) {
      currentNode.nextNode = node;
    }
  }

  deleteNode(value) {
    var currentNode = this.head;
    var nextNode;

    if(!currentNode) {
      return null;
    }

    if(this.head.getData() === value ) {
      nextNode = this.head.nextNode;
      this.head = nextNode;
    } else {
      while(currentNode.nextNode) {
        nextNode = currentNode.nextNode;
        if(nextNode.getData() === value ) {
          var tempNode = nextNode.nextNode;
          currentNode.nextNode = nextNode.nextNode;
        }
        currentNode = currentNode.nextNode;
      }
    }
  }

  reverse() {
    var currentNode = this.head;
    var previousNode = null;
    var tempNode = null;

    if(!currentNode) { return null; }

    while(currentNode) {
      tempNode = currentNode.nextNode;
      currentNode.nextNode = previousNode;
      previousNode = currentNode;
      currentNode = tempNode;
    }

    this.head = previousNode;
  }

  findNthFromEnd(index) {
    var currentNode = this.head;

    for(var i = 0; i < index; i++) {
      currentNode = currentNode.nextNode;
    }
    var trailingNode = this.head;

    while(currentNode.nextNode) {
      currentNode = currentNode.nextNode;
      trailingNode = trailingNode.nextNode;
    }

    return trailingNode.getData();

  }

  hasCycle() {
    var slowNode = this.head;
    var fastNode = this.head;

    if(!fastNode || !fastNode.nextNode) { return false; }

    while(fastNode) {
      var fastNext = fastNode.nextNode.nextNode;
      if(!fastNext.nextNode) {
        return false;
      } else {
        fastNode = fastNext.nextNode;
      }
      if(fastNode === slowNode) { return true; }
      slowNode = slowNode.nextNode;

    }

    return false;
  }

  createCycle() {
    var currentNode = this.head;
    if(!currentNode) {
      return null;
    }

    while(currentNode.nextNode) {
      currentNode = currentNode.nextNode;
    }
    currentNode.nextNode = this.head;
  }
}



// ## --- END of class definitions --- ##
//
// # Create an object of linked list class
my_linked_list = new LinkedList();
//
// # Add some values to the linked list
console.log("Adding 5, 3 and 1 to the linked list.");
my_linked_list.insert(5);
my_linked_list.insert(3);
my_linked_list.insert(1);
//
// # print all elements
console.log("Printing elements in the linked list:");
my_linked_list.visit();
//
// # Find the value at the nth node
console.log("Confirming values in the linked list using find_nth_from_beginning method.");
value = my_linked_list.findNthFromBeginning(2);
console.log("Value at index 2 should be 5 and is " + value);

value = my_linked_list.findNthFromBeginning(1);
console.log("Value at index 1 should be 3 and is " + value);

value = my_linked_list.findNthFromBeginning(0);
console.log("Value at index 0 should be 1 and is " + value);

// # Insert ascending
console.log("Adding 4 in ascending order.");
my_linked_list.insertAscending(4);
// # check newly inserted value
console.log("Checking values by calling find_nth_from_beginning method.");
value = my_linked_list.findNthFromBeginning(2);
console.log("Value at index 2 should be 4 and is " + value);
value = my_linked_list.findNthFromBeginning(3);
console.log("Value at index 3 should be 5 and is " + value);
value = my_linked_list.findNthFromBeginning(1);
console.log("Value at index 1 should be 3 and is " + value);
//
// # Insert ascending
console.log("Adding 6 in ascending order.");
my_linked_list.insertAscending(6);
//
// # print all elements
console.log("Printing elements in the linked list:");
my_linked_list.visit();
//
// # validate length
console.log("Confirming length of the linked list.");

my_linked_list_length = my_linked_list.length();
console.log("The length should be 5 and is " + my_linked_list_length);
// puts "BUG: Length should be 5 and not #{my_linked_list_length}" if my_linked_list_length != 5


// # find min and max
console.log("Confirming min and max values in the linked list.");
var min = my_linked_list.findMin();
console.log("Min value should be 1 and is " + min);
var max = my_linked_list.findMax();
console.log("Max value should be 5 and is " + max);

// # delete value
console.log("Deleting node with value 5 from the linked list.");
my_linked_list.deleteNode(5);

// # print all elements
console.log("Printing elements in the linked list:");
my_linked_list.visit();

// # validate length
console.log("Confirming length of the linked list.");
my_linked_list_length = my_linked_list.length();
console.log("Length should be 4 and is " + my_linked_list_length);

// # delete value
console.log("Deleting node with value 1 from the linked list.");
my_linked_list.deleteNode(1);
// # print all elements
console.log("Printing elements in the linked list:");
my_linked_list.visit();
// # validate length
console.log("Confirming length of the linked list.");
my_linked_list_length = my_linked_list.length();
console.log("Length should be 3 and is " + my_linked_list_length);


// # reverse the linked list
console.log("Reversing the linked list.");
my_linked_list.reverse();
// # print all elements
console.log("Printing elements in the linked list:");
my_linked_list.visit();
// # verify the reversed list
console.log("Verifying the reversed linked list by calling find_nth_from_beginning method.");
value = my_linked_list.findNthFromBeginning(2);
console.log("Value at index 2 should be 3 and is " + value);
value = my_linked_list.findNthFromBeginning(1);
console.log("Value at index 1 should be 4 and is " + value);
value = my_linked_list.findNthFromBeginning(0);
console.log("Value at index 0 should be 6 and is " + value);
//
// # nth from the end
console.log("Verifying find_nth_from_end method.");
value = my_linked_list.findNthFromEnd(0);
console.log("Value at index 0 from end should be 3 and is " + value);
value = my_linked_list.findNthFromEnd(1);
console.log("Value at index 1 from end should be 4 and is " + value);
value = my_linked_list.findNthFromEnd(2);
console.log("Value at index 2 from end should be 6 and is " + value);
//
// # check for cycle
console.log("Checking the linked list for cycle.");
console.log("hasCycle returns " + my_linked_list.hasCycle() + " and should return false" );

//
// # create cycle and then test for it
console.log("Creating a cycle in the linked list.");
my_linked_list.createCycle();

console.log("Checking the linked list for cycle.");
console.log("hasCycle returns " + my_linked_list.hasCycle() + " and should return true");
