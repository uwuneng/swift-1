// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Sort.swift.gyb", line: 1)
//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2017 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Sort.swift.gyb", line: 21)

// Generate two versions of sorting functions: one with an explicitly passed
// predicate 'areInIncreasingOrder' and the other for Comparable types that don't
// need such a predicate.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Sort.swift.gyb", line: 35)

@inlinable
internal func _insertionSort<C>(
  _ elements: inout C,
  subRange range: Range<C.Index>
  , by areInIncreasingOrder: (C.Element, C.Element) throws -> Bool
) rethrows 
  where
  C : MutableCollection & BidirectionalCollection
   {

  if !range.isEmpty {
    let start = range.lowerBound

    // Keep track of the end of the initial sequence of sorted
    // elements.
    var sortedEnd = start

    // One element is trivially already-sorted, thus pre-increment
    // Continue until the sorted elements cover the whole sequence
    elements.formIndex(after: &sortedEnd)
    while sortedEnd != range.upperBound {
      // get the first unsorted element
      let x: C.Element = elements[sortedEnd]

      // Look backwards for x's position in the sorted sequence,
      // moving elements forward to make room.
      var i = sortedEnd
      repeat {
        let predecessor: C.Element = elements[elements.index(before: i)]

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Sort.swift.gyb", line: 67)
        // If clouser throws the error, We catch the error put the element at right
        // place and rethrow the error.
        do {
          // if x doesn't belong before y, we've found its position
          if !(try areInIncreasingOrder(x, predecessor)) {
            break
          }
        } catch {
          elements[i] = x
          throw error
        }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Sort.swift.gyb", line: 83)

        // Move y forward
        elements[i] = predecessor
        elements.formIndex(before: &i)
      } while i != start

      if i != sortedEnd {
        // Plop x into position
        elements[i] = x
      }
      elements.formIndex(after: &sortedEnd)
    }
  }
}

/// Sorts the elements at `elements[a]`, `elements[b]`, and `elements[c]`.
/// Stable.
///
/// The indices passed as `a`, `b`, and `c` do not need to be consecutive, but
/// must be in strict increasing order.
///
/// - Precondition: `a < b && b < c`
/// - Postcondition: `elements[a] <= elements[b] && elements[b] <= elements[c]`
@inlinable
public // @testable
func _sort3<C>(
  _ elements: inout C,
  _ a: C.Index, _ b: C.Index, _ c: C.Index
  , by areInIncreasingOrder: (C.Element, C.Element) throws -> Bool
) rethrows
  where
  C : MutableCollection & RandomAccessCollection
  
{
  // There are thirteen possible permutations for the original ordering of
  // the elements at indices `a`, `b`, and `c`. The comments in the code below
  // show the relative ordering of the three elements using a three-digit
  // number as shorthand for the position and comparative relationship of
  // each element. For example, "312" indicates that the element at `a` is the
  // largest of the three, the element at `b` is the smallest, and the element
  // at `c` is the median. This hypothetical input array has a 312 ordering for
  // `a`, `b`, and `c`:
  //
  //      [ 7, 4, 3, 9, 2, 0, 3, 7, 6, 5 ]
  //        ^              ^           ^
  //        a              b           c
  //
  // - If each of the three elements is distinct, they could be ordered as any
  //   of the permutations of 1, 2, and 3: 123, 132, 213, 231, 312, or 321.
  // - If two elements are equivalent and one is distinct, they could be
  //   ordered as any permutation of 1, 1, and 2 or 1, 2, and 2: 112, 121, 211,
  //   122, 212, or 221.
  // - If all three elements are equivalent, they are already in order: 111.

  switch ((try areInIncreasingOrder(elements[b], elements[a])),
    (try areInIncreasingOrder(elements[c], elements[b]))) {
  case (false, false):
    // 0 swaps: 123, 112, 122, 111
    break

  case (true, true):
    // 1 swap: 321
    // swap(a, c): 312->123
    elements.swapAt(a, c)

  case (true, false):
    // 1 swap: 213, 212 --- 2 swaps: 312, 211
    // swap(a, b): 213->123, 212->122, 312->132, 211->121
    elements.swapAt(a, b)

    if (try areInIncreasingOrder(elements[c], elements[b])) {
      // 132 (started as 312), 121 (started as 211)
      // swap(b, c): 132->123, 121->112
      elements.swapAt(b, c)
    }

  case (false, true):
    // 1 swap: 132, 121 --- 2 swaps: 231, 221
    // swap(b, c): 132->123, 121->112, 231->213, 221->212
    elements.swapAt(b, c)

    if (try areInIncreasingOrder(elements[b], elements[a])) {
      // 213 (started as 231), 212 (started as 221)
      // swap(a, b): 213->123, 212->122
      elements.swapAt(a, b)
    }
  }
}

