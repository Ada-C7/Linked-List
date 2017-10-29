package linkedlist

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestInsert(t *testing.T) {
	ll := LinkedList{}

	ll.Insert(8)
	assert.Equal(t, 8, ll.head.data)

	ll.Insert(10)
	assert.True(t, ll.head.data == 10 || ll.head.next.data == 10)
}

func TestInsertAscending(t *testing.T) {
	ll := LinkedList{}
	assert.Nil(t, ll.head)

	ll.InsertAscending(9)
	ll.InsertAscending(3)
	ll.InsertAscending(26)
	ll.InsertAscending(-3)
	ll.InsertAscending(26)

	current := ll.head
	for _, num := range []int{-3, 3, 9, 26, 26} {
		assert.Equal(t, num, current.data)
		current = current.next
	}
}

func TestVisit(t *testing.T) {
	ll := LinkedList{}
	ll.InsertAscending(1)
	ll.InsertAscending(2)
	ll.InsertAscending(-7)
	ll.InsertAscending(10)
	ll.InsertAscending(4)

	assert.Equal(t, "-7 1 2 4 10", ll.Visit())
}

func TestSearch(t *testing.T) {
	ll := LinkedList{}
	ll.Insert(10)
	ll.Insert(3)

	assert.True(t, ll.Search(10))
	assert.True(t, ll.Search(3))
	assert.False(t, ll.Search(0))
}

func TestFindMax(t *testing.T) {
	ll := LinkedList{}
	max, err := ll.FindMax()
	assert.Error(t, err)
	assert.Equal(t, -1, max)

	ll.Insert(1)
	ll.Insert(2)
	ll.Insert(-7)
	ll.Insert(10)
	ll.Insert(4)

	max, err = ll.FindMax()
	assert.NoError(t, err)
	assert.Equal(t, 10, max)
}

func TestFindMin(t *testing.T) {
	ll := LinkedList{}
	min, err := ll.FindMin()
	assert.Error(t, err)
	assert.Equal(t, -1, min)

	ll.Insert(1)
	ll.Insert(2)
	ll.Insert(-7)
	ll.Insert(10)
	ll.Insert(4)

	min, err = ll.FindMin()
	assert.NoError(t, err)
	assert.Equal(t, -7, min)
}

func TestLength(t *testing.T) {
	ll := LinkedList{}
	assert.Zero(t, ll.Length())

	ll.Insert(3)
	assert.Equal(t, 1, ll.Length())

	ll.Insert(6)
	ll.Insert(1)
	ll.Insert(26)
	assert.Equal(t, 4, ll.Length())
}

func TestFindNthFromBeginning(t *testing.T) {
	ll := LinkedList{}
	num, err := ll.FindNthFromBeginning(0)
	assert.Error(t, err)
	assert.Equal(t, -1, num)

	ll.InsertAscending(1)
	num, err = ll.FindNthFromBeginning(5)
	assert.Error(t, err)
	assert.Equal(t, -1, num)

	ll.InsertAscending(2)
	ll.InsertAscending(-7)
	ll.InsertAscending(10)
	ll.InsertAscending(4)

	for i, expectNum := range []int{-7, 1, 2, 4, 10} {
		num, err = ll.FindNthFromBeginning(i)
		assert.NoError(t, err)
		assert.Equal(t, expectNum, num)
	}
}

func TestFindNthFromEnd(t *testing.T) {
	ll := LinkedList{}
	num, err := ll.FindNthFromEnd(0)
	assert.Error(t, err)
	assert.Equal(t, -1, num)

	ll.InsertAscending(1)
	num, err = ll.FindNthFromEnd(5)
	assert.Error(t, err)
	assert.Equal(t, -1, num)

	ll.InsertAscending(2)
	ll.InsertAscending(-7)
	ll.InsertAscending(10)
	ll.InsertAscending(4)

	for i, expectNum := range []int{10, 4, 2, 1, -7} {
		num, err = ll.FindNthFromEnd(i)
		assert.NoError(t, err)
		assert.Equal(t, expectNum, num)
	}
}

func TestFindMiddleValue(t *testing.T) {
	ll := LinkedList{}
	num, err := ll.FindMiddleValue()
	assert.Error(t, err)
	assert.Equal(t, -1, num)

	ll.InsertAscending(1)
	num, err = ll.FindMiddleValue()
	assert.NoError(t, err)
	assert.Equal(t, 1, num)

	ll.InsertAscending(2)
	num, _ = ll.FindMiddleValue()
	assert.Equal(t, 1, num)

	ll.InsertAscending(3)
	num, _ = ll.FindMiddleValue()
	assert.Equal(t, 2, num)

	ll.InsertAscending(4)
	num, _ = ll.FindMiddleValue()
	assert.Equal(t, 2, num)

	ll.InsertAscending(4)
	num, _ = ll.FindMiddleValue()
	assert.Equal(t, 3, num)
}

func TestReverse(t *testing.T) {
	ll := LinkedList{}
	ll.Reverse()
	assert.Nil(t, ll.head)

	ll.InsertAscending(1)
	ll.Reverse()
	assert.Equal(t, 1, ll.head.data)

	ll.InsertAscending(2)
	ll.InsertAscending(-7)
	ll.InsertAscending(10)
	ll.InsertAscending(4)

	ll.Reverse()

	current := ll.head
	for _, num := range []int{10, 4, 2, 1, -7} {
		assert.Equal(t, num, current.data)
		current = current.next
	}
}

func TestDelete(t *testing.T) {
	ll := LinkedList{}
	ll.Insert(4)
	ll.Delete(4)
	assert.Nil(t, ll.head)
	assert.False(t, ll.Search(4))

	ll.Insert(1)
	ll.Insert(2)
	ll.Insert(3)
	ll.Insert(3)
	ll.Insert(4)
	ll.Insert(5)

	ll.Delete(1)
	assert.False(t, ll.Search(1))

	ll.Delete(5)
	assert.False(t, ll.Search(5))

	ll.Delete(3)
	assert.True(t, ll.Search(3))

	ll.Delete(3)
	assert.False(t, ll.Search(3))
}

func TestCreateCycle(t *testing.T) {
	ll1 := LinkedList{}
	err := ll1.CreateCycle()
	assert.Error(t, err)

	ll1.Insert(4)
	err = ll1.CreateCycle()
	assert.NoError(t, err)
	assert.Equal(t, ll1.head, ll1.head.next)

	ll2 := LinkedList{}
	ll2.InsertAscending(1)
	ll2.InsertAscending(2)

	err = ll2.CreateCycle()
	assert.NoError(t, err)
	assert.Equal(t, ll2.head, ll2.head.next.next)
}

func TestHasCycle(t *testing.T) {
	ll1 := LinkedList{}
	assert.False(t, ll1.HasCycle())

	ll1.Insert(1)
	assert.False(t, ll1.HasCycle())
	ll1.CreateCycle()
	assert.True(t, ll1.HasCycle())

	ll2 := LinkedList{}
	ll2.Insert(2)
	ll2.Insert(3)
	assert.False(t, ll2.HasCycle())

	ll2.Insert(3)
	ll2.Insert(4)
	ll2.Insert(5)
	assert.False(t, ll2.HasCycle())

	ll2.CreateCycle()
	assert.True(t, ll2.HasCycle())
}