/// Reorders `elements` and returns an index `p` such that every element in
/// `elements[range.lowerBound..<p]` is less than every element in
/// `elements[p..<range.upperBound]`.
///
/// - Precondition: The count of `range` must be >= 3:
///   `elements.distance(from: range.lowerBound, to: range.upperBound) >= 3`
@inlinable
internal func _partition<C>(
  _ elements: inout C,
  subRange range: Range<C.Index>
  , by areInIncreasingOrder: (C.Element, C.Element) throws -> Bool
) rethrows -> C.Index
  where
  C : MutableCollection & RandomAccessCollection
  
{
  var lo = range.lowerBound
  var hi = elements.index(before: range.upperBound)

  // Sort the first, middle, and last elements, then use the middle value
  // as the pivot for the partition.
  let half = numericCast(elements.distance(from: lo, to: hi)) as UInt / 2
  let mid = elements.index(lo, offsetBy: numericCast(half))
  try _sort3(&elements, lo, mid, hi
    , by: areInIncreasingOrder)
  let pivot = elements[mid]

  // Loop invariants:
  // * lo < hi
  // * elements[i] < pivot, for i in range.lowerBound..<lo
  // * pivot <= elements[i] for i in hi..<range.upperBound
  Loop: while true {
    FindLo: do {
      elements.formIndex(after: &lo)
      while lo != hi {
        if !(try areInIncreasingOrder(elements[lo], pivot)) { break FindLo }
        elements.formIndex(after: &lo)
      }
      break Loop
    }

    FindHi: do {
      elements.formIndex(before: &hi)
      while hi != lo {
        if (try areInIncreasingOrder(elements[hi], pivot)) { break FindHi }
        elements.formIndex(before: &hi)
      }
      break Loop
    }

    elements.swapAt(lo, hi)
  }

  return lo
}

@inlinable
public // @testable
func _introSort<C>(
  _ elements: inout C,
  subRange range: Range<C.Index>
  , by areInIncreasingOrder: (C.Element, C.Element) throws -> Bool
) rethrows 
  where
  C : MutableCollection & RandomAccessCollection
   {

  let count =
    elements.distance(from: range.lowerBound, to: range.upperBound)
  if count < 2 {
    return
  }
  // Set max recursion depth to 2*floor(log(N)), as suggested in the introsort
  // paper: http://www.cs.rpi.edu/~musser/gp/introsort.ps
  let depthLimit = 2 * count._binaryLogarithm()
  try _introSortImpl(
    &elements,
    subRange: range,
    by: areInIncreasingOrder,
    depthLimit: depthLimit)
}

@inlinable
internal func _introSortImpl<C>(
  _ elements: inout C,
  subRange range: Range<C.Index>
  , by areInIncreasingOrder: (C.Element, C.Element) throws -> Bool,
  depthLimit: Int
) rethrows
  where
  C : MutableCollection & RandomAccessCollection
   {

  // Insertion sort is better at handling smaller regions.
  if elements.distance(from: range.lowerBound, to: range.upperBound) < 20 {
    try _insertionSort(
      &elements,
      subRange: range
      , by: areInIncreasingOrder)
    return
  }
  if depthLimit == 0 {
    try _heapSort(
      &elements,
      subRange: range
      , by: areInIncreasingOrder)
    return
  }

  // Partition and sort.
  // We don't check the depthLimit variable for underflow because this variable
  // is always greater than zero (see check above).
  let partIdx: C.Index = try _partition(
    &elements,
    subRange: range
    , by: areInIncreasingOrder)
  try _introSortImpl(
    &elements,
    subRange: range.lowerBound..<partIdx,
    by: areInIncreasingOrder, 
    depthLimit: depthLimit &- 1)
  try _introSortImpl(
    &elements,
    subRange: partIdx..<range.upperBound,
    by: areInIncreasingOrder, 
    depthLimit: depthLimit &- 1)
}

@inlinable
internal func _siftDown<C>(
  _ elements: inout C,
  index: C.Index,
  subRange range: Range<C.Index>
  , by areInIncreasingOrder: (C.Element, C.Element) throws -> Bool
) rethrows
  where
  C : MutableCollection & RandomAccessCollection
   {

  let countToIndex = elements.distance(from: range.lowerBound, to: index)
  let countFromIndex = elements.distance(from: index, to: range.upperBound)
  // Check if left child is within bounds. If not, return, because there are
  // no children of the given node in the heap.
  if countToIndex + 1 >= countFromIndex {
    return
  }
  let left = elements.index(index, offsetBy: countToIndex + 1)
  var largest = index
  if (try areInIncreasingOrder(elements[largest], elements[left])) {
    largest = left
  }
  // Check if right child is also within bounds before trying to examine it.
  if countToIndex + 2 < countFromIndex {
    let right = elements.index(after: left)
    if (try areInIncreasingOrder(elements[largest], elements[right])) {
      largest = right
    }
  }
  // If a child is bigger than the current node, swap them and continue sifting
  // down.
  if largest != index {
    elements.swapAt(index, largest)
    try _siftDown(
      &elements,
      index: largest,
      subRange: range
      , by: areInIncreasingOrder)
  }
}

@inlinable
internal func _heapify<C>(
  _ elements: inout C,
  subRange range: Range<C.Index>
  , by areInIncreasingOrder: (C.Element, C.Element) throws -> Bool
) rethrows
  where
  C : MutableCollection & RandomAccessCollection
   {
  // Here we build a heap starting from the lowest nodes and moving to the root.
  // On every step we sift down the current node to obey the max-heap property:
  //   parent >= max(leftChild, rightChild)
  //
  // We skip the rightmost half of the array, because these nodes don't have
  // any children.
  let root = range.lowerBound
  var node = elements.index(
    root,
    offsetBy: elements.distance(
      from: range.lowerBound, to: range.upperBound) / 2)

  while node != root {
    elements.formIndex(before: &node)
    try _siftDown(
      &elements,
      index: node,
      subRange: range
      , by: areInIncreasingOrder)
  }
}

@inlinable
internal func _heapSort<C>(
  _ elements: inout C,
  subRange range: Range<C.Index>
  , by areInIncreasingOrder: (C.Element, C.Element) throws -> Bool
) rethrows 
  where
  C : MutableCollection & RandomAccessCollection
   {
  var hi = range.upperBound
  let lo = range.lowerBound
  try _heapify(
    &elements,
    subRange: range
    , by: areInIncreasingOrder)
  elements.formIndex(before: &hi)
  while hi != lo {
    elements.swapAt(lo, hi)
    try _siftDown(
      &elements,
      index: lo,
      subRange: lo..<hi
      , by: areInIncreasingOrder)
    elements.formIndex(before: &hi)
  }
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Sort.swift.gyb", line: 35)

@inlinable
internal func _insertionSort<C>(
  _ elements: inout C,
  subRange range: Range<C.Index>
  
)  
  where
  C : MutableCollection & BidirectionalCollection
  , C.Element : Comparable {

  if !range.isEmpty {
    let start = range.lowerBound

    // Keep track of the end of the initial sequence of sorted
    // elements.
    var sortedEnd = start

    // One element is trivially already-sorted, thus pre-increment
    // Continue until the sorted elements cover the whole sequence
    elements.formIndex(after: &sortedEnd)
    while sortedEnd != range.upperBound {
      // get the first unsorted element
      let x: C.Element = elements[sortedEnd]

      // Look backwards for x's position in the sorted sequence,
      // moving elements forward to make room.
      var i = sortedEnd
      repeat {
        let predecessor: C.Element = elements[elements.index(before: i)]

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Sort.swift.gyb", line: 79)
        if !(x < predecessor) {
          break
        }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Sort.swift.gyb", line: 83)

        // Move y forward
        elements[i] = predecessor
        elements.formIndex(before: &i)
      } while i != start

      if i != sortedEnd {
        // Plop x into position
        elements[i] = x
      }
      elements.formIndex(after: &sortedEnd)
    }
  }
}

/// Sorts the elements at `elements[a]`, `elements[b]`, and `elements[c]`.
/// Stable.
///
/// The indices passed as `a`, `b`, and `c` do not need to be consecutive, but
/// must be in strict increasing order.
///
/// - Precondition: `a < b && b < c`
/// - Postcondition: `elements[a] <= elements[b] && elements[b] <= elements[c]`
@inlinable
public // @testable
func _sort3<C>(
  _ elements: inout C,
  _ a: C.Index, _ b: C.Index, _ c: C.Index
  
) 
  where
  C : MutableCollection & RandomAccessCollection
  , C.Element : Comparable
{
  // There are thirteen possible permutations for the original ordering of
  // the elements at indices `a`, `b`, and `c`. The comments in the code below
  // show the relative ordering of the three elements using a three-digit
  // number as shorthand for the position and comparative relationship of
  // each element. For example, "312" indicates that the element at `a` is the
  // largest of the three, the element at `b` is the smallest, and the element
  // at `c` is the median. This hypothetical input array has a 312 ordering for
  // `a`, `b`, and `c`:
  //
  //      [ 7, 4, 3, 9, 2, 0, 3, 7, 6, 5 ]
  //        ^              ^           ^
  //        a              b           c
  //
  // - If each of the three elements is distinct, they could be ordered as any
  //   of the permutations of 1, 2, and 3: 123, 132, 213, 231, 312, or 321.
  // - If two elements are equivalent and one is distinct, they could be
  //   ordered as any permutation of 1, 1, and 2 or 1, 2, and 2: 112, 121, 211,
  //   122, 212, or 221.
  // - If all three elements are equivalent, they are already in order: 111.

  switch ((elements[b] < elements[a]),
    (elements[c] < elements[b])) {
  case (false, false):
    // 0 swaps: 123, 112, 122, 111
    break

  case (true, true):
    // 1 swap: 321
    // swap(a, c): 312->123
    elements.swapAt(a, c)

  case (true, false):
    // 1 swap: 213, 212 --- 2 swaps: 312, 211
    // swap(a, b): 213->123, 212->122, 312->132, 211->121
    elements.swapAt(a, b)

    if (elements[c] < elements[b]) {
      // 132 (started as 312), 121 (started as 211)
      // swap(b, c): 132->123, 121->112
      elements.swapAt(b, c)
    }

  case (false, true):
    // 1 swap: 132, 121 --- 2 swaps: 231, 221
    // swap(b, c): 132->123, 121->112, 231->213, 221->212
    elements.swapAt(b, c)

    if (elements[b] < elements[a]) {
      // 213 (started as 231), 212 (started as 221)
      // swap(a, b): 213->123, 212->122
      elements.swapAt(a, b)
    }
  }
}

/// Reorders `elements` and returns an index `p` such that every element in
/// `elements[range.lowerBound..<p]` is less than every element in
/// `elements[p..<range.upperBound]`.
///
/// - Precondition: The count of `range` must be >= 3:
///   `elements.distance(from: range.lowerBound, to: range.upperBound) >= 3`
@inlinable
internal func _partition<C>(
  _ elements: inout C,
  subRange range: Range<C.Index>
  
)  -> C.Index
  where
  C : MutableCollection & RandomAccessCollection
  , C.Element : Comparable
{
  var lo = range.lowerBound
  var hi = elements.index(before: range.upperBound)

  // Sort the first, middle, and last elements, then use the middle value
  // as the pivot for the partition.
  let half = numericCast(elements.distance(from: lo, to: hi)) as UInt / 2
  let mid = elements.index(lo, offsetBy: numericCast(half))
   _sort3(&elements, lo, mid, hi
    )
  let pivot = elements[mid]

  // Loop invariants:
  // * lo < hi
  // * elements[i] < pivot, for i in range.lowerBound..<lo
  // * pivot <= elements[i] for i in hi..<range.upperBound
  Loop: while true {
    FindLo: do {
      elements.formIndex(after: &lo)
      while lo != hi {
        if !(elements[lo] < pivot) { break FindLo }
        elements.formIndex(after: &lo)
      }
      break Loop
    }

    FindHi: do {
      elements.formIndex(before: &hi)
      while hi != lo {
        if (elements[hi] < pivot) { break FindHi }
        elements.formIndex(before: &hi)
      }
      break Loop
    }

    elements.swapAt(lo, hi)
  }

  return lo
}

@inlinable
public // @testable
func _introSort<C>(
  _ elements: inout C,
  subRange range: Range<C.Index>
  
)  
  where
  C : MutableCollection & RandomAccessCollection
  , C.Element : Comparable {

  let count =
    elements.distance(from: range.lowerBound, to: range.upperBound)
  if count < 2 {
    return
  }
  // Set max recursion depth to 2*floor(log(N)), as suggested in the introsort
  // paper: http://www.cs.rpi.edu/~musser/gp/introsort.ps
  let depthLimit = 2 * count._binaryLogarithm()
   _introSortImpl(
    &elements,
    subRange: range,
    
    depthLimit: depthLimit)
}

@inlinable
internal func _introSortImpl<C>(
  _ elements: inout C,
  subRange range: Range<C.Index>
  ,
  depthLimit: Int
) 
  where
  C : MutableCollection & RandomAccessCollection
  , C.Element : Comparable {

  // Insertion sort is better at handling smaller regions.
  if elements.distance(from: range.lowerBound, to: range.upperBound) < 20 {
     _insertionSort(
      &elements,
      subRange: range
      )
    return
  }
  if depthLimit == 0 {
     _heapSort(
      &elements,
      subRange: range
      )
    return
  }

  // Partition and sort.
  // We don't check the depthLimit variable for underflow because this variable
  // is always greater than zero (see check above).
  let partIdx: C.Index =  _partition(
    &elements,
    subRange: range
    )
   _introSortImpl(
    &elements,
    subRange: range.lowerBound..<partIdx,
    
    depthLimit: depthLimit &- 1)
   _introSortImpl(
    &elements,
    subRange: partIdx..<range.upperBound,
    
    depthLimit: depthLimit &- 1)
}

@inlinable
internal func _siftDown<C>(
  _ elements: inout C,
  index: C.Index,
  subRange range: Range<C.Index>
  
) 
  where
  C : MutableCollection & RandomAccessCollection
  , C.Element : Comparable {

  let countToIndex = elements.distance(from: range.lowerBound, to: index)
  let countFromIndex = elements.distance(from: index, to: range.upperBound)
  // Check if left child is within bounds. If not, return, because there are
  // no children of the given node in the heap.
  if countToIndex + 1 >= countFromIndex {
    return
  }
  let left = elements.index(index, offsetBy: countToIndex + 1)
  var largest = index
  if (elements[largest] < elements[left]) {
    largest = left
  }
  // Check if right child is also within bounds before trying to examine it.
  if countToIndex + 2 < countFromIndex {
    let right = elements.index(after: left)
    if (elements[largest] < elements[right]) {
      largest = right
    }
  }
  // If a child is bigger than the current node, swap them and continue sifting
  // down.
  if largest != index {
    elements.swapAt(index, largest)
     _siftDown(
      &elements,
      index: largest,
      subRange: range
      )
  }
}

@inlinable
internal func _heapify<C>(
  _ elements: inout C,
  subRange range: Range<C.Index>
  
) 
  where
  C : MutableCollection & RandomAccessCollection
  , C.Element : Comparable {
  // Here we build a heap starting from the lowest nodes and moving to the root.
  // On every step we sift down the current node to obey the max-heap property:
  //   parent >= max(leftChild, rightChild)
  //
  // We skip the rightmost half of the array, because these nodes don't have
  // any children.
  let root = range.lowerBound
  var node = elements.index(
    root,
    offsetBy: elements.distance(
      from: range.lowerBound, to: range.upperBound) / 2)

  while node != root {
    elements.formIndex(before: &node)
     _siftDown(
      &elements,
      index: node,
      subRange: range
      )
  }
}

@inlinable
internal func _heapSort<C>(
  _ elements: inout C,
  subRange range: Range<C.Index>
  
)  
  where
  C : MutableCollection & RandomAccessCollection
  , C.Element : Comparable {
  var hi = range.upperBound
  let lo = range.lowerBound
   _heapify(
    &elements,
    subRange: range
    )
  elements.formIndex(before: &hi)
  while hi != lo {
    elements.swapAt(lo, hi)
     _siftDown(
      &elements,
      index: lo,
      subRange: lo..<hi
      )
    elements.formIndex(before: &hi)
  }
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Sort.swift.gyb", line: 401)
// for p in preds

/// Exchanges the values of the two arguments.
///
/// The two arguments must not alias each other. To swap two elements of a
/// mutable collection, use the `swapAt(_:_:)` method of that collection
/// instead of this function.
///
/// - Parameters:
///   - a: The first value to swap.
///   - b: The second value to swap.
@inlinable
public func swap<T>(_ a: inout T, _ b: inout T) {
  // Semantically equivalent to (a, b) = (b, a).
  // Microoptimized to avoid retain/release traffic.
  let p1 = Builtin.addressof(&a)
  let p2 = Builtin.addressof(&b)
  _debugPrecondition(
    p1 != p2,
    "swapping a location with itself is not supported")

  // Take from P1.
  let tmp: T = Builtin.take(p1)
  // Transfer P2 into P1.
  Builtin.initialize(Builtin.take(p2) as T, p1)
  // Initialize P2.
  Builtin.initialize(tmp, p2)
}
