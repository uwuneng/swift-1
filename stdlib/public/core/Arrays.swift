// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 1)
//===--- Arrays.swift.gyb -------------------------------------*- swift -*-===//
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
//
//  Three generic, mutable array-like types with value semantics.
//
//  - `ContiguousArray<Element>` is a fast, contiguous array of `Element` with
//    a known backing store.
//
//  - `ArraySlice<Element>` presents an arbitrary subsequence of some
//    contiguous sequence of `Element`s.
//
//  - `Array<Element>` is like `ContiguousArray<Element>` when `Element` is not
//    a reference type or an Objective-C existential.  Otherwise, it may use
//    an `NSArray` bridged from Cocoa for storage.
//
//===----------------------------------------------------------------------===//

/// This type is used as a result of the _checkSubscript call to associate the
/// call with the array access call it guards.
@_fixed_layout
public struct _DependenceToken {
  @inlinable
  public init() {
  }
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 43)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 45)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 455)

/// A contiguously stored array.
///
/// The `ContiguousArray` type is a specialized array that always stores its
/// elements in a contiguous region of memory. This contrasts with `Array`,
/// which can store its elements in either a contiguous region of memory or an
/// `NSArray` instance if its `Element` type is a class or `@objc` protocol.
///
/// If your array's `Element` type is a class or `@objc` protocol and you do
/// not need to bridge the array to `NSArray` or pass the array to Objective-C
/// APIs, using `ContiguousArray` may be more efficient and have more
/// predictable performance than `Array`. If the array's `Element` type is a
/// struct or enumeration, `Array` and `ContiguousArray` should have similar
/// efficiency.
///
/// For more information about using arrays, see `Array` and `ArraySlice`, with
/// which `ContiguousArray` shares most properties and methods.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 457)
@_fixed_layout
public struct ContiguousArray<Element>: _DestructorSafeContainer {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 468)
    internal typealias _Buffer = _ContiguousArrayBuffer<Element>
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 470)

  @usableFromInline
  internal var _buffer: _Buffer

  /// Initialization from an existing buffer does not have "array.init"
  /// semantics because the caller may retain an alias to buffer.
  @inlinable
  internal init(_buffer: _Buffer) {
    self._buffer = _buffer
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 489)
}

extension ContiguousArray: RandomAccessCollection, MutableCollection {
  /// The index type for arrays, `Int`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 499)
  public typealias Index = Int

  /// The type that represents the indices that are valid for subscripting an
  /// array, in ascending order.
  public typealias Indices = Range<Int>

  /// The type that allows iteration over an array's elements.
  public typealias Iterator = IndexingIterator<ContiguousArray>

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 513)
  /// The position of the first element in a nonempty array.
  ///
  /// For an instance of `ContiguousArray`, `startIndex` is always zero. If the array
  /// is empty, `startIndex` is equal to `endIndex`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 518)
  @inlinable
  public var startIndex: Int {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 523)
    return 0
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 525)
  }

  /// The array's "past the end" position---that is, the position one greater
  /// than the last valid subscript argument.
  ///
  /// When you need a range that includes the last element of an array, use the
  /// half-open range operator (`..<`) with `endIndex`. The `..<` operator
  /// creates a range that doesn't include the upper bound, so it's always
  /// safe to use with `endIndex`. For example:
  ///
  ///     let numbers = [10, 20, 30, 40, 50]
  ///     if let i = numbers.firstIndex(of: 30) {
  ///         print(numbers[i ..< numbers.endIndex])
  ///     }
  ///     // Prints "[30, 40, 50]"
  ///
  /// If the array is empty, `endIndex` is equal to `startIndex`.
  @inlinable // FIXME(sil-serialize-all)
  public var endIndex: Int {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 547)
    @inlinable
    get {
      return _getCount()
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 552)
  }

  /// Returns the position immediately after the given index.
  ///
  /// - Parameter i: A valid index of the collection. `i` must be less than
  ///   `endIndex`.
  /// - Returns: The index immediately after `i`.
  @inlinable
  public func index(after i: Int) -> Int {
    // NOTE: this is a manual specialization of index movement for a Strideable
    // index that is required for Array performance.  The optimizer is not
    // capable of creating partial specializations yet.
    // NOTE: Range checks are not performed here, because it is done later by
    // the subscript function.
    return i + 1
  }

  /// Replaces the given index with its successor.
  ///
  /// - Parameter i: A valid index of the collection. `i` must be less than
  ///   `endIndex`.
  @inlinable
  public func formIndex(after i: inout Int) {
    // NOTE: this is a manual specialization of index movement for a Strideable
    // index that is required for Array performance.  The optimizer is not
    // capable of creating partial specializations yet.
    // NOTE: Range checks are not performed here, because it is done later by
    // the subscript function.
    i += 1
  }

  /// Returns the position immediately before the given index.
  ///
  /// - Parameter i: A valid index of the collection. `i` must be greater than
  ///   `startIndex`.
  /// - Returns: The index immediately before `i`.
  @inlinable
  public func index(before i: Int) -> Int {
    // NOTE: this is a manual specialization of index movement for a Strideable
    // index that is required for Array performance.  The optimizer is not
    // capable of creating partial specializations yet.
    // NOTE: Range checks are not performed here, because it is done later by
    // the subscript function.
    return i - 1
  }

  /// Replaces the given index with its predecessor.
  ///
  /// - Parameter i: A valid index of the collection. `i` must be greater than
  ///   `startIndex`.
  @inlinable
  public func formIndex(before i: inout Int) {
    // NOTE: this is a manual specialization of index movement for a Strideable
    // index that is required for Array performance.  The optimizer is not
    // capable of creating partial specializations yet.
    // NOTE: Range checks are not performed here, because it is done later by
    // the subscript function.
    i -= 1
  }

  /// Returns an index that is the specified distance from the given index.
  ///
  /// The following example obtains an index advanced four positions from an
  /// array's starting index and then prints the element at that position.
  ///
  ///     let numbers = [10, 20, 30, 40, 50]
  ///     let i = numbers.index(numbers.startIndex, offsetBy: 4)
  ///     print(numbers[i])
  ///     // Prints "50"
  ///
  /// The value passed as `n` must not offset `i` beyond the bounds of the
  /// collection.
  ///
  /// - Parameters:
  ///   - i: A valid index of the array.
  ///   - n: The distance to offset `i`.
  /// - Returns: An index offset by `n` from the index `i`. If `n` is positive,
  ///   this is the same value as the result of `n` calls to `index(after:)`.
  ///   If `n` is negative, this is the same value as the result of `-n` calls
  ///   to `index(before:)`.
  @inlinable
  public func index(_ i: Int, offsetBy n: Int) -> Int {
    // NOTE: this is a manual specialization of index movement for a Strideable
    // index that is required for Array performance.  The optimizer is not
    // capable of creating partial specializations yet.
    // NOTE: Range checks are not performed here, because it is done later by
    // the subscript function.
    return i + n
  }

  /// Returns an index that is the specified distance from the given index,
  /// unless that distance is beyond a given limiting index.
  ///
  /// The following example obtains an index advanced four positions from an
  /// array's starting index and then prints the element at that position. The
  /// operation doesn't require going beyond the limiting `numbers.endIndex`
  /// value, so it succeeds.
  ///
  ///     let numbers = [10, 20, 30, 40, 50]
  ///     if let i = numbers.index(numbers.startIndex,
  ///                              offsetBy: 4,
  ///                              limitedBy: numbers.endIndex) {
  ///         print(numbers[i])
  ///     }
  ///     // Prints "50"
  ///
  /// The next example attempts to retrieve an index ten positions from
  /// `numbers.startIndex`, but fails, because that distance is beyond the
  /// index passed as `limit`.
  ///
  ///     let j = numbers.index(numbers.startIndex,
  ///                           offsetBy: 10,
  ///                           limitedBy: numbers.endIndex)
  ///     print(j)
  ///     // Prints "nil"
  ///
  /// The value passed as `n` must not offset `i` beyond the bounds of the
  /// collection, unless the index passed as `limit` prevents offsetting
  /// beyond those bounds.
  ///
  /// - Parameters:
  ///   - i: A valid index of the array.
  ///   - n: The distance to offset `i`.
  ///   - limit: A valid index of the collection to use as a limit. If `n > 0`,
  ///     `limit` has no effect if it is less than `i`. Likewise, if `n < 0`,
  ///     `limit` has no effect if it is greater than `i`.
  /// - Returns: An index offset by `n` from the index `i`, unless that index
  ///   would be beyond `limit` in the direction of movement. In that case,
  ///   the method returns `nil`.
  @inlinable
  public func index(
    _ i: Int, offsetBy n: Int, limitedBy limit: Int
  ) -> Int? {
    // NOTE: this is a manual specialization of index movement for a Strideable
    // index that is required for Array performance.  The optimizer is not
    // capable of creating partial specializations yet.
    // NOTE: Range checks are not performed here, because it is done later by
    // the subscript function.
    let l = limit - i
    if n > 0 ? l >= 0 && l < n : l <= 0 && n < l {
      return nil
    }
    return i + n
  }

  /// Returns the distance between two indices.
  ///
  /// - Parameters:
  ///   - start: A valid index of the collection.
  ///   - end: Another valid index of the collection. If `end` is equal to
  ///     `start`, the result is zero.
  /// - Returns: The distance between `start` and `end`.
  @inlinable
  public func distance(from start: Int, to end: Int) -> Int {
    // NOTE: this is a manual specialization of index movement for a Strideable
    // index that is required for Array performance.  The optimizer is not
    // capable of creating partial specializations yet.
    // NOTE: Range checks are not performed here, because it is done later by
    // the subscript function.
    return end - start
  }

  @inlinable
  public func _failEarlyRangeCheck(_ index: Int, bounds: Range<Int>) {
    // NOTE: This method is a no-op for performance reasons.
  }

  @inlinable
  public func _failEarlyRangeCheck(_ range: Range<Int>, bounds: Range<Int>) {
    // NOTE: This method is a no-op for performance reasons.
  }

  /// Accesses the element at the specified position.
  ///
  /// The following example uses indexed subscripting to update an array's
  /// second element. After assigning the new value (`"Butler"`) at a specific
  /// position, that value is immediately available at that same position.
  ///
  ///     var streets = ["Adams", "Bryant", "Channing", "Douglas", "Evarts"]
  ///     streets[1] = "Butler"
  ///     print(streets[1])
  ///     // Prints "Butler"
  ///
  /// - Parameter index: The position of the element to access. `index` must be
  ///   greater than or equal to `startIndex` and less than `endIndex`.
  ///
  /// - Complexity: Reading an element from an array is O(1). Writing is O(1)
  ///   unless the array's storage is shared with another array, in which case
  ///   writing is O(*n*), where *n* is the length of the array.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 745)
  @inlinable
  public subscript(index: Int) -> Element {
    get {
      // This call may be hoisted or eliminated by the optimizer.  If
      // there is an inout violation, this value may be stale so needs to be
      // checked again below.
      let wasNativeTypeChecked = _hoistableIsNativeTypeChecked()

      // Make sure the index is in range and wasNativeTypeChecked is
      // still valid.
      let token = _checkSubscript(
        index, wasNativeTypeChecked: wasNativeTypeChecked)

      return _getElement(
        index, wasNativeTypeChecked: wasNativeTypeChecked,
        matchingSubscriptCheck: token)
    }
    mutableAddressWithPinnedNativeOwner {
      _makeMutableAndUniqueOrPinned() // makes the array native, too
      _checkSubscript_native(index)
      return (_getElementAddress(index), Builtin.tryPin(_getOwner_native()))
    }
  }

  /// Accesses a contiguous subrange of the array's elements.
  ///
  /// The returned `ArraySlice` instance uses the same indices for the same
  /// elements as the original array. In particular, that slice, unlike an
  /// array, may have a nonzero `startIndex` and an `endIndex` that is not
  /// equal to `count`. Always use the slice's `startIndex` and `endIndex`
  /// properties instead of assuming that its indices start or end at a
  /// particular value.
  ///
  /// This example demonstrates getting a slice of an array of strings, finding
  /// the index of one of the strings in the slice, and then using that index
  /// in the original array.
  ///
  ///     let streets = ["Adams", "Bryant", "Channing", "Douglas", "Evarts"]
  ///     let streetsSlice = streets[2 ..< streets.endIndex]
  ///     print(streetsSlice)
  ///     // Prints "["Channing", "Douglas", "Evarts"]"
  ///
  ///     let i = streetsSlice.firstIndex(of: "Evarts")    // 4
  ///     print(streets[i!])
  ///     // Prints "Evarts"
  ///
  /// - Parameter bounds: A range of integers. The bounds of the range must be
  ///   valid indices of the array.
  @inlinable
  public subscript(bounds: Range<Int>) -> ArraySlice<Element> {
    get {
      _checkIndex(bounds.lowerBound)
      _checkIndex(bounds.upperBound)
      return ArraySlice(_buffer: _buffer[bounds])
    }
    set(rhs) {
      _checkIndex(bounds.lowerBound)
      _checkIndex(bounds.upperBound)
      // If the replacement buffer has same identity, and the ranges match,
      // then this was a pinned in-place modification, nothing further needed.
      if self[bounds]._buffer.identity != rhs._buffer.identity
      || bounds != rhs.startIndex..<rhs.endIndex {
        self.replaceSubrange(bounds, with: rhs)
      }
    }
  }
}

//===--- private helpers---------------------------------------------------===//
extension ContiguousArray {
  /// Returns `true` if the array is native and does not need a deferred
  /// type check.  May be hoisted by the optimizer, which means its
  /// results may be stale by the time they are used if there is an
  /// inout violation in user code.
  @inlinable
  @_semantics("array.props.isNativeTypeChecked")
  public // @testable
  func _hoistableIsNativeTypeChecked() -> Bool {
   return _buffer.arrayPropertyIsNativeTypeChecked
  }

  @inlinable
  @_semantics("array.get_count")
  internal func _getCount() -> Int {
    return _buffer.count
  }

  @inlinable
  @_semantics("array.get_capacity")
  internal func _getCapacity() -> Int {
    return _buffer.capacity
  }

  /// - Precondition: The array has a native buffer.
  @inlinable
  @_semantics("array.owner")
  internal func _getOwnerWithSemanticLabel_native() -> Builtin.NativeObject {
    return Builtin.unsafeCastToNativeObject(_buffer.nativeOwner)
  }

  /// - Precondition: The array has a native buffer.
  @inlinable
  @inline(__always)
  internal func _getOwner_native() -> Builtin.NativeObject {
#if _runtime(_ObjC)
    if _isClassOrObjCExistential(Element.self) {
      // We are hiding the access to '_buffer.owner' behind
      // _getOwner() to help the compiler hoist uniqueness checks in
      // the case of class or Objective-C existential typed array
      // elements.
      return _getOwnerWithSemanticLabel_native()
    }
#endif
    // In the value typed case the extra call to
    // _getOwnerWithSemanticLabel_native hinders optimization.
    return Builtin.unsafeCastToNativeObject(_buffer.owner)
  }

  @inlinable
  @_semantics("array.make_mutable")
  internal mutating func _makeMutableAndUnique() {
    if _slowPath(!_buffer.isMutableAndUniquelyReferenced()) {
      _buffer = _Buffer(copying: _buffer)
    }
  }

  @inlinable
  @_semantics("array.make_mutable")
  internal mutating func _makeMutableAndUniqueOrPinned() {
    if _slowPath(!_buffer.isMutableAndUniquelyReferencedOrPinned()) {
      _buffer = _Buffer(copying: _buffer)
    }
  }


  /// Check that the given `index` is valid for subscripting, i.e.
  /// `0 ≤ index < count`.
  @inlinable
  @inline(__always)
  internal func _checkSubscript_native(_ index: Int) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 886)
    _buffer._checkValidSubscript(index)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 890)
  }

  /// Check that the given `index` is valid for subscripting, i.e.
  /// `0 ≤ index < count`.
  @inlinable
  @_semantics("array.check_subscript")
  public // @testable
  func _checkSubscript(
    _ index: Int, wasNativeTypeChecked: Bool
  ) -> _DependenceToken {
#if _runtime(_ObjC)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 905)
    _buffer._checkValidSubscript(index)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 907)
#else
    _buffer._checkValidSubscript(index)
#endif
    return _DependenceToken()
  }

  /// Check that the specified `index` is valid, i.e. `0 ≤ index ≤ count`.
  @inlinable
  @_semantics("array.check_index")
  internal func _checkIndex(_ index: Int) {
    _precondition(index <= endIndex, "ContiguousArray index is out of range")
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 919)
    _precondition(index >= startIndex, "Negative ContiguousArray index is out of range")
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 923)
  }

  @_semantics("array.get_element")
  @inline(__always)
  public // @testable
  func _getElement(
    _ index: Int,
    wasNativeTypeChecked : Bool,
    matchingSubscriptCheck: _DependenceToken
  ) -> Element {
#if false
    return _buffer.getElement(index, wasNativeTypeChecked: wasNativeTypeChecked)
#else
    return _buffer.getElement(index)
#endif
  }

  @inlinable
  @_semantics("array.get_element_address")
  internal func _getElementAddress(_ index: Int) -> UnsafeMutablePointer<Element> {
    return _buffer.subscriptBaseAddress + index
  }
}

extension ContiguousArray : ExpressibleByArrayLiteral {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 968)
  /// Creates an array from the given array literal.
  ///
  /// Do not call this initializer directly. It is used by the compiler when
  /// you use an array literal. Instead, create a new array by using an array
  /// literal as its value. To do this, enclose a comma-separated list of
  /// values in square brackets.
  ///
  /// Here, an array of strings is created from an array literal holding only
  /// strings:
  ///
  ///     let ingredients: ContiguousArray =
  ///           ["cocoa beans", "sugar", "cocoa butter", "salt"]
  ///
  /// - Parameter elements: A variadic list of elements of the new array.
  @inlinable
  public init(arrayLiteral elements: Element...) {
    self.init(_buffer: ContiguousArray(elements)._buffer)
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 987)
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 1029)

extension ContiguousArray : RangeReplaceableCollection, ArrayProtocol {
  /// Creates a new, empty array.
  ///
  /// This is equivalent to initializing with an empty array literal.
  /// For example:
  ///
  ///     var emptyArray = Array<Int>()
  ///     print(emptyArray.isEmpty)
  ///     // Prints "true"
  ///
  ///     emptyArray = []
  ///     print(emptyArray.isEmpty)
  ///     // Prints "true"
  @inlinable
  @_semantics("array.init")
  public init() {
    _buffer = _Buffer()
  }

  /// Creates an array containing the elements of a sequence.
  ///
  /// You can use this initializer to create an array from any other type that
  /// conforms to the `Sequence` protocol. For example, you might want to
  /// create an array with the integers from 1 through 7. Use this initializer
  /// around a range instead of typing all those numbers in an array literal.
  ///
  ///     let numbers = Array(1...7)
  ///     print(numbers)
  ///     // Prints "[1, 2, 3, 4, 5, 6, 7]"
  ///
  /// You can also use this initializer to convert a complex sequence or
  /// collection type back to an array. For example, the `keys` property of
  /// a dictionary isn't an array with its own storage, it's a collection
  /// that maps its elements from the dictionary only when they're
  /// accessed, saving the time and space needed to allocate an array. If
  /// you need to pass those keys to a method that takes an array, however,
  /// use this initializer to convert that list from its type of
  /// `LazyMapCollection<Dictionary<String, Int>, Int>` to a simple
  /// `[String]`.
  ///
  ///     func cacheImagesWithNames(names: [String]) {
  ///         // custom image loading and caching
  ///      }
  ///
  ///     let namedHues: [String: Int] = ["Vermillion": 18, "Magenta": 302,
  ///             "Gold": 50, "Cerise": 320]
  ///     let colorNames = Array(namedHues.keys)
  ///     cacheImagesWithNames(colorNames)
  ///
  ///     print(colorNames)
  ///     // Prints "["Gold", "Cerise", "Magenta", "Vermillion"]"
  ///
  /// - Parameter s: The sequence of elements to turn into an array.
  @inlinable
  public init<S : Sequence>(_ s: S)
    where S.Element == Element {

    self = ContiguousArray(
      _buffer: _Buffer(
        _buffer: s._copyToContiguousArray()._buffer,
        shiftedToStartIndex: 0))
  }

  /// Creates a new array containing the specified number of a single, repeated
  /// value.
  ///
  /// Here's an example of creating an array initialized with five strings
  /// containing the letter *Z*.
  ///
  ///     let fiveZs = Array(repeating: "Z", count: 5)
  ///     print(fiveZs)
  ///     // Prints "["Z", "Z", "Z", "Z", "Z"]"
  ///
  /// - Parameters:
  ///   - repeatedValue: The element to repeat.
  ///   - count: The number of times to repeat the value passed in the
  ///     `repeating` parameter. `count` must be zero or greater.
  @inlinable
  @_semantics("array.init")
  public init(repeating repeatedValue: Element, count: Int) {
    var p: UnsafeMutablePointer<Element>
    (self, p) = ContiguousArray._allocateUninitialized(count)
    for _ in 0..<count {
      p.initialize(to: repeatedValue)
      p += 1
    }
  }

  @inlinable
  @inline(never)
  internal static func _allocateBufferUninitialized(
    minimumCapacity: Int
  ) -> _Buffer {
    let newBuffer = _ContiguousArrayBuffer<Element>(
      _uninitializedCount: 0, minimumCapacity: minimumCapacity)
    return _Buffer(_buffer: newBuffer, shiftedToStartIndex: 0)
  }

  /// Construct a ContiguousArray of `count` uninitialized elements.
  @inlinable
  internal init(_uninitializedCount count: Int) {
    _precondition(count >= 0, "Can't construct ContiguousArray with count < 0")
    // Note: Sinking this constructor into an else branch below causes an extra
    // Retain/Release.
    _buffer = _Buffer()
    if count > 0 {
      // Creating a buffer instead of calling reserveCapacity saves doing an
      // unnecessary uniqueness check. We disable inlining here to curb code
      // growth.
      _buffer = ContiguousArray._allocateBufferUninitialized(minimumCapacity: count)
      _buffer.count = count
    }
    // Can't store count here because the buffer might be pointing to the
    // shared empty array.
  }

  /// Entry point for `Array` literal construction; builds and returns
  /// a ContiguousArray of `count` uninitialized elements.
  @inlinable
  @_semantics("array.uninitialized")
  internal static func _allocateUninitialized(
    _ count: Int
  ) -> (ContiguousArray, UnsafeMutablePointer<Element>) {
    let result = ContiguousArray(_uninitializedCount: count)
    return (result, result._buffer.firstElementAddress)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 1189)

  /// The number of elements in the array.
  @inlinable
  public var count: Int {
    return _getCount()
  }

  /// The total number of elements that the array can contain without
  /// allocating new storage.
  ///
  /// Every array reserves a specific amount of memory to hold its contents.
  /// When you add elements to an array and that array begins to exceed its
  /// reserved capacity, the array allocates a larger region of memory and
  /// copies its elements into the new storage. The new storage is a multiple
  /// of the old storage's size. This exponential growth strategy means that
  /// appending an element happens in constant time, averaging the performance
  /// of many append operations. Append operations that trigger reallocation
  /// have a performance cost, but they occur less and less often as the array
  /// grows larger.
  ///
  /// The following example creates an array of integers from an array literal,
  /// then appends the elements of another collection. Before appending, the
  /// array allocates new storage that is large enough store the resulting
  /// elements.
  ///
  ///     var numbers = [10, 20, 30, 40, 50]
  ///     // numbers.count == 5
  ///     // numbers.capacity == 5
  ///
  ///     numbers.append(contentsOf: stride(from: 60, through: 100, by: 10))
  ///     // numbers.count == 10
  ///     // numbers.capacity == 12
  @inlinable
  public var capacity: Int {
    return _getCapacity()
  }

  /// An object that guarantees the lifetime of this array's elements.
  @inlinable
  public // @testable
  var _owner: AnyObject? {
    return _buffer.owner
  }

  /// If the elements are stored contiguously, a pointer to the first
  /// element. Otherwise, `nil`.
  @inlinable
  public var _baseAddressIfContiguous: UnsafeMutablePointer<Element>? {
    @inline(__always) // FIXME(TODO: JIRA): Hack around test failure
    get { return _buffer.firstElementAddressIfContiguous }
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 1242)
  @inlinable
  internal var _baseAddress: UnsafeMutablePointer<Element> {
    return _buffer.firstElementAddress
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 1247)
  //===--- basic mutations ------------------------------------------------===//


  /// Reserves enough space to store the specified number of elements.
  ///
  /// If you are adding a known number of elements to an array, use this method
  /// to avoid multiple reallocations. This method ensures that the array has
  /// unique, mutable, contiguous storage, with space allocated for at least
  /// the requested number of elements.
  ///
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 1263)
  /// For performance reasons, the size of the newly allocated storage might be
  /// greater than the requested capacity. Use the array's `capacity` property
  /// to determine the size of the new storage.
  ///
  /// Preserving an Array's Geometric Growth Strategy
  /// ===============================================
  ///
  /// If you implement a custom data structure backed by an array that grows
  /// dynamically, naively calling the `reserveCapacity(_:)` method can lead
  /// to worse than expected performance. Arrays need to follow a geometric
  /// allocation pattern for appending elements to achieve amortized
  /// constant-time performance. The `Array` type's `append(_:)` and
  /// `append(contentsOf:)` methods take care of this detail for you, but
  /// `reserveCapacity(_:)` allocates only as much space as you tell it to
  /// (padded to a round value), and no more. This avoids over-allocation, but
  /// can result in insertion not having amortized constant-time performance.
  ///
  /// The following code declares `values`, an array of integers, and the
  /// `addTenQuadratic()` function, which adds ten more values to the `values`
  /// array on each call.
  ///
  ///       var values: [Int] = [0, 1, 2, 3]
  ///
  ///       // Don't use 'reserveCapacity(_:)' like this
  ///       func addTenQuadratic() {
  ///           let newCount = values.count + 10
  ///           values.reserveCapacity(newCount)
  ///           for n in values.count..<newCount {
  ///               values.append(n)
  ///           }
  ///       }
  ///
  /// The call to `reserveCapacity(_:)` increases the `values` array's capacity
  /// by exactly 10 elements on each pass through `addTenQuadratic()`, which
  /// is linear growth. Instead of having constant time when averaged over
  /// many calls, the function may decay to performance that is linear in
  /// `values.count`. This is almost certainly not what you want.
  ///
  /// In cases like this, the simplest fix is often to simply remove the call
  /// to `reserveCapacity(_:)`, and let the `append(_:)` method grow the array
  /// for you.
  ///
  ///       func addTen() {
  ///           let newCount = values.count + 10
  ///           for n in values.count..<newCount {
  ///               values.append(n)
  ///           }
  ///       }
  ///
  /// If you need more control over the capacity of your array, implement your
  /// own geometric growth strategy, passing the size you compute to
  /// `reserveCapacity(_:)`.
  ///
  /// - Parameter minimumCapacity: The requested number of elements to store.
  ///
  /// - Complexity: O(*n*), where *n* is the number of elements in the array.
  @inlinable
  @_semantics("array.mutate_unknown")
  public mutating func reserveCapacity(_ minimumCapacity: Int) {
    if _buffer.requestUniqueMutableBackingBuffer(
      minimumCapacity: minimumCapacity) == nil {

      let newBuffer = _ContiguousArrayBuffer<Element>(
        _uninitializedCount: count, minimumCapacity: minimumCapacity)

      _buffer._copyContents(
        subRange: _buffer.indices,
        initializing: newBuffer.firstElementAddress)
      _buffer = _Buffer(
        _buffer: newBuffer, shiftedToStartIndex: _buffer.startIndex)
    }
    _sanityCheck(capacity >= minimumCapacity)
  }

  /// Copy the contents of the current buffer to a new unique mutable buffer.
  /// The count of the new buffer is set to `oldCount`, the capacity of the
  /// new buffer is big enough to hold 'oldCount' + 1 elements.
  @inlinable
  @inline(never)
  internal mutating func _copyToNewBuffer(oldCount: Int) {
    let newCount = oldCount + 1
    var newBuffer = _buffer._forceCreateUniqueMutableBuffer(
      countForNewBuffer: oldCount, minNewCapacity: newCount)
    _buffer._arrayOutOfPlaceUpdate(
      &newBuffer, oldCount, 0, _IgnorePointer())
  }

  @inlinable
  @_semantics("array.make_mutable")
  internal mutating func _makeUniqueAndReserveCapacityIfNotUnique() {
    if _slowPath(!_buffer.isMutableAndUniquelyReferenced()) {
      _copyToNewBuffer(oldCount: _buffer.count)
    }
  }

  @inlinable
  @_semantics("array.mutate_unknown")
  internal mutating func _reserveCapacityAssumingUniqueBuffer(oldCount: Int) {
    // This is a performance optimization. This code used to be in an ||
    // statement in the _sanityCheck below.
    //
    //   _sanityCheck(_buffer.capacity == 0 ||
    //                _buffer.isMutableAndUniquelyReferenced())
    //
    // SR-6437
    let capacity = _buffer.capacity == 0

    // Due to make_mutable hoisting the situation can arise where we hoist
    // _makeMutableAndUnique out of loop and use it to replace
    // _makeUniqueAndReserveCapacityIfNotUnique that preceeds this call. If the
    // array was empty _makeMutableAndUnique does not replace the empty array
    // buffer by a unique buffer (it just replaces it by the empty array
    // singleton).
    // This specific case is okay because we will make the buffer unique in this
    // function because we request a capacity > 0 and therefore _copyToNewBuffer
    // will be called creating a new buffer.
    _sanityCheck(capacity ||
                 _buffer.isMutableAndUniquelyReferenced())

    if _slowPath(oldCount + 1 > _buffer.capacity) {
      _copyToNewBuffer(oldCount: oldCount)
    }
  }

  @inlinable
  @_semantics("array.mutate_unknown")
  internal mutating func _appendElementAssumeUniqueAndCapacity(
    _ oldCount: Int,
    newElement: Element
  ) {
    _sanityCheck(_buffer.isMutableAndUniquelyReferenced())
    _sanityCheck(_buffer.capacity >= _buffer.count + 1)

    _buffer.count = oldCount + 1
    (_buffer.firstElementAddress + oldCount).initialize(to: newElement)
  }

  /// Adds a new element at the end of the array.
  ///
  /// Use this method to append a single element to the end of a mutable array.
  ///
  ///     var numbers = [1, 2, 3, 4, 5]
  ///     numbers.append(100)
  ///     print(numbers)
  ///     // Prints "[1, 2, 3, 4, 5, 100]"
  ///
  /// Because arrays increase their allocated capacity using an exponential
  /// strategy, appending a single element to an array is an O(1) operation
  /// when averaged over many calls to the `append(_:)` method. When an array
  /// has additional capacity and is not sharing its storage with another
  /// instance, appending an element is O(1). When an array needs to
  /// reallocate storage before appending or its storage is shared with
  /// another copy, appending is O(*n*), where *n* is the length of the array.
  ///
  /// - Parameter newElement: The element to append to the array.
  ///
  /// - Complexity: Amortized O(1) over many additions. If the array uses a
  ///   bridged `NSArray` instance as its storage, the efficiency is
  ///   unspecified.
  @inlinable
  @_semantics("array.append_element")
  public mutating func append(_ newElement: Element) {
    _makeUniqueAndReserveCapacityIfNotUnique()
    let oldCount = _getCount()
    _reserveCapacityAssumingUniqueBuffer(oldCount: oldCount)
    _appendElementAssumeUniqueAndCapacity(oldCount, newElement: newElement)
  }

  /// Adds the elements of a sequence to the end of the array.
  ///
  /// Use this method to append the elements of a sequence to the end of this
  /// array. This example appends the elements of a `Range<Int>` instance
  /// to an array of integers.
  ///
  ///     var numbers = [1, 2, 3, 4, 5]
  ///     numbers.append(contentsOf: 10...15)
  ///     print(numbers)
  ///     // Prints "[1, 2, 3, 4, 5, 10, 11, 12, 13, 14, 15]"
  ///
  /// - Parameter newElements: The elements to append to the array.
  ///
  /// - Complexity: O(*n*), where *n* is the length of the resulting array.
  @inlinable
  @_semantics("array.append_contentsOf")
  public mutating func append<S : Sequence>(contentsOf newElements: S)
    where S.Element == Element {

    let newElementsCount = newElements.underestimatedCount
    reserveCapacityForAppend(newElementsCount: newElementsCount)

    let oldCount = self.count
    let startNewElements = _buffer.firstElementAddress + oldCount
    let buf = UnsafeMutableBufferPointer(
                start: startNewElements, 
                count: self.capacity - oldCount)

    let (remainder,writtenUpTo) = buf.initialize(from: newElements)
    
    // trap on underflow from the sequence's underestimate:
    let writtenCount = buf.distance(from: buf.startIndex, to: writtenUpTo)
    _precondition(newElementsCount <= writtenCount, 
      "newElements.underestimatedCount was an overestimate")
    // can't check for overflow as sequences can underestimate

    _buffer.count += writtenCount

    if writtenUpTo == buf.endIndex {
      // there may be elements that didn't fit in the existing buffer,
      // append them in slow sequence-only mode
      _buffer._arrayAppendSequence(IteratorSequence(remainder))
    }
  }

  @inlinable
  @_semantics("array.reserve_capacity_for_append")
  internal mutating func reserveCapacityForAppend(newElementsCount: Int) {
    let oldCount = self.count
    let oldCapacity = self.capacity
    let newCount = oldCount + newElementsCount

    // Ensure uniqueness, mutability, and sufficient storage.  Note that
    // for consistency, we need unique self even if newElements is empty.
    self.reserveCapacity(
      newCount > oldCapacity ?
      Swift.max(newCount, _growArrayCapacity(oldCapacity))
      : newCount)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 1532)
  @inlinable
  public mutating func _customRemoveLast() -> Element? {
    let newCount = _getCount() - 1
    _precondition(newCount >= 0, "Can't removeLast from an empty ContiguousArray")
    _makeUniqueAndReserveCapacityIfNotUnique()
    let pointer = (_buffer.firstElementAddress + newCount)
    let element = pointer.move()
    _buffer.count = newCount
    return element
  }

  /// Removes and returns the element at the specified position.
  ///
  /// All the elements following the specified position are moved up to
  /// close the gap.
  ///
  ///     var measurements: [Double] = [1.1, 1.5, 2.9, 1.2, 1.5, 1.3, 1.2]
  ///     let removed = measurements.remove(at: 2)
  ///     print(measurements)
  ///     // Prints "[1.1, 1.5, 1.2, 1.5, 1.3, 1.2]"
  ///
  /// - Parameter index: The position of the element to remove. `index` must
  ///   be a valid index of the array.
  /// - Returns: The element at the specified index.
  ///
  /// - Complexity: O(*n*), where *n* is the length of the array.
  @inlinable
  @discardableResult
  public mutating func remove(at index: Int) -> Element {
    _precondition(index < endIndex, "Index out of range")
    _precondition(index >= startIndex, "Index out of range")
    _makeUniqueAndReserveCapacityIfNotUnique()
    let newCount = _getCount() - 1
    let pointer = (_buffer.firstElementAddress + index)
    let result = pointer.move()
    pointer.moveInitialize(from: pointer + 1, count: newCount - index)
    _buffer.count = newCount
    return result
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 1572)

  /// Inserts a new element at the specified position.
  ///
  /// The new element is inserted before the element currently at the specified
  /// index. If you pass the array's `endIndex` property as the `index`
  /// parameter, the new element is appended to the array.
  ///
  ///     var numbers = [1, 2, 3, 4, 5]
  ///     numbers.insert(100, at: 3)
  ///     numbers.insert(200, at: numbers.endIndex)
  ///
  ///     print(numbers)
  ///     // Prints "[1, 2, 3, 100, 4, 5, 200]"
  ///
  /// - Parameter newElement: The new element to insert into the array.
  /// - Parameter i: The position at which to insert the new element.
  ///   `index` must be a valid index of the array or equal to its `endIndex`
  ///   property.
  ///
  /// - Complexity: O(*n*), where *n* is the length of the array.
  @inlinable
  public mutating func insert(_ newElement: Element, at i: Int) {
    _checkIndex(i)
    self.replaceSubrange(i..<i, with: CollectionOfOne(newElement))
  }

  /// Removes all elements from the array.
  ///
  /// - Parameter keepCapacity: Pass `true` to keep the existing capacity of
  ///   the array after removing its elements. The default value is
  ///   `false`.
  ///
  /// - Complexity: O(*n*), where *n* is the length of the array.
  @inlinable
  public mutating func removeAll(keepingCapacity keepCapacity: Bool = false) {
    if !keepCapacity {
      _buffer = _Buffer()
    }
    else {
      self.replaceSubrange(indices, with: EmptyCollection())
    }
  }

  //===--- algorithms -----------------------------------------------------===//

  @inlinable
  public mutating func _withUnsafeMutableBufferPointerIfSupported<R>(
    _ body: (inout UnsafeMutableBufferPointer<Element>) throws -> R
  ) rethrows -> R? {
    return try withUnsafeMutableBufferPointer {
      (bufferPointer) -> R in
      return try body(&bufferPointer)
    }
  }

  @inlinable
  public func _copyToContiguousArray() -> ContiguousArray<Element> {
    if let n = _buffer.requestNativeBuffer() {
      return ContiguousArray(_buffer: n)
    }
    return _copyCollectionToContiguousArray(_buffer)
  }
}

extension ContiguousArray : CustomReflectable {
  /// A mirror that reflects the array.
  public var customMirror: Mirror {
    return Mirror(
      self,
      unlabeledChildren: self,
      displayStyle: .collection)
  }
}

extension ContiguousArray : CustomStringConvertible, CustomDebugStringConvertible {
  /// A textual representation of the array and its elements.
  public var description: String {
    return _makeCollectionDescription(for: self, withTypeName: nil)
  }

  /// A textual representation of the array and its elements, suitable for
  /// debugging.
  public var debugDescription: String {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 1656)
    return _makeCollectionDescription(for: self, withTypeName: "ContiguousArray")
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 1661)
  }
}

extension ContiguousArray {
  @inlinable
  @_transparent
  internal func _cPointerArgs() -> (AnyObject?, UnsafeRawPointer?) {
    let p = _baseAddressIfContiguous
    if _fastPath(p != nil || isEmpty) {
      return (_owner, UnsafeRawPointer(p))
    }
    let n = ContiguousArray(self._buffer)._buffer
    return (n.owner, UnsafeRawPointer(n.firstElementAddress))
  }
}

extension ContiguousArray {
  /// Calls a closure with a pointer to the array's contiguous storage.
  ///
  /// Often, the optimizer can eliminate bounds checks within an array
  /// algorithm, but when that fails, invoking the same algorithm on the
  /// buffer pointer passed into your closure lets you trade safety for speed.
  ///
  /// The following example shows how you can iterate over the contents of the
  /// buffer pointer:
  ///
  ///     let numbers = [1, 2, 3, 4, 5]
  ///     let sum = numbers.withUnsafeBufferPointer { buffer -> Int in
  ///         var result = 0
  ///         for i in stride(from: buffer.startIndex, to: buffer.endIndex, by: 2) {
  ///             result += buffer[i]
  ///         }
  ///         return result
  ///     }
  ///     // 'sum' == 9
  ///
  /// The pointer passed as an argument to `body` is valid only during the
  /// execution of `withUnsafeBufferPointer(_:)`. Do not store or return the
  /// pointer for later use.
  ///
  /// - Parameter body: A closure with an `UnsafeBufferPointer` parameter that
  ///   points to the contiguous storage for the array.  If
  ///   `body` has a return value, that value is also used as the return value
  ///   for the `withUnsafeBufferPointer(_:)` method. The pointer argument is
  ///   valid only for the duration of the method's execution.
  /// - Returns: The return value, if any, of the `body` closure parameter.
  @inlinable
  public func withUnsafeBufferPointer<R>(
    _ body: (UnsafeBufferPointer<Element>) throws -> R
  ) rethrows -> R {
    return try _buffer.withUnsafeBufferPointer(body)
  }

  /// Calls the given closure with a pointer to the array's mutable contiguous
  /// storage.
  ///
  /// Often, the optimizer can eliminate bounds checks within an array
  /// algorithm, but when that fails, invoking the same algorithm on the
  /// buffer pointer passed into your closure lets you trade safety for speed.
  ///
  /// The following example shows how modifying the contents of the
  /// `UnsafeMutableBufferPointer` argument to `body` alters the contents of
  /// the array:
  ///
  ///     var numbers = [1, 2, 3, 4, 5]
  ///     numbers.withUnsafeMutableBufferPointer { buffer in
  ///         for i in stride(from: buffer.startIndex, to: buffer.endIndex - 1, by: 2) {
  ///             buffer.swapAt(i, i + 1)
  ///         }
  ///     }
  ///     print(numbers)
  ///     // Prints "[2, 1, 4, 3, 5]"
  ///
  /// The pointer passed as an argument to `body` is valid only during the
  /// execution of `withUnsafeMutableBufferPointer(_:)`. Do not store or
  /// return the pointer for later use.
  ///
  /// - Warning: Do not rely on anything about the array that is the target of
  ///   this method during execution of the `body` closure; it might not
  ///   appear to have its correct value. Instead, use only the
  ///   `UnsafeMutableBufferPointer` argument to `body`.
  ///
  /// - Parameter body: A closure with an `UnsafeMutableBufferPointer`
  ///   parameter that points to the contiguous storage for the array.
  ///    If `body` has a return value, that value is also
  ///   used as the return value for the `withUnsafeMutableBufferPointer(_:)`
  ///   method. The pointer argument is valid only for the duration of the
  ///   method's execution.
  /// - Returns: The return value, if any, of the `body` closure parameter.
  @_semantics("array.withUnsafeMutableBufferPointer")
  @inline(__always) // Performance: This method should get inlined into the
  // caller such that we can combine the partial apply with the apply in this
  // function saving on allocating a closure context. This becomes unnecessary
  // once we allocate noescape closures on the stack.
  public mutating func withUnsafeMutableBufferPointer<R>(
    _ body: (inout UnsafeMutableBufferPointer<Element>) throws -> R
  ) rethrows -> R {
    let count = self.count
    // Ensure unique storage
    _buffer._outlinedMakeUniqueBuffer(bufferCount: count)

    // Ensure that body can't invalidate the storage or its bounds by
    // moving self into a temporary working array.
    // NOTE: The stack promotion optimization that keys of the
    // "array.withUnsafeMutableBufferPointer" semantics annotation relies on the
    // array buffer not being able to escape in the closure. It can do this
    // because we swap the array buffer in self with an empty buffer here. Any
    // escape via the address of self in the closure will therefore escape the
    // empty array.

    var work = ContiguousArray()
    (work, self) = (self, work)

    // Create an UnsafeBufferPointer over work that we can pass to body
    let pointer = work._buffer.firstElementAddress
    var inoutBufferPointer = UnsafeMutableBufferPointer(
      start: pointer, count: count)

    // Put the working array back before returning.
    defer {
      _precondition(
        inoutBufferPointer.baseAddress == pointer &&
        inoutBufferPointer.count == count,
        "ContiguousArray withUnsafeMutableBufferPointer: replacing the buffer is not allowed")

      (work, self) = (self, work)
    }

    // Invoke the body.
    return try body(&inoutBufferPointer)
  }

  @inlinable
  public func _copyContents(
    initializing buffer: UnsafeMutableBufferPointer<Element>
  ) -> (Iterator,UnsafeMutableBufferPointer<Element>.Index) {

    guard !self.isEmpty else { return (makeIterator(),buffer.startIndex) }

    // It is not OK for there to be no pointer/not enough space, as this is
    // a precondition and Array never lies about its count.
    guard var p = buffer.baseAddress
      else { _preconditionFailure("Attempt to copy contents into nil buffer pointer") }
    _precondition(self.count <= buffer.count, 
      "Insufficient space allocated to copy array contents")

    if let s = _baseAddressIfContiguous {
      p.initialize(from: s, count: self.count)
      // Need a _fixLifetime bracketing the _baseAddressIfContiguous getter
      // and all uses of the pointer it returns:
      _fixLifetime(self._owner)
    } else {
      for x in self {
        p.initialize(to: x)
        p += 1
      }
    }

    var it = IndexingIterator(_elements: self)
    it._position = endIndex
    return (it,buffer.index(buffer.startIndex, offsetBy: self.count))
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 45)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 455)

/// A slice of an `Array`, `ContiguousArray`, or `ArraySlice` instance.
///
/// The `ArraySlice` type makes it fast and efficient for you to perform
/// operations on sections of a larger array. Instead of copying over the
/// elements of a slice to new storage, an `ArraySlice` instance presents a
/// view onto the storage of a larger array. And because `ArraySlice`
/// presents the same interface as `Array`, you can generally perform the
/// same operations on a slice as you could on the original array.
///
/// For more information about using arrays, see `Array` and `ContiguousArray`,
/// with which `ArraySlice` shares most properties and methods.
///
/// Slices Are Views onto Arrays
/// ============================
///
/// For example, suppose you have an array holding the number of absences
/// from each class during a session.
///
///     let absences = [0, 2, 0, 4, 0, 3, 1, 0]
///
/// You want to compare the absences in the first half of the session with
/// those in the second half. To do so, start by creating two slices of the
/// `absences` array.
///
///     let midpoint = absences.count / 2
///
///     let firstHalf = absences[..<midpoint]
///     let secondHalf = absences[midpoint...]
///
/// Neither the `firstHalf` nor `secondHalf` slices allocate any new storage
/// of their own. Instead, each presents a view onto the storage of the
/// `absences` array.
///
/// You can call any method on the slices that you might have called on the
/// `absences` array. To learn which half had more absences, use the
/// `reduce(_:_:)` method to calculate each sum.
///
///     let firstHalfSum = firstHalf.reduce(0, +)
///     let secondHalfSum = secondHalf.reduce(0, +)
///
///     if firstHalfSum > secondHalfSum {
///         print("More absences in the first half.")
///     } else {
///         print("More absences in the second half.")
///     }
///     // Prints "More absences in the first half."
///
/// - Important: Long-term storage of `ArraySlice` instances is discouraged. A
///   slice holds a reference to the entire storage of a larger array, not
///   just to the portion it presents, even after the original array's lifetime
///   ends. Long-term storage of a slice may therefore prolong the lifetime of
///   elements that are no longer otherwise accessible, which can appear to be
///   memory and object leakage.
///
/// Slices Maintain Indices
/// =======================
///
/// Unlike `Array` and `ContiguousArray`, the starting index for an
/// `ArraySlice` instance isn't always zero. Slices maintain the same
/// indices of the larger array for the same elements, so the starting
/// index of a slice depends on how it was created, letting you perform
/// index-based operations on either a full array or a slice.
///
/// Sharing indices between collections and their subsequences is an important
/// part of the design of Swift's collection algorithms. Suppose you are
/// tasked with finding the first two days with absences in the session. To
/// find the indices of the two days in question, follow these steps:
///
/// 1) Call `firstIndex(where:)` to find the index of the first element in the
///    `absences` array that is greater than zero.
/// 2) Create a slice of the `absences` array starting after the index found in
///    step 1.
/// 3) Call `firstIndex(where:)` again, this time on the slice created in step
///    2. Where in some languages you might pass a starting index into an
///    `indexOf` method to find the second day, in Swift you perform the same
///    operation on a slice of the original array.
/// 4) Print the results using the indices found in steps 1 and 3 on the
///    original `absences` array.
///
/// Here's an implementation of those steps:
///
///     if let i = absences.firstIndex(where: { $0 > 0 }) {                 // 1
///         let absencesAfterFirst = absences[(i + 1)...]                   // 2
///         if let j = absencesAfterFirst.firstIndex(where: { $0 > 0 }) {   // 3
///             print("The first day with absences had \(absences[i]).")    // 4
///             print("The second day with absences had \(absences[j]).")
///         }
///     }
///     // Prints "The first day with absences had 2."
///     // Prints "The second day with absences had 4."
///
/// In particular, note that `j`, the index of the second day with absences,
/// was found in a slice of the original array and then used to access a value
/// in the original `absences` array itself.
///
/// - Note: To safely reference the starting and ending indices of a slice,
///   always use the `startIndex` and `endIndex` properties instead of
///   specific values.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 456)

@_fixed_layout
public struct ArraySlice<Element>: _DestructorSafeContainer {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 466)
    internal typealias _Buffer = _SliceBuffer<Element>
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 470)

  @usableFromInline
  internal var _buffer: _Buffer

  /// Initialization from an existing buffer does not have "array.init"
  /// semantics because the caller may retain an alias to buffer.
  @inlinable
  internal init(_buffer: _Buffer) {
    self._buffer = _buffer
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 482)
  /// Initialization from an existing buffer does not have "array.init"
  /// semantics because the caller may retain an alias to buffer.
  @inlinable
  internal init(_buffer buffer: _ContiguousArrayBuffer<Element>) {
    self.init(_buffer: _Buffer(_buffer: buffer, shiftedToStartIndex: 0))
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 489)
}

extension ArraySlice: RandomAccessCollection, MutableCollection {
  /// The index type for arrays, `Int`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 494)
  ///
  /// `ArraySlice` instances are not always indexed from zero. Use `startIndex`
  /// and `endIndex` as the bounds for any element access, instead of `0` and
  /// `count`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 499)
  public typealias Index = Int

  /// The type that represents the indices that are valid for subscripting an
  /// array, in ascending order.
  public typealias Indices = Range<Int>

  /// The type that allows iteration over an array's elements.
  public typealias Iterator = IndexingIterator<ArraySlice>

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 509)
  /// The position of the first element in a nonempty array.
  ///
  /// If the array is empty, `startIndex` is equal to `endIndex`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 518)
  @inlinable
  public var startIndex: Int {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 521)
    return _buffer.startIndex
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 525)
  }

  /// The array's "past the end" position---that is, the position one greater
  /// than the last valid subscript argument.
  ///
  /// When you need a range that includes the last element of an array, use the
  /// half-open range operator (`..<`) with `endIndex`. The `..<` operator
  /// creates a range that doesn't include the upper bound, so it's always
  /// safe to use with `endIndex`. For example:
  ///
  ///     let numbers = [10, 20, 30, 40, 50]
  ///     if let i = numbers.firstIndex(of: 30) {
  ///         print(numbers[i ..< numbers.endIndex])
  ///     }
  ///     // Prints "[30, 40, 50]"
  ///
  /// If the array is empty, `endIndex` is equal to `startIndex`.
  @inlinable // FIXME(sil-serialize-all)
  public var endIndex: Int {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 545)
    return _buffer.endIndex
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 552)
  }

  /// Returns the position immediately after the given index.
  ///
  /// - Parameter i: A valid index of the collection. `i` must be less than
  ///   `endIndex`.
  /// - Returns: The index immediately after `i`.
  @inlinable
  public func index(after i: Int) -> Int {
    // NOTE: this is a manual specialization of index movement for a Strideable
    // index that is required for Array performance.  The optimizer is not
    // capable of creating partial specializations yet.
    // NOTE: Range checks are not performed here, because it is done later by
    // the subscript function.
    return i + 1
  }

  /// Replaces the given index with its successor.
  ///
  /// - Parameter i: A valid index of the collection. `i` must be less than
  ///   `endIndex`.
  @inlinable
  public func formIndex(after i: inout Int) {
    // NOTE: this is a manual specialization of index movement for a Strideable
    // index that is required for Array performance.  The optimizer is not
    // capable of creating partial specializations yet.
    // NOTE: Range checks are not performed here, because it is done later by
    // the subscript function.
    i += 1
  }

  /// Returns the position immediately before the given index.
  ///
  /// - Parameter i: A valid index of the collection. `i` must be greater than
  ///   `startIndex`.
  /// - Returns: The index immediately before `i`.
  @inlinable
  public func index(before i: Int) -> Int {
    // NOTE: this is a manual specialization of index movement for a Strideable
    // index that is required for Array performance.  The optimizer is not
    // capable of creating partial specializations yet.
    // NOTE: Range checks are not performed here, because it is done later by
    // the subscript function.
    return i - 1
  }

  /// Replaces the given index with its predecessor.
  ///
  /// - Parameter i: A valid index of the collection. `i` must be greater than
  ///   `startIndex`.
  @inlinable
  public func formIndex(before i: inout Int) {
    // NOTE: this is a manual specialization of index movement for a Strideable
    // index that is required for Array performance.  The optimizer is not
    // capable of creating partial specializations yet.
    // NOTE: Range checks are not performed here, because it is done later by
    // the subscript function.
    i -= 1
  }

  /// Returns an index that is the specified distance from the given index.
  ///
  /// The following example obtains an index advanced four positions from an
  /// array's starting index and then prints the element at that position.
  ///
  ///     let numbers = [10, 20, 30, 40, 50]
  ///     let i = numbers.index(numbers.startIndex, offsetBy: 4)
  ///     print(numbers[i])
  ///     // Prints "50"
  ///
  /// The value passed as `n` must not offset `i` beyond the bounds of the
  /// collection.
  ///
  /// - Parameters:
  ///   - i: A valid index of the array.
  ///   - n: The distance to offset `i`.
  /// - Returns: An index offset by `n` from the index `i`. If `n` is positive,
  ///   this is the same value as the result of `n` calls to `index(after:)`.
  ///   If `n` is negative, this is the same value as the result of `-n` calls
  ///   to `index(before:)`.
  @inlinable
  public func index(_ i: Int, offsetBy n: Int) -> Int {
    // NOTE: this is a manual specialization of index movement for a Strideable
    // index that is required for Array performance.  The optimizer is not
    // capable of creating partial specializations yet.
    // NOTE: Range checks are not performed here, because it is done later by
    // the subscript function.
    return i + n
  }

  /// Returns an index that is the specified distance from the given index,
  /// unless that distance is beyond a given limiting index.
  ///
  /// The following example obtains an index advanced four positions from an
  /// array's starting index and then prints the element at that position. The
  /// operation doesn't require going beyond the limiting `numbers.endIndex`
  /// value, so it succeeds.
  ///
  ///     let numbers = [10, 20, 30, 40, 50]
  ///     if let i = numbers.index(numbers.startIndex,
  ///                              offsetBy: 4,
  ///                              limitedBy: numbers.endIndex) {
  ///         print(numbers[i])
  ///     }
  ///     // Prints "50"
  ///
  /// The next example attempts to retrieve an index ten positions from
  /// `numbers.startIndex`, but fails, because that distance is beyond the
  /// index passed as `limit`.
  ///
  ///     let j = numbers.index(numbers.startIndex,
  ///                           offsetBy: 10,
  ///                           limitedBy: numbers.endIndex)
  ///     print(j)
  ///     // Prints "nil"
  ///
  /// The value passed as `n` must not offset `i` beyond the bounds of the
  /// collection, unless the index passed as `limit` prevents offsetting
  /// beyond those bounds.
  ///
  /// - Parameters:
  ///   - i: A valid index of the array.
  ///   - n: The distance to offset `i`.
  ///   - limit: A valid index of the collection to use as a limit. If `n > 0`,
  ///     `limit` has no effect if it is less than `i`. Likewise, if `n < 0`,
  ///     `limit` has no effect if it is greater than `i`.
  /// - Returns: An index offset by `n` from the index `i`, unless that index
  ///   would be beyond `limit` in the direction of movement. In that case,
  ///   the method returns `nil`.
  @inlinable
  public func index(
    _ i: Int, offsetBy n: Int, limitedBy limit: Int
  ) -> Int? {
    // NOTE: this is a manual specialization of index movement for a Strideable
    // index that is required for Array performance.  The optimizer is not
    // capable of creating partial specializations yet.
    // NOTE: Range checks are not performed here, because it is done later by
    // the subscript function.
    let l = limit - i
    if n > 0 ? l >= 0 && l < n : l <= 0 && n < l {
      return nil
    }
    return i + n
  }

  /// Returns the distance between two indices.
  ///
  /// - Parameters:
  ///   - start: A valid index of the collection.
  ///   - end: Another valid index of the collection. If `end` is equal to
  ///     `start`, the result is zero.
  /// - Returns: The distance between `start` and `end`.
  @inlinable
  public func distance(from start: Int, to end: Int) -> Int {
    // NOTE: this is a manual specialization of index movement for a Strideable
    // index that is required for Array performance.  The optimizer is not
    // capable of creating partial specializations yet.
    // NOTE: Range checks are not performed here, because it is done later by
    // the subscript function.
    return end - start
  }

  @inlinable
  public func _failEarlyRangeCheck(_ index: Int, bounds: Range<Int>) {
    // NOTE: This method is a no-op for performance reasons.
  }

  @inlinable
  public func _failEarlyRangeCheck(_ range: Range<Int>, bounds: Range<Int>) {
    // NOTE: This method is a no-op for performance reasons.
  }

  /// Accesses the element at the specified position.
  ///
  /// The following example uses indexed subscripting to update an array's
  /// second element. After assigning the new value (`"Butler"`) at a specific
  /// position, that value is immediately available at that same position.
  ///
  ///     var streets = ["Adams", "Bryant", "Channing", "Douglas", "Evarts"]
  ///     streets[1] = "Butler"
  ///     print(streets[1])
  ///     // Prints "Butler"
  ///
  /// - Parameter index: The position of the element to access. `index` must be
  ///   greater than or equal to `startIndex` and less than `endIndex`.
  ///
  /// - Complexity: Reading an element from an array is O(1). Writing is O(1)
  ///   unless the array's storage is shared with another array, in which case
  ///   writing is O(*n*), where *n* is the length of the array.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 745)
  @inlinable
  public subscript(index: Int) -> Element {
    get {
      // This call may be hoisted or eliminated by the optimizer.  If
      // there is an inout violation, this value may be stale so needs to be
      // checked again below.
      let wasNativeTypeChecked = _hoistableIsNativeTypeChecked()

      // Make sure the index is in range and wasNativeTypeChecked is
      // still valid.
      let token = _checkSubscript(
        index, wasNativeTypeChecked: wasNativeTypeChecked)

      return _getElement(
        index, wasNativeTypeChecked: wasNativeTypeChecked,
        matchingSubscriptCheck: token)
    }
    mutableAddressWithPinnedNativeOwner {
      _makeMutableAndUniqueOrPinned() // makes the array native, too
      _checkSubscript_native(index)
      return (_getElementAddress(index), Builtin.tryPin(_getOwner_native()))
    }
  }

  /// Accesses a contiguous subrange of the array's elements.
  ///
  /// The returned `ArraySlice` instance uses the same indices for the same
  /// elements as the original array. In particular, that slice, unlike an
  /// array, may have a nonzero `startIndex` and an `endIndex` that is not
  /// equal to `count`. Always use the slice's `startIndex` and `endIndex`
  /// properties instead of assuming that its indices start or end at a
  /// particular value.
  ///
  /// This example demonstrates getting a slice of an array of strings, finding
  /// the index of one of the strings in the slice, and then using that index
  /// in the original array.
  ///
  ///     let streets = ["Adams", "Bryant", "Channing", "Douglas", "Evarts"]
  ///     let streetsSlice = streets[2 ..< streets.endIndex]
  ///     print(streetsSlice)
  ///     // Prints "["Channing", "Douglas", "Evarts"]"
  ///
  ///     let i = streetsSlice.firstIndex(of: "Evarts")    // 4
  ///     print(streets[i!])
  ///     // Prints "Evarts"
  ///
  /// - Parameter bounds: A range of integers. The bounds of the range must be
  ///   valid indices of the array.
  @inlinable
  public subscript(bounds: Range<Int>) -> ArraySlice<Element> {
    get {
      _checkIndex(bounds.lowerBound)
      _checkIndex(bounds.upperBound)
      return ArraySlice(_buffer: _buffer[bounds])
    }
    set(rhs) {
      _checkIndex(bounds.lowerBound)
      _checkIndex(bounds.upperBound)
      // If the replacement buffer has same identity, and the ranges match,
      // then this was a pinned in-place modification, nothing further needed.
      if self[bounds]._buffer.identity != rhs._buffer.identity
      || bounds != rhs.startIndex..<rhs.endIndex {
        self.replaceSubrange(bounds, with: rhs)
      }
    }
  }
}

//===--- private helpers---------------------------------------------------===//
extension ArraySlice {
  /// Returns `true` if the array is native and does not need a deferred
  /// type check.  May be hoisted by the optimizer, which means its
  /// results may be stale by the time they are used if there is an
  /// inout violation in user code.
  @inlinable
  @_semantics("array.props.isNativeTypeChecked")
  public // @testable
  func _hoistableIsNativeTypeChecked() -> Bool {
   return _buffer.arrayPropertyIsNativeTypeChecked
  }

  @inlinable
  @_semantics("array.get_count")
  internal func _getCount() -> Int {
    return _buffer.count
  }

  @inlinable
  @_semantics("array.get_capacity")
  internal func _getCapacity() -> Int {
    return _buffer.capacity
  }

  /// - Precondition: The array has a native buffer.
  @inlinable
  @_semantics("array.owner")
  internal func _getOwnerWithSemanticLabel_native() -> Builtin.NativeObject {
    return Builtin.unsafeCastToNativeObject(_buffer.nativeOwner)
  }

  /// - Precondition: The array has a native buffer.
  @inlinable
  @inline(__always)
  internal func _getOwner_native() -> Builtin.NativeObject {
#if _runtime(_ObjC)
    if _isClassOrObjCExistential(Element.self) {
      // We are hiding the access to '_buffer.owner' behind
      // _getOwner() to help the compiler hoist uniqueness checks in
      // the case of class or Objective-C existential typed array
      // elements.
      return _getOwnerWithSemanticLabel_native()
    }
#endif
    // In the value typed case the extra call to
    // _getOwnerWithSemanticLabel_native hinders optimization.
    return Builtin.unsafeCastToNativeObject(_buffer.owner)
  }

  @inlinable
  @_semantics("array.make_mutable")
  internal mutating func _makeMutableAndUnique() {
    if _slowPath(!_buffer.isMutableAndUniquelyReferenced()) {
      _buffer = _Buffer(copying: _buffer)
    }
  }

  @inlinable
  @_semantics("array.make_mutable")
  internal mutating func _makeMutableAndUniqueOrPinned() {
    if _slowPath(!_buffer.isMutableAndUniquelyReferencedOrPinned()) {
      _buffer = _Buffer(copying: _buffer)
    }
  }


  /// Check that the given `index` is valid for subscripting, i.e.
  /// `0 ≤ index < count`.
  @inlinable
  @inline(__always)
  internal func _checkSubscript_native(_ index: Int) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 886)
    _buffer._checkValidSubscript(index)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 890)
  }

  /// Check that the given `index` is valid for subscripting, i.e.
  /// `0 ≤ index < count`.
  @inlinable
  @_semantics("array.check_subscript")
  public // @testable
  func _checkSubscript(
    _ index: Int, wasNativeTypeChecked: Bool
  ) -> _DependenceToken {
#if _runtime(_ObjC)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 905)
    _buffer._checkValidSubscript(index)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 907)
#else
    _buffer._checkValidSubscript(index)
#endif
    return _DependenceToken()
  }

  /// Check that the specified `index` is valid, i.e. `0 ≤ index ≤ count`.
  @inlinable
  @_semantics("array.check_index")
  internal func _checkIndex(_ index: Int) {
    _precondition(index <= endIndex, "ArraySlice index is out of range")
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 921)
    _precondition(index >= startIndex, "ArraySlice index is out of range (before startIndex)")
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 923)
  }

  @_semantics("array.get_element")
  @inline(__always)
  public // @testable
  func _getElement(
    _ index: Int,
    wasNativeTypeChecked : Bool,
    matchingSubscriptCheck: _DependenceToken
  ) -> Element {
#if false
    return _buffer.getElement(index, wasNativeTypeChecked: wasNativeTypeChecked)
#else
    return _buffer.getElement(index)
#endif
  }

  @inlinable
  @_semantics("array.get_element_address")
  internal func _getElementAddress(_ index: Int) -> UnsafeMutablePointer<Element> {
    return _buffer.subscriptBaseAddress + index
  }
}

extension ArraySlice : ExpressibleByArrayLiteral {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 968)
  /// Creates an array from the given array literal.
  ///
  /// Do not call this initializer directly. It is used by the compiler when
  /// you use an array literal. Instead, create a new array by using an array
  /// literal as its value. To do this, enclose a comma-separated list of
  /// values in square brackets.
  ///
  /// Here, an array of strings is created from an array literal holding only
  /// strings:
  ///
  ///     let ingredients: ArraySlice =
  ///           ["cocoa beans", "sugar", "cocoa butter", "salt"]
  ///
  /// - Parameter elements: A variadic list of elements of the new array.
  @inlinable
  public init(arrayLiteral elements: Element...) {
    self.init(_buffer: ContiguousArray(elements)._buffer)
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 987)
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 1029)

extension ArraySlice : RangeReplaceableCollection, ArrayProtocol {
  /// Creates a new, empty array.
  ///
  /// This is equivalent to initializing with an empty array literal.
  /// For example:
  ///
  ///     var emptyArray = Array<Int>()
  ///     print(emptyArray.isEmpty)
  ///     // Prints "true"
  ///
  ///     emptyArray = []
  ///     print(emptyArray.isEmpty)
  ///     // Prints "true"
  @inlinable
  @_semantics("array.init")
  public init() {
    _buffer = _Buffer()
  }

  /// Creates an array containing the elements of a sequence.
  ///
  /// You can use this initializer to create an array from any other type that
  /// conforms to the `Sequence` protocol. For example, you might want to
  /// create an array with the integers from 1 through 7. Use this initializer
  /// around a range instead of typing all those numbers in an array literal.
  ///
  ///     let numbers = Array(1...7)
  ///     print(numbers)
  ///     // Prints "[1, 2, 3, 4, 5, 6, 7]"
  ///
  /// You can also use this initializer to convert a complex sequence or
  /// collection type back to an array. For example, the `keys` property of
  /// a dictionary isn't an array with its own storage, it's a collection
  /// that maps its elements from the dictionary only when they're
  /// accessed, saving the time and space needed to allocate an array. If
  /// you need to pass those keys to a method that takes an array, however,
  /// use this initializer to convert that list from its type of
  /// `LazyMapCollection<Dictionary<String, Int>, Int>` to a simple
  /// `[String]`.
  ///
  ///     func cacheImagesWithNames(names: [String]) {
  ///         // custom image loading and caching
  ///      }
  ///
  ///     let namedHues: [String: Int] = ["Vermillion": 18, "Magenta": 302,
  ///             "Gold": 50, "Cerise": 320]
  ///     let colorNames = Array(namedHues.keys)
  ///     cacheImagesWithNames(colorNames)
  ///
  ///     print(colorNames)
  ///     // Prints "["Gold", "Cerise", "Magenta", "Vermillion"]"
  ///
  /// - Parameter s: The sequence of elements to turn into an array.
  @inlinable
  public init<S : Sequence>(_ s: S)
    where S.Element == Element {

    self = ArraySlice(
      _buffer: _Buffer(
        _buffer: s._copyToContiguousArray()._buffer,
        shiftedToStartIndex: 0))
  }

  /// Creates a new array containing the specified number of a single, repeated
  /// value.
  ///
  /// Here's an example of creating an array initialized with five strings
  /// containing the letter *Z*.
  ///
  ///     let fiveZs = Array(repeating: "Z", count: 5)
  ///     print(fiveZs)
  ///     // Prints "["Z", "Z", "Z", "Z", "Z"]"
  ///
  /// - Parameters:
  ///   - repeatedValue: The element to repeat.
  ///   - count: The number of times to repeat the value passed in the
  ///     `repeating` parameter. `count` must be zero or greater.
  @inlinable
  @_semantics("array.init")
  public init(repeating repeatedValue: Element, count: Int) {
    var p: UnsafeMutablePointer<Element>
    (self, p) = ArraySlice._allocateUninitialized(count)
    for _ in 0..<count {
      p.initialize(to: repeatedValue)
      p += 1
    }
  }

  @inlinable
  @inline(never)
  internal static func _allocateBufferUninitialized(
    minimumCapacity: Int
  ) -> _Buffer {
    let newBuffer = _ContiguousArrayBuffer<Element>(
      _uninitializedCount: 0, minimumCapacity: minimumCapacity)
    return _Buffer(_buffer: newBuffer, shiftedToStartIndex: 0)
  }

  /// Construct a ArraySlice of `count` uninitialized elements.
  @inlinable
  internal init(_uninitializedCount count: Int) {
    _precondition(count >= 0, "Can't construct ArraySlice with count < 0")
    // Note: Sinking this constructor into an else branch below causes an extra
    // Retain/Release.
    _buffer = _Buffer()
    if count > 0 {
      // Creating a buffer instead of calling reserveCapacity saves doing an
      // unnecessary uniqueness check. We disable inlining here to curb code
      // growth.
      _buffer = ArraySlice._allocateBufferUninitialized(minimumCapacity: count)
      _buffer.count = count
    }
    // Can't store count here because the buffer might be pointing to the
    // shared empty array.
  }

  /// Entry point for `Array` literal construction; builds and returns
  /// a ArraySlice of `count` uninitialized elements.
  @inlinable
  @_semantics("array.uninitialized")
  internal static func _allocateUninitialized(
    _ count: Int
  ) -> (ArraySlice, UnsafeMutablePointer<Element>) {
    let result = ArraySlice(_uninitializedCount: count)
    return (result, result._buffer.firstElementAddress)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 1189)

  /// The number of elements in the array.
  @inlinable
  public var count: Int {
    return _getCount()
  }

  /// The total number of elements that the array can contain without
  /// allocating new storage.
  ///
  /// Every array reserves a specific amount of memory to hold its contents.
  /// When you add elements to an array and that array begins to exceed its
  /// reserved capacity, the array allocates a larger region of memory and
  /// copies its elements into the new storage. The new storage is a multiple
  /// of the old storage's size. This exponential growth strategy means that
  /// appending an element happens in constant time, averaging the performance
  /// of many append operations. Append operations that trigger reallocation
  /// have a performance cost, but they occur less and less often as the array
  /// grows larger.
  ///
  /// The following example creates an array of integers from an array literal,
  /// then appends the elements of another collection. Before appending, the
  /// array allocates new storage that is large enough store the resulting
  /// elements.
  ///
  ///     var numbers = [10, 20, 30, 40, 50]
  ///     // numbers.count == 5
  ///     // numbers.capacity == 5
  ///
  ///     numbers.append(contentsOf: stride(from: 60, through: 100, by: 10))
  ///     // numbers.count == 10
  ///     // numbers.capacity == 12
  @inlinable
  public var capacity: Int {
    return _getCapacity()
  }

  /// An object that guarantees the lifetime of this array's elements.
  @inlinable
  public // @testable
  var _owner: AnyObject? {
    return _buffer.owner
  }

  /// If the elements are stored contiguously, a pointer to the first
  /// element. Otherwise, `nil`.
  @inlinable
  public var _baseAddressIfContiguous: UnsafeMutablePointer<Element>? {
    @inline(__always) // FIXME(TODO: JIRA): Hack around test failure
    get { return _buffer.firstElementAddressIfContiguous }
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 1242)
  @inlinable
  internal var _baseAddress: UnsafeMutablePointer<Element> {
    return _buffer.firstElementAddress
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 1247)
  //===--- basic mutations ------------------------------------------------===//


  /// Reserves enough space to store the specified number of elements.
  ///
  /// If you are adding a known number of elements to an array, use this method
  /// to avoid multiple reallocations. This method ensures that the array has
  /// unique, mutable, contiguous storage, with space allocated for at least
  /// the requested number of elements.
  ///
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 1258)
  /// Calling the `reserveCapacity(_:)` method on an array with bridged storage
  /// triggers a copy to contiguous storage even if the existing storage
  /// has room to store `minimumCapacity` elements.
  ///
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 1263)
  /// For performance reasons, the size of the newly allocated storage might be
  /// greater than the requested capacity. Use the array's `capacity` property
  /// to determine the size of the new storage.
  ///
  /// Preserving an Array's Geometric Growth Strategy
  /// ===============================================
  ///
  /// If you implement a custom data structure backed by an array that grows
  /// dynamically, naively calling the `reserveCapacity(_:)` method can lead
  /// to worse than expected performance. Arrays need to follow a geometric
  /// allocation pattern for appending elements to achieve amortized
  /// constant-time performance. The `Array` type's `append(_:)` and
  /// `append(contentsOf:)` methods take care of this detail for you, but
  /// `reserveCapacity(_:)` allocates only as much space as you tell it to
  /// (padded to a round value), and no more. This avoids over-allocation, but
  /// can result in insertion not having amortized constant-time performance.
  ///
  /// The following code declares `values`, an array of integers, and the
  /// `addTenQuadratic()` function, which adds ten more values to the `values`
  /// array on each call.
  ///
  ///       var values: [Int] = [0, 1, 2, 3]
  ///
  ///       // Don't use 'reserveCapacity(_:)' like this
  ///       func addTenQuadratic() {
  ///           let newCount = values.count + 10
  ///           values.reserveCapacity(newCount)
  ///           for n in values.count..<newCount {
  ///               values.append(n)
  ///           }
  ///       }
  ///
  /// The call to `reserveCapacity(_:)` increases the `values` array's capacity
  /// by exactly 10 elements on each pass through `addTenQuadratic()`, which
  /// is linear growth. Instead of having constant time when averaged over
  /// many calls, the function may decay to performance that is linear in
  /// `values.count`. This is almost certainly not what you want.
  ///
  /// In cases like this, the simplest fix is often to simply remove the call
  /// to `reserveCapacity(_:)`, and let the `append(_:)` method grow the array
  /// for you.
  ///
  ///       func addTen() {
  ///           let newCount = values.count + 10
  ///           for n in values.count..<newCount {
  ///               values.append(n)
  ///           }
  ///       }
  ///
  /// If you need more control over the capacity of your array, implement your
  /// own geometric growth strategy, passing the size you compute to
  /// `reserveCapacity(_:)`.
  ///
  /// - Parameter minimumCapacity: The requested number of elements to store.
  ///
  /// - Complexity: O(*n*), where *n* is the number of elements in the array.
  @inlinable
  @_semantics("array.mutate_unknown")
  public mutating func reserveCapacity(_ minimumCapacity: Int) {
    if _buffer.requestUniqueMutableBackingBuffer(
      minimumCapacity: minimumCapacity) == nil {

      let newBuffer = _ContiguousArrayBuffer<Element>(
        _uninitializedCount: count, minimumCapacity: minimumCapacity)

      _buffer._copyContents(
        subRange: _buffer.indices,
        initializing: newBuffer.firstElementAddress)
      _buffer = _Buffer(
        _buffer: newBuffer, shiftedToStartIndex: _buffer.startIndex)
    }
    _sanityCheck(capacity >= minimumCapacity)
  }

  /// Copy the contents of the current buffer to a new unique mutable buffer.
  /// The count of the new buffer is set to `oldCount`, the capacity of the
  /// new buffer is big enough to hold 'oldCount' + 1 elements.
  @inlinable
  @inline(never)
  internal mutating func _copyToNewBuffer(oldCount: Int) {
    let newCount = oldCount + 1
    var newBuffer = _buffer._forceCreateUniqueMutableBuffer(
      countForNewBuffer: oldCount, minNewCapacity: newCount)
    _buffer._arrayOutOfPlaceUpdate(
      &newBuffer, oldCount, 0, _IgnorePointer())
  }

  @inlinable
  @_semantics("array.make_mutable")
  internal mutating func _makeUniqueAndReserveCapacityIfNotUnique() {
    if _slowPath(!_buffer.isMutableAndUniquelyReferenced()) {
      _copyToNewBuffer(oldCount: _buffer.count)
    }
  }

  @inlinable
  @_semantics("array.mutate_unknown")
  internal mutating func _reserveCapacityAssumingUniqueBuffer(oldCount: Int) {
    // This is a performance optimization. This code used to be in an ||
    // statement in the _sanityCheck below.
    //
    //   _sanityCheck(_buffer.capacity == 0 ||
    //                _buffer.isMutableAndUniquelyReferenced())
    //
    // SR-6437
    let capacity = _buffer.capacity == 0

    // Due to make_mutable hoisting the situation can arise where we hoist
    // _makeMutableAndUnique out of loop and use it to replace
    // _makeUniqueAndReserveCapacityIfNotUnique that preceeds this call. If the
    // array was empty _makeMutableAndUnique does not replace the empty array
    // buffer by a unique buffer (it just replaces it by the empty array
    // singleton).
    // This specific case is okay because we will make the buffer unique in this
    // function because we request a capacity > 0 and therefore _copyToNewBuffer
    // will be called creating a new buffer.
    _sanityCheck(capacity ||
                 _buffer.isMutableAndUniquelyReferenced())

    if _slowPath(oldCount + 1 > _buffer.capacity) {
      _copyToNewBuffer(oldCount: oldCount)
    }
  }

  @inlinable
  @_semantics("array.mutate_unknown")
  internal mutating func _appendElementAssumeUniqueAndCapacity(
    _ oldCount: Int,
    newElement: Element
  ) {
    _sanityCheck(_buffer.isMutableAndUniquelyReferenced())
    _sanityCheck(_buffer.capacity >= _buffer.count + 1)

    _buffer.count = oldCount + 1
    (_buffer.firstElementAddress + oldCount).initialize(to: newElement)
  }

  /// Adds a new element at the end of the array.
  ///
  /// Use this method to append a single element to the end of a mutable array.
  ///
  ///     var numbers = [1, 2, 3, 4, 5]
  ///     numbers.append(100)
  ///     print(numbers)
  ///     // Prints "[1, 2, 3, 4, 5, 100]"
  ///
  /// Because arrays increase their allocated capacity using an exponential
  /// strategy, appending a single element to an array is an O(1) operation
  /// when averaged over many calls to the `append(_:)` method. When an array
  /// has additional capacity and is not sharing its storage with another
  /// instance, appending an element is O(1). When an array needs to
  /// reallocate storage before appending or its storage is shared with
  /// another copy, appending is O(*n*), where *n* is the length of the array.
  ///
  /// - Parameter newElement: The element to append to the array.
  ///
  /// - Complexity: Amortized O(1) over many additions. If the array uses a
  ///   bridged `NSArray` instance as its storage, the efficiency is
  ///   unspecified.
  @inlinable
  @_semantics("array.append_element")
  public mutating func append(_ newElement: Element) {
    _makeUniqueAndReserveCapacityIfNotUnique()
    let oldCount = _getCount()
    _reserveCapacityAssumingUniqueBuffer(oldCount: oldCount)
    _appendElementAssumeUniqueAndCapacity(oldCount, newElement: newElement)
  }

  /// Adds the elements of a sequence to the end of the array.
  ///
  /// Use this method to append the elements of a sequence to the end of this
  /// array. This example appends the elements of a `Range<Int>` instance
  /// to an array of integers.
  ///
  ///     var numbers = [1, 2, 3, 4, 5]
  ///     numbers.append(contentsOf: 10...15)
  ///     print(numbers)
  ///     // Prints "[1, 2, 3, 4, 5, 10, 11, 12, 13, 14, 15]"
  ///
  /// - Parameter newElements: The elements to append to the array.
  ///
  /// - Complexity: O(*n*), where *n* is the length of the resulting array.
  @inlinable
  @_semantics("array.append_contentsOf")
  public mutating func append<S : Sequence>(contentsOf newElements: S)
    where S.Element == Element {

    let newElementsCount = newElements.underestimatedCount
    reserveCapacityForAppend(newElementsCount: newElementsCount)

    let oldCount = self.count
    let startNewElements = _buffer.firstElementAddress + oldCount
    let buf = UnsafeMutableBufferPointer(
                start: startNewElements, 
                count: self.capacity - oldCount)

    let (remainder,writtenUpTo) = buf.initialize(from: newElements)
    
    // trap on underflow from the sequence's underestimate:
    let writtenCount = buf.distance(from: buf.startIndex, to: writtenUpTo)
    _precondition(newElementsCount <= writtenCount, 
      "newElements.underestimatedCount was an overestimate")
    // can't check for overflow as sequences can underestimate

    _buffer.count += writtenCount

    if writtenUpTo == buf.endIndex {
      // there may be elements that didn't fit in the existing buffer,
      // append them in slow sequence-only mode
      _buffer._arrayAppendSequence(IteratorSequence(remainder))
    }
  }

  @inlinable
  @_semantics("array.reserve_capacity_for_append")
  internal mutating func reserveCapacityForAppend(newElementsCount: Int) {
    let oldCount = self.count
    let oldCapacity = self.capacity
    let newCount = oldCount + newElementsCount

    // Ensure uniqueness, mutability, and sufficient storage.  Note that
    // for consistency, we need unique self even if newElements is empty.
    self.reserveCapacity(
      newCount > oldCapacity ?
      Swift.max(newCount, _growArrayCapacity(oldCapacity))
      : newCount)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 1492)
  @inlinable
  public mutating func _customRemoveLast() -> Element? {
    _precondition(count > 0, "Can't removeLast from an empty ArraySlice")
    // FIXME(performance): if `self` is uniquely referenced, we should remove
    // the element as shown below (this will deallocate the element and
    // decrease memory use).  If `self` is not uniquely referenced, the code
    // below will make a copy of the storage, which is wasteful.  Instead, we
    // should just shrink the view without allocating new storage.
    let i = endIndex
    // We don't check for overflow in `i - 1` because `i` is known to be
    // positive.
    let result = self[i &- 1]
    self.replaceSubrange((i &- 1)..<i, with: EmptyCollection())
    return result
  }
  
  /// Removes and returns the element at the specified position.
  ///
  /// All the elements following the specified position are moved up to
  /// close the gap.
  ///
  ///     var measurements: [Double] = [1.1, 1.5, 2.9, 1.2, 1.5, 1.3, 1.2]
  ///     let removed = measurements.remove(at: 2)
  ///     print(measurements)
  ///     // Prints "[1.1, 1.5, 1.2, 1.5, 1.3, 1.2]"
  ///
  /// - Parameter index: The position of the element to remove. `index` must
  ///   be a valid index of the array.
  /// - Returns: The element at the specified index.
  ///
  /// - Complexity: O(*n*), where *n* is the length of the array.
  @inlinable
  @discardableResult
  public mutating func remove(at index: Int) -> Element {
    let result = self[index]
    self.replaceSubrange(index..<(index + 1), with: EmptyCollection())
    return result
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 1572)

  /// Inserts a new element at the specified position.
  ///
  /// The new element is inserted before the element currently at the specified
  /// index. If you pass the array's `endIndex` property as the `index`
  /// parameter, the new element is appended to the array.
  ///
  ///     var numbers = [1, 2, 3, 4, 5]
  ///     numbers.insert(100, at: 3)
  ///     numbers.insert(200, at: numbers.endIndex)
  ///
  ///     print(numbers)
  ///     // Prints "[1, 2, 3, 100, 4, 5, 200]"
  ///
  /// - Parameter newElement: The new element to insert into the array.
  /// - Parameter i: The position at which to insert the new element.
  ///   `index` must be a valid index of the array or equal to its `endIndex`
  ///   property.
  ///
  /// - Complexity: O(*n*), where *n* is the length of the array.
  @inlinable
  public mutating func insert(_ newElement: Element, at i: Int) {
    _checkIndex(i)
    self.replaceSubrange(i..<i, with: CollectionOfOne(newElement))
  }

  /// Removes all elements from the array.
  ///
  /// - Parameter keepCapacity: Pass `true` to keep the existing capacity of
  ///   the array after removing its elements. The default value is
  ///   `false`.
  ///
  /// - Complexity: O(*n*), where *n* is the length of the array.
  @inlinable
  public mutating func removeAll(keepingCapacity keepCapacity: Bool = false) {
    if !keepCapacity {
      _buffer = _Buffer()
    }
    else {
      self.replaceSubrange(indices, with: EmptyCollection())
    }
  }

  //===--- algorithms -----------------------------------------------------===//

  @inlinable
  public mutating func _withUnsafeMutableBufferPointerIfSupported<R>(
    _ body: (inout UnsafeMutableBufferPointer<Element>) throws -> R
  ) rethrows -> R? {
    return try withUnsafeMutableBufferPointer {
      (bufferPointer) -> R in
      return try body(&bufferPointer)
    }
  }

  @inlinable
  public func _copyToContiguousArray() -> ContiguousArray<Element> {
    if let n = _buffer.requestNativeBuffer() {
      return ContiguousArray(_buffer: n)
    }
    return _copyCollectionToContiguousArray(_buffer)
  }
}

extension ArraySlice : CustomReflectable {
  /// A mirror that reflects the array.
  public var customMirror: Mirror {
    return Mirror(
      self,
      unlabeledChildren: self,
      displayStyle: .collection)
  }
}

extension ArraySlice : CustomStringConvertible, CustomDebugStringConvertible {
  /// A textual representation of the array and its elements.
  public var description: String {
    return _makeCollectionDescription(for: self, withTypeName: nil)
  }

  /// A textual representation of the array and its elements, suitable for
  /// debugging.
  public var debugDescription: String {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 1656)
    return _makeCollectionDescription(for: self, withTypeName: "ArraySlice")
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 1661)
  }
}

extension ArraySlice {
  @inlinable
  @_transparent
  internal func _cPointerArgs() -> (AnyObject?, UnsafeRawPointer?) {
    let p = _baseAddressIfContiguous
    if _fastPath(p != nil || isEmpty) {
      return (_owner, UnsafeRawPointer(p))
    }
    let n = ContiguousArray(self._buffer)._buffer
    return (n.owner, UnsafeRawPointer(n.firstElementAddress))
  }
}

extension ArraySlice {
  /// Calls a closure with a pointer to the array's contiguous storage.
  ///
  /// Often, the optimizer can eliminate bounds checks within an array
  /// algorithm, but when that fails, invoking the same algorithm on the
  /// buffer pointer passed into your closure lets you trade safety for speed.
  ///
  /// The following example shows how you can iterate over the contents of the
  /// buffer pointer:
  ///
  ///     let numbers = [1, 2, 3, 4, 5]
  ///     let sum = numbers.withUnsafeBufferPointer { buffer -> Int in
  ///         var result = 0
  ///         for i in stride(from: buffer.startIndex, to: buffer.endIndex, by: 2) {
  ///             result += buffer[i]
  ///         }
  ///         return result
  ///     }
  ///     // 'sum' == 9
  ///
  /// The pointer passed as an argument to `body` is valid only during the
  /// execution of `withUnsafeBufferPointer(_:)`. Do not store or return the
  /// pointer for later use.
  ///
  /// - Parameter body: A closure with an `UnsafeBufferPointer` parameter that
  ///   points to the contiguous storage for the array.  If
  ///   `body` has a return value, that value is also used as the return value
  ///   for the `withUnsafeBufferPointer(_:)` method. The pointer argument is
  ///   valid only for the duration of the method's execution.
  /// - Returns: The return value, if any, of the `body` closure parameter.
  @inlinable
  public func withUnsafeBufferPointer<R>(
    _ body: (UnsafeBufferPointer<Element>) throws -> R
  ) rethrows -> R {
    return try _buffer.withUnsafeBufferPointer(body)
  }

  /// Calls the given closure with a pointer to the array's mutable contiguous
  /// storage.
  ///
  /// Often, the optimizer can eliminate bounds checks within an array
  /// algorithm, but when that fails, invoking the same algorithm on the
  /// buffer pointer passed into your closure lets you trade safety for speed.
  ///
  /// The following example shows how modifying the contents of the
  /// `UnsafeMutableBufferPointer` argument to `body` alters the contents of
  /// the array:
  ///
  ///     var numbers = [1, 2, 3, 4, 5]
  ///     numbers.withUnsafeMutableBufferPointer { buffer in
  ///         for i in stride(from: buffer.startIndex, to: buffer.endIndex - 1, by: 2) {
  ///             buffer.swapAt(i, i + 1)
  ///         }
  ///     }
  ///     print(numbers)
  ///     // Prints "[2, 1, 4, 3, 5]"
  ///
  /// The pointer passed as an argument to `body` is valid only during the
  /// execution of `withUnsafeMutableBufferPointer(_:)`. Do not store or
  /// return the pointer for later use.
  ///
  /// - Warning: Do not rely on anything about the array that is the target of
  ///   this method during execution of the `body` closure; it might not
  ///   appear to have its correct value. Instead, use only the
  ///   `UnsafeMutableBufferPointer` argument to `body`.
  ///
  /// - Parameter body: A closure with an `UnsafeMutableBufferPointer`
  ///   parameter that points to the contiguous storage for the array.
  ///    If `body` has a return value, that value is also
  ///   used as the return value for the `withUnsafeMutableBufferPointer(_:)`
  ///   method. The pointer argument is valid only for the duration of the
  ///   method's execution.
  /// - Returns: The return value, if any, of the `body` closure parameter.
  @_semantics("array.withUnsafeMutableBufferPointer")
  @inline(__always) // Performance: This method should get inlined into the
  // caller such that we can combine the partial apply with the apply in this
  // function saving on allocating a closure context. This becomes unnecessary
  // once we allocate noescape closures on the stack.
  public mutating func withUnsafeMutableBufferPointer<R>(
    _ body: (inout UnsafeMutableBufferPointer<Element>) throws -> R
  ) rethrows -> R {
    let count = self.count
    // Ensure unique storage
    _buffer._outlinedMakeUniqueBuffer(bufferCount: count)

    // Ensure that body can't invalidate the storage or its bounds by
    // moving self into a temporary working array.
    // NOTE: The stack promotion optimization that keys of the
    // "array.withUnsafeMutableBufferPointer" semantics annotation relies on the
    // array buffer not being able to escape in the closure. It can do this
    // because we swap the array buffer in self with an empty buffer here. Any
    // escape via the address of self in the closure will therefore escape the
    // empty array.

    var work = ArraySlice()
    (work, self) = (self, work)

    // Create an UnsafeBufferPointer over work that we can pass to body
    let pointer = work._buffer.firstElementAddress
    var inoutBufferPointer = UnsafeMutableBufferPointer(
      start: pointer, count: count)

    // Put the working array back before returning.
    defer {
      _precondition(
        inoutBufferPointer.baseAddress == pointer &&
        inoutBufferPointer.count == count,
        "ArraySlice withUnsafeMutableBufferPointer: replacing the buffer is not allowed")

      (work, self) = (self, work)
    }

    // Invoke the body.
    return try body(&inoutBufferPointer)
  }

  @inlinable
  public func _copyContents(
    initializing buffer: UnsafeMutableBufferPointer<Element>
  ) -> (Iterator,UnsafeMutableBufferPointer<Element>.Index) {

    guard !self.isEmpty else { return (makeIterator(),buffer.startIndex) }

    // It is not OK for there to be no pointer/not enough space, as this is
    // a precondition and Array never lies about its count.
    guard var p = buffer.baseAddress
      else { _preconditionFailure("Attempt to copy contents into nil buffer pointer") }
    _precondition(self.count <= buffer.count, 
      "Insufficient space allocated to copy array contents")

    if let s = _baseAddressIfContiguous {
      p.initialize(from: s, count: self.count)
      // Need a _fixLifetime bracketing the _baseAddressIfContiguous getter
      // and all uses of the pointer it returns:
      _fixLifetime(self._owner)
    } else {
      for x in self {
        p.initialize(to: x)
        p += 1
      }
    }

    var it = IndexingIterator(_elements: self)
    it._position = endIndex
    return (it,buffer.index(buffer.startIndex, offsetBy: self.count))
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 45)

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 455)

/// An ordered, random-access collection.
///
/// Arrays are one of the most commonly used data types in an app. You use
/// arrays to organize your app's data. Specifically, you use the `Array` type
/// to hold elements of a single type, the array's `Element` type. An array
/// can store any kind of elements---from integers to strings to classes.
///
/// Swift makes it easy to create arrays in your code using an array literal:
/// simply surround a comma-separated list of values with square brackets.
/// Without any other information, Swift creates an array that includes the
/// specified values, automatically inferring the array's `Element` type. For
/// example:
///
///     // An array of 'Int' elements
///     let oddNumbers = [1, 3, 5, 7, 9, 11, 13, 15]
///
///     // An array of 'String' elements
///     let streets = ["Albemarle", "Brandywine", "Chesapeake"]
///
/// You can create an empty array by specifying the `Element` type of your
/// array in the declaration. For example:
///
///     // Shortened forms are preferred
///     var emptyDoubles: [Double] = []
///
///     // The full type name is also allowed
///     var emptyFloats: Array<Float> = Array()
///
/// If you need an array that is preinitialized with a fixed number of default
/// values, use the `Array(repeating:count:)` initializer.
///
///     var digitCounts = Array(repeating: 0, count: 10)
///     print(digitCounts)
///     // Prints "[0, 0, 0, 0, 0, 0, 0, 0, 0, 0]"
///
/// Accessing Array Values
/// ======================
///
/// When you need to perform an operation on all of an array's elements, use a
/// `for`-`in` loop to iterate through the array's contents.
///
///     for street in streets {
///         print("I don't live on \(street).")
///     }
///     // Prints "I don't live on Albemarle."
///     // Prints "I don't live on Brandywine."
///     // Prints "I don't live on Chesapeake."
///
/// Use the `isEmpty` property to check quickly whether an array has any
/// elements, or use the `count` property to find the number of elements in
/// the array.
///
///     if oddNumbers.isEmpty {
///         print("I don't know any odd numbers.")
///     } else {
///         print("I know \(oddNumbers.count) odd numbers.")
///     }
///     // Prints "I know 8 odd numbers."
///
/// Use the `first` and `last` properties for safe access to the value of the
/// array's first and last elements. If the array is empty, these properties
/// are `nil`.
///
///     if let firstElement = oddNumbers.first, let lastElement = oddNumbers.last {
///         print(firstElement, lastElement, separator: ", ")
///     }
///     // Prints "1, 15"
///
///     print(emptyDoubles.first, emptyDoubles.last, separator: ", ")
///     // Prints "nil, nil"
///
/// You can access individual array elements through a subscript. The first
/// element of a nonempty array is always at index zero. You can subscript an
/// array with any integer from zero up to, but not including, the count of
/// the array. Using a negative number or an index equal to or greater than
/// `count` triggers a runtime error. For example:
///
///     print(oddNumbers[0], oddNumbers[3], separator: ", ")
///     // Prints "1, 7"
///
///     print(emptyDoubles[0])
///     // Triggers runtime error: Index out of range
///
/// Adding and Removing Elements
/// ============================
///
/// Suppose you need to store a list of the names of students that are signed
/// up for a class you're teaching. During the registration period, you need
/// to add and remove names as students add and drop the class.
///
///     var students = ["Ben", "Ivy", "Jordell"]
///
/// To add single elements to the end of an array, use the `append(_:)` method.
/// Add multiple elements at the same time by passing another array or a
/// sequence of any kind to the `append(contentsOf:)` method.
///
///     students.append("Maxime")
///     students.append(contentsOf: ["Shakia", "William"])
///     // ["Ben", "Ivy", "Jordell", "Maxime", "Shakia", "William"]
///
/// You can add new elements in the middle of an array by using the
/// `insert(_:at:)` method for single elements and by using
/// `insert(contentsOf:at:)` to insert multiple elements from another
/// collection or array literal. The elements at that index and later indices
/// are shifted back to make room.
///
///     students.insert("Liam", at: 3)
///     // ["Ben", "Ivy", "Jordell", "Liam", "Maxime", "Shakia", "William"]
///
/// To remove elements from an array, use the `remove(at:)`,
/// `removeSubrange(_:)`, and `removeLast()` methods.
///
///     // Ben's family is moving to another state
///     students.remove(at: 0)
///     // ["Ivy", "Jordell", "Liam", "Maxime", "Shakia", "William"]
///
///     // William is signing up for a different class
///     students.removeLast()
///     // ["Ivy", "Jordell", "Liam", "Maxime", "Shakia"]
///
/// You can replace an existing element with a new value by assigning the new
/// value to the subscript.
///
///     if let i = students.firstIndex(of: "Maxime") {
///         students[i] = "Max"
///     }
///     // ["Ivy", "Jordell", "Liam", "Max", "Shakia"]
///
/// Growing the Size of an Array
/// ----------------------------
///
/// Every array reserves a specific amount of memory to hold its contents. When
/// you add elements to an array and that array begins to exceed its reserved
/// capacity, the array allocates a larger region of memory and copies its
/// elements into the new storage. The new storage is a multiple of the old
/// storage's size. This exponential growth strategy means that appending an
/// element happens in constant time, averaging the performance of many append
/// operations. Append operations that trigger reallocation have a performance
/// cost, but they occur less and less often as the array grows larger.
///
/// If you know approximately how many elements you will need to store, use the
/// `reserveCapacity(_:)` method before appending to the array to avoid
/// intermediate reallocations. Use the `capacity` and `count` properties to
/// determine how many more elements the array can store without allocating
/// larger storage.
///
/// For arrays of most `Element` types, this storage is a contiguous block of
/// memory. For arrays with an `Element` type that is a class or `@objc`
/// protocol type, this storage can be a contiguous block of memory or an
/// instance of `NSArray`. Because any arbitrary subclass of `NSArray` can
/// become an `Array`, there are no guarantees about representation or
/// efficiency in this case.
///
/// Modifying Copies of Arrays
/// ==========================
///
/// Each array has an independent value that includes the values of all of its
/// elements. For simple types such as integers and other structures, this
/// means that when you change a value in one array, the value of that element
/// does not change in any copies of the array. For example:
///
///     var numbers = [1, 2, 3, 4, 5]
///     var numbersCopy = numbers
///     numbers[0] = 100
///     print(numbers)
///     // Prints "[100, 2, 3, 4, 5]"
///     print(numbersCopy)
///     // Prints "[1, 2, 3, 4, 5]"
///
/// If the elements in an array are instances of a class, the semantics are the
/// same, though they might appear different at first. In this case, the
/// values stored in the array are references to objects that live outside the
/// array. If you change a reference to an object in one array, only that
/// array has a reference to the new object. However, if two arrays contain
/// references to the same object, you can observe changes to that object's
/// properties from both arrays. For example:
///
///     // An integer type with reference semantics
///     class IntegerReference {
///         var value = 10
///     }
///     var firstIntegers = [IntegerReference(), IntegerReference()]
///     var secondIntegers = firstIntegers
///
///     // Modifications to an instance are visible from either array
///     firstIntegers[0].value = 100
///     print(secondIntegers[0].value)
///     // Prints "100"
///
///     // Replacements, additions, and removals are still visible
///     // only in the modified array
///     firstIntegers[0] = IntegerReference()
///     print(firstIntegers[0].value)
///     // Prints "10"
///     print(secondIntegers[0].value)
///     // Prints "100"
///
/// Arrays, like all variable-size collections in the standard library, use
/// copy-on-write optimization. Multiple copies of an array share the same
/// storage until you modify one of the copies. When that happens, the array
/// being modified replaces its storage with a uniquely owned copy of itself,
/// which is then modified in place. Optimizations are sometimes applied that
/// can reduce the amount of copying.
///
/// This means that if an array is sharing storage with other copies, the first
/// mutating operation on that array incurs the cost of copying the array. An
/// array that is the sole owner of its storage can perform mutating
/// operations in place.
///
/// In the example below, a `numbers` array is created along with two copies
/// that share the same storage. When the original `numbers` array is
/// modified, it makes a unique copy of its storage before making the
/// modification. Further modifications to `numbers` are made in place, while
/// the two copies continue to share the original storage.
///
///     var numbers = [1, 2, 3, 4, 5]
///     var firstCopy = numbers
///     var secondCopy = numbers
///
///     // The storage for 'numbers' is copied here
///     numbers[0] = 100
///     numbers[1] = 200
///     numbers[2] = 300
///     // 'numbers' is [100, 200, 300, 4, 5]
///     // 'firstCopy' and 'secondCopy' are [1, 2, 3, 4, 5]
///
/// Bridging Between Array and NSArray
/// ==================================
///
/// When you need to access APIs that require data in an `NSArray` instance
/// instead of `Array`, use the type-cast operator (`as`) to bridge your
/// instance. For bridging to be possible, the `Element` type of your array
/// must be a class, an `@objc` protocol (a protocol imported from Objective-C
/// or marked with the `@objc` attribute), or a type that bridges to a
/// Foundation type.
///
/// The following example shows how you can bridge an `Array` instance to
/// `NSArray` to use the `write(to:atomically:)` method. In this example, the
/// `colors` array can be bridged to `NSArray` because the `colors` array's
/// `String` elements bridge to `NSString`. The compiler prevents bridging the
/// `moreColors` array, on the other hand, because its `Element` type is
/// `Optional<String>`, which does *not* bridge to a Foundation type.
///
///     let colors = ["periwinkle", "rose", "moss"]
///     let moreColors: [String?] = ["ochre", "pine"]
///
///     let url = NSURL(fileURLWithPath: "names.plist")
///     (colors as NSArray).write(to: url, atomically: true)
///     // true
///
///     (moreColors as NSArray).write(to: url, atomically: true)
///     // error: cannot convert value of type '[String?]' to type 'NSArray'
///
/// Bridging from `Array` to `NSArray` takes O(1) time and O(1) space if the
/// array's elements are already instances of a class or an `@objc` protocol;
/// otherwise, it takes O(*n*) time and space.
///
/// When the destination array's element type is a class or an `@objc`
/// protocol, bridging from `NSArray` to `Array` first calls the `copy(with:)`
/// (`- copyWithZone:` in Objective-C) method on the array to get an immutable
/// copy and then performs additional Swift bookkeeping work that takes O(1)
/// time. For instances of `NSArray` that are already immutable, `copy(with:)`
/// usually returns the same array in O(1) time; otherwise, the copying
/// performance is unspecified. If `copy(with:)` returns the same array, the
/// instances of `NSArray` and `Array` share storage using the same
/// copy-on-write optimization that is used when two instances of `Array`
/// share storage.
///
/// When the destination array's element type is a nonclass type that bridges
/// to a Foundation type, bridging from `NSArray` to `Array` performs a
/// bridging copy of the elements to contiguous storage in O(*n*) time. For
/// example, bridging from `NSArray` to `Array<Int>` performs such a copy. No
/// further bridging is required when accessing elements of the `Array`
/// instance.
///
/// - Note: The `ContiguousArray` and `ArraySlice` types are not bridged;
///   instances of those types always have a contiguous block of memory as
///   their storage.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 457)
@_fixed_layout
public struct Array<Element>: _DestructorSafeContainer {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 460)
  #if _runtime(_ObjC)
    internal typealias _Buffer = _ArrayBuffer<Element>
  #else
    internal typealias _Buffer = _ContiguousArrayBuffer<Element>
  #endif
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 470)

  @usableFromInline
  internal var _buffer: _Buffer

  /// Initialization from an existing buffer does not have "array.init"
  /// semantics because the caller may retain an alias to buffer.
  @inlinable
  internal init(_buffer: _Buffer) {
    self._buffer = _buffer
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 489)
}

extension Array: RandomAccessCollection, MutableCollection {
  /// The index type for arrays, `Int`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 499)
  public typealias Index = Int

  /// The type that represents the indices that are valid for subscripting an
  /// array, in ascending order.
  public typealias Indices = Range<Int>

  /// The type that allows iteration over an array's elements.
  public typealias Iterator = IndexingIterator<Array>

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 513)
  /// The position of the first element in a nonempty array.
  ///
  /// For an instance of `Array`, `startIndex` is always zero. If the array
  /// is empty, `startIndex` is equal to `endIndex`.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 518)
  @inlinable
  public var startIndex: Int {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 523)
    return 0
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 525)
  }

  /// The array's "past the end" position---that is, the position one greater
  /// than the last valid subscript argument.
  ///
  /// When you need a range that includes the last element of an array, use the
  /// half-open range operator (`..<`) with `endIndex`. The `..<` operator
  /// creates a range that doesn't include the upper bound, so it's always
  /// safe to use with `endIndex`. For example:
  ///
  ///     let numbers = [10, 20, 30, 40, 50]
  ///     if let i = numbers.firstIndex(of: 30) {
  ///         print(numbers[i ..< numbers.endIndex])
  ///     }
  ///     // Prints "[30, 40, 50]"
  ///
  /// If the array is empty, `endIndex` is equal to `startIndex`.
  @inlinable // FIXME(sil-serialize-all)
  public var endIndex: Int {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 547)
    @inlinable
    get {
      return _getCount()
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 552)
  }

  /// Returns the position immediately after the given index.
  ///
  /// - Parameter i: A valid index of the collection. `i` must be less than
  ///   `endIndex`.
  /// - Returns: The index immediately after `i`.
  @inlinable
  public func index(after i: Int) -> Int {
    // NOTE: this is a manual specialization of index movement for a Strideable
    // index that is required for Array performance.  The optimizer is not
    // capable of creating partial specializations yet.
    // NOTE: Range checks are not performed here, because it is done later by
    // the subscript function.
    return i + 1
  }

  /// Replaces the given index with its successor.
  ///
  /// - Parameter i: A valid index of the collection. `i` must be less than
  ///   `endIndex`.
  @inlinable
  public func formIndex(after i: inout Int) {
    // NOTE: this is a manual specialization of index movement for a Strideable
    // index that is required for Array performance.  The optimizer is not
    // capable of creating partial specializations yet.
    // NOTE: Range checks are not performed here, because it is done later by
    // the subscript function.
    i += 1
  }

  /// Returns the position immediately before the given index.
  ///
  /// - Parameter i: A valid index of the collection. `i` must be greater than
  ///   `startIndex`.
  /// - Returns: The index immediately before `i`.
  @inlinable
  public func index(before i: Int) -> Int {
    // NOTE: this is a manual specialization of index movement for a Strideable
    // index that is required for Array performance.  The optimizer is not
    // capable of creating partial specializations yet.
    // NOTE: Range checks are not performed here, because it is done later by
    // the subscript function.
    return i - 1
  }

  /// Replaces the given index with its predecessor.
  ///
  /// - Parameter i: A valid index of the collection. `i` must be greater than
  ///   `startIndex`.
  @inlinable
  public func formIndex(before i: inout Int) {
    // NOTE: this is a manual specialization of index movement for a Strideable
    // index that is required for Array performance.  The optimizer is not
    // capable of creating partial specializations yet.
    // NOTE: Range checks are not performed here, because it is done later by
    // the subscript function.
    i -= 1
  }

  /// Returns an index that is the specified distance from the given index.
  ///
  /// The following example obtains an index advanced four positions from an
  /// array's starting index and then prints the element at that position.
  ///
  ///     let numbers = [10, 20, 30, 40, 50]
  ///     let i = numbers.index(numbers.startIndex, offsetBy: 4)
  ///     print(numbers[i])
  ///     // Prints "50"
  ///
  /// The value passed as `n` must not offset `i` beyond the bounds of the
  /// collection.
  ///
  /// - Parameters:
  ///   - i: A valid index of the array.
  ///   - n: The distance to offset `i`.
  /// - Returns: An index offset by `n` from the index `i`. If `n` is positive,
  ///   this is the same value as the result of `n` calls to `index(after:)`.
  ///   If `n` is negative, this is the same value as the result of `-n` calls
  ///   to `index(before:)`.
  @inlinable
  public func index(_ i: Int, offsetBy n: Int) -> Int {
    // NOTE: this is a manual specialization of index movement for a Strideable
    // index that is required for Array performance.  The optimizer is not
    // capable of creating partial specializations yet.
    // NOTE: Range checks are not performed here, because it is done later by
    // the subscript function.
    return i + n
  }

  /// Returns an index that is the specified distance from the given index,
  /// unless that distance is beyond a given limiting index.
  ///
  /// The following example obtains an index advanced four positions from an
  /// array's starting index and then prints the element at that position. The
  /// operation doesn't require going beyond the limiting `numbers.endIndex`
  /// value, so it succeeds.
  ///
  ///     let numbers = [10, 20, 30, 40, 50]
  ///     if let i = numbers.index(numbers.startIndex,
  ///                              offsetBy: 4,
  ///                              limitedBy: numbers.endIndex) {
  ///         print(numbers[i])
  ///     }
  ///     // Prints "50"
  ///
  /// The next example attempts to retrieve an index ten positions from
  /// `numbers.startIndex`, but fails, because that distance is beyond the
  /// index passed as `limit`.
  ///
  ///     let j = numbers.index(numbers.startIndex,
  ///                           offsetBy: 10,
  ///                           limitedBy: numbers.endIndex)
  ///     print(j)
  ///     // Prints "nil"
  ///
  /// The value passed as `n` must not offset `i` beyond the bounds of the
  /// collection, unless the index passed as `limit` prevents offsetting
  /// beyond those bounds.
  ///
  /// - Parameters:
  ///   - i: A valid index of the array.
  ///   - n: The distance to offset `i`.
  ///   - limit: A valid index of the collection to use as a limit. If `n > 0`,
  ///     `limit` has no effect if it is less than `i`. Likewise, if `n < 0`,
  ///     `limit` has no effect if it is greater than `i`.
  /// - Returns: An index offset by `n` from the index `i`, unless that index
  ///   would be beyond `limit` in the direction of movement. In that case,
  ///   the method returns `nil`.
  @inlinable
  public func index(
    _ i: Int, offsetBy n: Int, limitedBy limit: Int
  ) -> Int? {
    // NOTE: this is a manual specialization of index movement for a Strideable
    // index that is required for Array performance.  The optimizer is not
    // capable of creating partial specializations yet.
    // NOTE: Range checks are not performed here, because it is done later by
    // the subscript function.
    let l = limit - i
    if n > 0 ? l >= 0 && l < n : l <= 0 && n < l {
      return nil
    }
    return i + n
  }

  /// Returns the distance between two indices.
  ///
  /// - Parameters:
  ///   - start: A valid index of the collection.
  ///   - end: Another valid index of the collection. If `end` is equal to
  ///     `start`, the result is zero.
  /// - Returns: The distance between `start` and `end`.
  @inlinable
  public func distance(from start: Int, to end: Int) -> Int {
    // NOTE: this is a manual specialization of index movement for a Strideable
    // index that is required for Array performance.  The optimizer is not
    // capable of creating partial specializations yet.
    // NOTE: Range checks are not performed here, because it is done later by
    // the subscript function.
    return end - start
  }

  @inlinable
  public func _failEarlyRangeCheck(_ index: Int, bounds: Range<Int>) {
    // NOTE: This method is a no-op for performance reasons.
  }

  @inlinable
  public func _failEarlyRangeCheck(_ range: Range<Int>, bounds: Range<Int>) {
    // NOTE: This method is a no-op for performance reasons.
  }

  /// Accesses the element at the specified position.
  ///
  /// The following example uses indexed subscripting to update an array's
  /// second element. After assigning the new value (`"Butler"`) at a specific
  /// position, that value is immediately available at that same position.
  ///
  ///     var streets = ["Adams", "Bryant", "Channing", "Douglas", "Evarts"]
  ///     streets[1] = "Butler"
  ///     print(streets[1])
  ///     // Prints "Butler"
  ///
  /// - Parameter index: The position of the element to access. `index` must be
  ///   greater than or equal to `startIndex` and less than `endIndex`.
  ///
  /// - Complexity: Reading an element from an array is O(1). Writing is O(1)
  ///   unless the array's storage is shared with another array, in which case
  ///   writing is O(*n*), where *n* is the length of the array.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 742)
  ///   If the array uses a bridged `NSArray` instance as its storage, the
  ///   efficiency is unspecified.
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 745)
  @inlinable
  public subscript(index: Int) -> Element {
    get {
      // This call may be hoisted or eliminated by the optimizer.  If
      // there is an inout violation, this value may be stale so needs to be
      // checked again below.
      let wasNativeTypeChecked = _hoistableIsNativeTypeChecked()

      // Make sure the index is in range and wasNativeTypeChecked is
      // still valid.
      let token = _checkSubscript(
        index, wasNativeTypeChecked: wasNativeTypeChecked)

      return _getElement(
        index, wasNativeTypeChecked: wasNativeTypeChecked,
        matchingSubscriptCheck: token)
    }
    mutableAddressWithPinnedNativeOwner {
      _makeMutableAndUniqueOrPinned() // makes the array native, too
      _checkSubscript_native(index)
      return (_getElementAddress(index), Builtin.tryPin(_getOwner_native()))
    }
  }

  /// Accesses a contiguous subrange of the array's elements.
  ///
  /// The returned `ArraySlice` instance uses the same indices for the same
  /// elements as the original array. In particular, that slice, unlike an
  /// array, may have a nonzero `startIndex` and an `endIndex` that is not
  /// equal to `count`. Always use the slice's `startIndex` and `endIndex`
  /// properties instead of assuming that its indices start or end at a
  /// particular value.
  ///
  /// This example demonstrates getting a slice of an array of strings, finding
  /// the index of one of the strings in the slice, and then using that index
  /// in the original array.
  ///
  ///     let streets = ["Adams", "Bryant", "Channing", "Douglas", "Evarts"]
  ///     let streetsSlice = streets[2 ..< streets.endIndex]
  ///     print(streetsSlice)
  ///     // Prints "["Channing", "Douglas", "Evarts"]"
  ///
  ///     let i = streetsSlice.firstIndex(of: "Evarts")    // 4
  ///     print(streets[i!])
  ///     // Prints "Evarts"
  ///
  /// - Parameter bounds: A range of integers. The bounds of the range must be
  ///   valid indices of the array.
  @inlinable
  public subscript(bounds: Range<Int>) -> ArraySlice<Element> {
    get {
      _checkIndex(bounds.lowerBound)
      _checkIndex(bounds.upperBound)
      return ArraySlice(_buffer: _buffer[bounds])
    }
    set(rhs) {
      _checkIndex(bounds.lowerBound)
      _checkIndex(bounds.upperBound)
      // If the replacement buffer has same identity, and the ranges match,
      // then this was a pinned in-place modification, nothing further needed.
      if self[bounds]._buffer.identity != rhs._buffer.identity
      || bounds != rhs.startIndex..<rhs.endIndex {
        self.replaceSubrange(bounds, with: rhs)
      }
    }
  }
}

//===--- private helpers---------------------------------------------------===//
extension Array {
  /// Returns `true` if the array is native and does not need a deferred
  /// type check.  May be hoisted by the optimizer, which means its
  /// results may be stale by the time they are used if there is an
  /// inout violation in user code.
  @inlinable
  @_semantics("array.props.isNativeTypeChecked")
  public // @testable
  func _hoistableIsNativeTypeChecked() -> Bool {
   return _buffer.arrayPropertyIsNativeTypeChecked
  }

  @inlinable
  @_semantics("array.get_count")
  internal func _getCount() -> Int {
    return _buffer.count
  }

  @inlinable
  @_semantics("array.get_capacity")
  internal func _getCapacity() -> Int {
    return _buffer.capacity
  }

  /// - Precondition: The array has a native buffer.
  @inlinable
  @_semantics("array.owner")
  internal func _getOwnerWithSemanticLabel_native() -> Builtin.NativeObject {
    return Builtin.unsafeCastToNativeObject(_buffer.nativeOwner)
  }

  /// - Precondition: The array has a native buffer.
  @inlinable
  @inline(__always)
  internal func _getOwner_native() -> Builtin.NativeObject {
#if _runtime(_ObjC)
    if _isClassOrObjCExistential(Element.self) {
      // We are hiding the access to '_buffer.owner' behind
      // _getOwner() to help the compiler hoist uniqueness checks in
      // the case of class or Objective-C existential typed array
      // elements.
      return _getOwnerWithSemanticLabel_native()
    }
#endif
    // In the value typed case the extra call to
    // _getOwnerWithSemanticLabel_native hinders optimization.
    return Builtin.unsafeCastToNativeObject(_buffer.owner)
  }

  @inlinable
  @_semantics("array.make_mutable")
  internal mutating func _makeMutableAndUnique() {
    if _slowPath(!_buffer.isMutableAndUniquelyReferenced()) {
      _buffer = _Buffer(copying: _buffer)
    }
  }

  @inlinable
  @_semantics("array.make_mutable")
  internal mutating func _makeMutableAndUniqueOrPinned() {
    if _slowPath(!_buffer.isMutableAndUniquelyReferencedOrPinned()) {
      _buffer = _Buffer(copying: _buffer)
    }
  }


  /// Check that the given `index` is valid for subscripting, i.e.
  /// `0 ≤ index < count`.
  @inlinable
  @inline(__always)
  internal func _checkSubscript_native(_ index: Int) {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 888)
    _ = _checkSubscript(index, wasNativeTypeChecked: true)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 890)
  }

  /// Check that the given `index` is valid for subscripting, i.e.
  /// `0 ≤ index < count`.
  @inlinable
  @_semantics("array.check_subscript")
  public // @testable
  func _checkSubscript(
    _ index: Int, wasNativeTypeChecked: Bool
  ) -> _DependenceToken {
#if _runtime(_ObjC)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 902)
    _buffer._checkInoutAndNativeTypeCheckedBounds(
      index, wasNativeTypeChecked: wasNativeTypeChecked)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 907)
#else
    _buffer._checkValidSubscript(index)
#endif
    return _DependenceToken()
  }

  /// Check that the specified `index` is valid, i.e. `0 ≤ index ≤ count`.
  @inlinable
  @_semantics("array.check_index")
  internal func _checkIndex(_ index: Int) {
    _precondition(index <= endIndex, "Array index is out of range")
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 919)
    _precondition(index >= startIndex, "Negative Array index is out of range")
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 923)
  }

  @_semantics("array.get_element")
  @inline(__always)
  public // @testable
  func _getElement(
    _ index: Int,
    wasNativeTypeChecked : Bool,
    matchingSubscriptCheck: _DependenceToken
  ) -> Element {
#if _runtime(_ObjC)
    return _buffer.getElement(index, wasNativeTypeChecked: wasNativeTypeChecked)
#else
    return _buffer.getElement(index)
#endif
  }

  @inlinable
  @_semantics("array.get_element_address")
  internal func _getElementAddress(_ index: Int) -> UnsafeMutablePointer<Element> {
    return _buffer.subscriptBaseAddress + index
  }
}

extension Array : ExpressibleByArrayLiteral {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 949)
  // Optimized implementation for Array
  /// Creates an array from the given array literal.
  ///
  /// Do not call this initializer directly. It is used by the compiler
  /// when you use an array literal. Instead, create a new array by using an
  /// array literal as its value. To do this, enclose a comma-separated list of
  /// values in square brackets.
  ///
  /// Here, an array of strings is created from an array literal holding
  /// only strings.
  ///
  ///     let ingredients = ["cocoa beans", "sugar", "cocoa butter", "salt"]
  ///
  /// - Parameter elements: A variadic list of elements of the new array.
  @inlinable
  public init(arrayLiteral elements: Element...) {
    self = elements
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 987)
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 990)

/// Returns an Array of `_count` uninitialized elements using the
/// given `storage`, and a pointer to uninitialized memory for the
/// first element.
///
/// This function is referenced by the compiler to allocate array literals.
///
/// - Precondition: `storage` is `_ContiguousArrayStorage`.
@inline(__always)
public // COMPILER_INTRINSIC
func _allocateUninitializedArray<Element>(_  builtinCount: Builtin.Word)
    -> (Array<Element>, Builtin.RawPointer) {
  let count = Int(builtinCount)
  if count > 0 {
    // Doing the actual buffer allocation outside of the array.uninitialized
    // semantics function enables stack propagation of the buffer.
    let bufferObject = Builtin.allocWithTailElems_1(
      _ContiguousArrayStorage<Element>.self, builtinCount, Element.self)

    let (array, ptr) = Array<Element>._adoptStorage(bufferObject, count: count)
    return (array, ptr._rawValue)
  }
  // For an empty array no buffer allocation is needed.
  let (array, ptr) = Array<Element>._allocateUninitialized(count)
  return (array, ptr._rawValue)
}

// Referenced by the compiler to deallocate array literals on the
// error path.
@inlinable
@_semantics("array.dealloc_uninitialized")
public // COMPILER_INTRINSIC
func _deallocateUninitializedArray<Element>(
  _ array: __owned Array<Element>
) {
  var array = array
  array._deallocateUninitialized()
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 1029)

extension Array : RangeReplaceableCollection, ArrayProtocol {
  /// Creates a new, empty array.
  ///
  /// This is equivalent to initializing with an empty array literal.
  /// For example:
  ///
  ///     var emptyArray = Array<Int>()
  ///     print(emptyArray.isEmpty)
  ///     // Prints "true"
  ///
  ///     emptyArray = []
  ///     print(emptyArray.isEmpty)
  ///     // Prints "true"
  @inlinable
  @_semantics("array.init")
  public init() {
    _buffer = _Buffer()
  }

  /// Creates an array containing the elements of a sequence.
  ///
  /// You can use this initializer to create an array from any other type that
  /// conforms to the `Sequence` protocol. For example, you might want to
  /// create an array with the integers from 1 through 7. Use this initializer
  /// around a range instead of typing all those numbers in an array literal.
  ///
  ///     let numbers = Array(1...7)
  ///     print(numbers)
  ///     // Prints "[1, 2, 3, 4, 5, 6, 7]"
  ///
  /// You can also use this initializer to convert a complex sequence or
  /// collection type back to an array. For example, the `keys` property of
  /// a dictionary isn't an array with its own storage, it's a collection
  /// that maps its elements from the dictionary only when they're
  /// accessed, saving the time and space needed to allocate an array. If
  /// you need to pass those keys to a method that takes an array, however,
  /// use this initializer to convert that list from its type of
  /// `LazyMapCollection<Dictionary<String, Int>, Int>` to a simple
  /// `[String]`.
  ///
  ///     func cacheImagesWithNames(names: [String]) {
  ///         // custom image loading and caching
  ///      }
  ///
  ///     let namedHues: [String: Int] = ["Vermillion": 18, "Magenta": 302,
  ///             "Gold": 50, "Cerise": 320]
  ///     let colorNames = Array(namedHues.keys)
  ///     cacheImagesWithNames(colorNames)
  ///
  ///     print(colorNames)
  ///     // Prints "["Gold", "Cerise", "Magenta", "Vermillion"]"
  ///
  /// - Parameter s: The sequence of elements to turn into an array.
  @inlinable
  public init<S : Sequence>(_ s: S)
    where S.Element == Element {

    self = Array(
      _buffer: _Buffer(
        _buffer: s._copyToContiguousArray()._buffer,
        shiftedToStartIndex: 0))
  }

  /// Creates a new array containing the specified number of a single, repeated
  /// value.
  ///
  /// Here's an example of creating an array initialized with five strings
  /// containing the letter *Z*.
  ///
  ///     let fiveZs = Array(repeating: "Z", count: 5)
  ///     print(fiveZs)
  ///     // Prints "["Z", "Z", "Z", "Z", "Z"]"
  ///
  /// - Parameters:
  ///   - repeatedValue: The element to repeat.
  ///   - count: The number of times to repeat the value passed in the
  ///     `repeating` parameter. `count` must be zero or greater.
  @inlinable
  @_semantics("array.init")
  public init(repeating repeatedValue: Element, count: Int) {
    var p: UnsafeMutablePointer<Element>
    (self, p) = Array._allocateUninitialized(count)
    for _ in 0..<count {
      p.initialize(to: repeatedValue)
      p += 1
    }
  }

  @inlinable
  @inline(never)
  internal static func _allocateBufferUninitialized(
    minimumCapacity: Int
  ) -> _Buffer {
    let newBuffer = _ContiguousArrayBuffer<Element>(
      _uninitializedCount: 0, minimumCapacity: minimumCapacity)
    return _Buffer(_buffer: newBuffer, shiftedToStartIndex: 0)
  }

  /// Construct a Array of `count` uninitialized elements.
  @inlinable
  internal init(_uninitializedCount count: Int) {
    _precondition(count >= 0, "Can't construct Array with count < 0")
    // Note: Sinking this constructor into an else branch below causes an extra
    // Retain/Release.
    _buffer = _Buffer()
    if count > 0 {
      // Creating a buffer instead of calling reserveCapacity saves doing an
      // unnecessary uniqueness check. We disable inlining here to curb code
      // growth.
      _buffer = Array._allocateBufferUninitialized(minimumCapacity: count)
      _buffer.count = count
    }
    // Can't store count here because the buffer might be pointing to the
    // shared empty array.
  }

  /// Entry point for `Array` literal construction; builds and returns
  /// a Array of `count` uninitialized elements.
  @inlinable
  @_semantics("array.uninitialized")
  internal static func _allocateUninitialized(
    _ count: Int
  ) -> (Array, UnsafeMutablePointer<Element>) {
    let result = Array(_uninitializedCount: count)
    return (result, result._buffer.firstElementAddress)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 1158)

  /// Returns an Array of `count` uninitialized elements using the
  /// given `storage`, and a pointer to uninitialized memory for the
  /// first element.
  ///
  /// - Precondition: `storage is _ContiguousArrayStorage`.
  @inlinable
  @_semantics("array.uninitialized")
  internal static func _adoptStorage(
    _ storage: __owned _ContiguousArrayStorage<Element>, count: Int
  ) -> (Array, UnsafeMutablePointer<Element>) {

    let innerBuffer = _ContiguousArrayBuffer<Element>(
      count: count,
      storage: storage)

    return (
      Array(
        _buffer: _Buffer(_buffer: innerBuffer, shiftedToStartIndex: 0)),
        innerBuffer.firstElementAddress)
  }

  /// Entry point for aborting literal construction: deallocates
  /// a Array containing only uninitialized elements.
  @inlinable
  internal mutating func _deallocateUninitialized() {
    // Set the count to zero and just release as normal.
    // Somewhat of a hack.
    _buffer.count = 0
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 1189)

  /// The number of elements in the array.
  @inlinable
  public var count: Int {
    return _getCount()
  }

  /// The total number of elements that the array can contain without
  /// allocating new storage.
  ///
  /// Every array reserves a specific amount of memory to hold its contents.
  /// When you add elements to an array and that array begins to exceed its
  /// reserved capacity, the array allocates a larger region of memory and
  /// copies its elements into the new storage. The new storage is a multiple
  /// of the old storage's size. This exponential growth strategy means that
  /// appending an element happens in constant time, averaging the performance
  /// of many append operations. Append operations that trigger reallocation
  /// have a performance cost, but they occur less and less often as the array
  /// grows larger.
  ///
  /// The following example creates an array of integers from an array literal,
  /// then appends the elements of another collection. Before appending, the
  /// array allocates new storage that is large enough store the resulting
  /// elements.
  ///
  ///     var numbers = [10, 20, 30, 40, 50]
  ///     // numbers.count == 5
  ///     // numbers.capacity == 5
  ///
  ///     numbers.append(contentsOf: stride(from: 60, through: 100, by: 10))
  ///     // numbers.count == 10
  ///     // numbers.capacity == 12
  @inlinable
  public var capacity: Int {
    return _getCapacity()
  }

  /// An object that guarantees the lifetime of this array's elements.
  @inlinable
  public // @testable
  var _owner: AnyObject? {
    return _buffer.owner
  }

  /// If the elements are stored contiguously, a pointer to the first
  /// element. Otherwise, `nil`.
  @inlinable
  public var _baseAddressIfContiguous: UnsafeMutablePointer<Element>? {
    @inline(__always) // FIXME(TODO: JIRA): Hack around test failure
    get { return _buffer.firstElementAddressIfContiguous }
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 1247)
  //===--- basic mutations ------------------------------------------------===//


  /// Reserves enough space to store the specified number of elements.
  ///
  /// If you are adding a known number of elements to an array, use this method
  /// to avoid multiple reallocations. This method ensures that the array has
  /// unique, mutable, contiguous storage, with space allocated for at least
  /// the requested number of elements.
  ///
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 1258)
  /// Calling the `reserveCapacity(_:)` method on an array with bridged storage
  /// triggers a copy to contiguous storage even if the existing storage
  /// has room to store `minimumCapacity` elements.
  ///
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 1263)
  /// For performance reasons, the size of the newly allocated storage might be
  /// greater than the requested capacity. Use the array's `capacity` property
  /// to determine the size of the new storage.
  ///
  /// Preserving an Array's Geometric Growth Strategy
  /// ===============================================
  ///
  /// If you implement a custom data structure backed by an array that grows
  /// dynamically, naively calling the `reserveCapacity(_:)` method can lead
  /// to worse than expected performance. Arrays need to follow a geometric
  /// allocation pattern for appending elements to achieve amortized
  /// constant-time performance. The `Array` type's `append(_:)` and
  /// `append(contentsOf:)` methods take care of this detail for you, but
  /// `reserveCapacity(_:)` allocates only as much space as you tell it to
  /// (padded to a round value), and no more. This avoids over-allocation, but
  /// can result in insertion not having amortized constant-time performance.
  ///
  /// The following code declares `values`, an array of integers, and the
  /// `addTenQuadratic()` function, which adds ten more values to the `values`
  /// array on each call.
  ///
  ///       var values: [Int] = [0, 1, 2, 3]
  ///
  ///       // Don't use 'reserveCapacity(_:)' like this
  ///       func addTenQuadratic() {
  ///           let newCount = values.count + 10
  ///           values.reserveCapacity(newCount)
  ///           for n in values.count..<newCount {
  ///               values.append(n)
  ///           }
  ///       }
  ///
  /// The call to `reserveCapacity(_:)` increases the `values` array's capacity
  /// by exactly 10 elements on each pass through `addTenQuadratic()`, which
  /// is linear growth. Instead of having constant time when averaged over
  /// many calls, the function may decay to performance that is linear in
  /// `values.count`. This is almost certainly not what you want.
  ///
  /// In cases like this, the simplest fix is often to simply remove the call
  /// to `reserveCapacity(_:)`, and let the `append(_:)` method grow the array
  /// for you.
  ///
  ///       func addTen() {
  ///           let newCount = values.count + 10
  ///           for n in values.count..<newCount {
  ///               values.append(n)
  ///           }
  ///       }
  ///
  /// If you need more control over the capacity of your array, implement your
  /// own geometric growth strategy, passing the size you compute to
  /// `reserveCapacity(_:)`.
  ///
  /// - Parameter minimumCapacity: The requested number of elements to store.
  ///
  /// - Complexity: O(*n*), where *n* is the number of elements in the array.
  @inlinable
  @_semantics("array.mutate_unknown")
  public mutating func reserveCapacity(_ minimumCapacity: Int) {
    if _buffer.requestUniqueMutableBackingBuffer(
      minimumCapacity: minimumCapacity) == nil {

      let newBuffer = _ContiguousArrayBuffer<Element>(
        _uninitializedCount: count, minimumCapacity: minimumCapacity)

      _buffer._copyContents(
        subRange: _buffer.indices,
        initializing: newBuffer.firstElementAddress)
      _buffer = _Buffer(
        _buffer: newBuffer, shiftedToStartIndex: _buffer.startIndex)
    }
    _sanityCheck(capacity >= minimumCapacity)
  }

  /// Copy the contents of the current buffer to a new unique mutable buffer.
  /// The count of the new buffer is set to `oldCount`, the capacity of the
  /// new buffer is big enough to hold 'oldCount' + 1 elements.
  @inlinable
  @inline(never)
  internal mutating func _copyToNewBuffer(oldCount: Int) {
    let newCount = oldCount + 1
    var newBuffer = _buffer._forceCreateUniqueMutableBuffer(
      countForNewBuffer: oldCount, minNewCapacity: newCount)
    _buffer._arrayOutOfPlaceUpdate(
      &newBuffer, oldCount, 0, _IgnorePointer())
  }

  @inlinable
  @_semantics("array.make_mutable")
  internal mutating func _makeUniqueAndReserveCapacityIfNotUnique() {
    if _slowPath(!_buffer.isMutableAndUniquelyReferenced()) {
      _copyToNewBuffer(oldCount: _buffer.count)
    }
  }

  @inlinable
  @_semantics("array.mutate_unknown")
  internal mutating func _reserveCapacityAssumingUniqueBuffer(oldCount: Int) {
    // This is a performance optimization. This code used to be in an ||
    // statement in the _sanityCheck below.
    //
    //   _sanityCheck(_buffer.capacity == 0 ||
    //                _buffer.isMutableAndUniquelyReferenced())
    //
    // SR-6437
    let capacity = _buffer.capacity == 0

    // Due to make_mutable hoisting the situation can arise where we hoist
    // _makeMutableAndUnique out of loop and use it to replace
    // _makeUniqueAndReserveCapacityIfNotUnique that preceeds this call. If the
    // array was empty _makeMutableAndUnique does not replace the empty array
    // buffer by a unique buffer (it just replaces it by the empty array
    // singleton).
    // This specific case is okay because we will make the buffer unique in this
    // function because we request a capacity > 0 and therefore _copyToNewBuffer
    // will be called creating a new buffer.
    _sanityCheck(capacity ||
                 _buffer.isMutableAndUniquelyReferenced())

    if _slowPath(oldCount + 1 > _buffer.capacity) {
      _copyToNewBuffer(oldCount: oldCount)
    }
  }

  @inlinable
  @_semantics("array.mutate_unknown")
  internal mutating func _appendElementAssumeUniqueAndCapacity(
    _ oldCount: Int,
    newElement: Element
  ) {
    _sanityCheck(_buffer.isMutableAndUniquelyReferenced())
    _sanityCheck(_buffer.capacity >= _buffer.count + 1)

    _buffer.count = oldCount + 1
    (_buffer.firstElementAddress + oldCount).initialize(to: newElement)
  }

  /// Adds a new element at the end of the array.
  ///
  /// Use this method to append a single element to the end of a mutable array.
  ///
  ///     var numbers = [1, 2, 3, 4, 5]
  ///     numbers.append(100)
  ///     print(numbers)
  ///     // Prints "[1, 2, 3, 4, 5, 100]"
  ///
  /// Because arrays increase their allocated capacity using an exponential
  /// strategy, appending a single element to an array is an O(1) operation
  /// when averaged over many calls to the `append(_:)` method. When an array
  /// has additional capacity and is not sharing its storage with another
  /// instance, appending an element is O(1). When an array needs to
  /// reallocate storage before appending or its storage is shared with
  /// another copy, appending is O(*n*), where *n* is the length of the array.
  ///
  /// - Parameter newElement: The element to append to the array.
  ///
  /// - Complexity: Amortized O(1) over many additions. If the array uses a
  ///   bridged `NSArray` instance as its storage, the efficiency is
  ///   unspecified.
  @inlinable
  @_semantics("array.append_element")
  public mutating func append(_ newElement: Element) {
    _makeUniqueAndReserveCapacityIfNotUnique()
    let oldCount = _getCount()
    _reserveCapacityAssumingUniqueBuffer(oldCount: oldCount)
    _appendElementAssumeUniqueAndCapacity(oldCount, newElement: newElement)
  }

  /// Adds the elements of a sequence to the end of the array.
  ///
  /// Use this method to append the elements of a sequence to the end of this
  /// array. This example appends the elements of a `Range<Int>` instance
  /// to an array of integers.
  ///
  ///     var numbers = [1, 2, 3, 4, 5]
  ///     numbers.append(contentsOf: 10...15)
  ///     print(numbers)
  ///     // Prints "[1, 2, 3, 4, 5, 10, 11, 12, 13, 14, 15]"
  ///
  /// - Parameter newElements: The elements to append to the array.
  ///
  /// - Complexity: O(*n*), where *n* is the length of the resulting array.
  @inlinable
  @_semantics("array.append_contentsOf")
  public mutating func append<S : Sequence>(contentsOf newElements: S)
    where S.Element == Element {

    let newElementsCount = newElements.underestimatedCount
    reserveCapacityForAppend(newElementsCount: newElementsCount)

    let oldCount = self.count
    let startNewElements = _buffer.firstElementAddress + oldCount
    let buf = UnsafeMutableBufferPointer(
                start: startNewElements, 
                count: self.capacity - oldCount)

    let (remainder,writtenUpTo) = buf.initialize(from: newElements)
    
    // trap on underflow from the sequence's underestimate:
    let writtenCount = buf.distance(from: buf.startIndex, to: writtenUpTo)
    _precondition(newElementsCount <= writtenCount, 
      "newElements.underestimatedCount was an overestimate")
    // can't check for overflow as sequences can underestimate

    _buffer.count += writtenCount

    if writtenUpTo == buf.endIndex {
      // there may be elements that didn't fit in the existing buffer,
      // append them in slow sequence-only mode
      _buffer._arrayAppendSequence(IteratorSequence(remainder))
    }
  }

  @inlinable
  @_semantics("array.reserve_capacity_for_append")
  internal mutating func reserveCapacityForAppend(newElementsCount: Int) {
    let oldCount = self.count
    let oldCapacity = self.capacity
    let newCount = oldCount + newElementsCount

    // Ensure uniqueness, mutability, and sufficient storage.  Note that
    // for consistency, we need unique self even if newElements is empty.
    self.reserveCapacity(
      newCount > oldCapacity ?
      Swift.max(newCount, _growArrayCapacity(oldCapacity))
      : newCount)
  }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 1532)
  @inlinable
  public mutating func _customRemoveLast() -> Element? {
    let newCount = _getCount() - 1
    _precondition(newCount >= 0, "Can't removeLast from an empty Array")
    _makeUniqueAndReserveCapacityIfNotUnique()
    let pointer = (_buffer.firstElementAddress + newCount)
    let element = pointer.move()
    _buffer.count = newCount
    return element
  }

  /// Removes and returns the element at the specified position.
  ///
  /// All the elements following the specified position are moved up to
  /// close the gap.
  ///
  ///     var measurements: [Double] = [1.1, 1.5, 2.9, 1.2, 1.5, 1.3, 1.2]
  ///     let removed = measurements.remove(at: 2)
  ///     print(measurements)
  ///     // Prints "[1.1, 1.5, 1.2, 1.5, 1.3, 1.2]"
  ///
  /// - Parameter index: The position of the element to remove. `index` must
  ///   be a valid index of the array.
  /// - Returns: The element at the specified index.
  ///
  /// - Complexity: O(*n*), where *n* is the length of the array.
  @inlinable
  @discardableResult
  public mutating func remove(at index: Int) -> Element {
    _precondition(index < endIndex, "Index out of range")
    _precondition(index >= startIndex, "Index out of range")
    _makeUniqueAndReserveCapacityIfNotUnique()
    let newCount = _getCount() - 1
    let pointer = (_buffer.firstElementAddress + index)
    let result = pointer.move()
    pointer.moveInitialize(from: pointer + 1, count: newCount - index)
    _buffer.count = newCount
    return result
  }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 1572)

  /// Inserts a new element at the specified position.
  ///
  /// The new element is inserted before the element currently at the specified
  /// index. If you pass the array's `endIndex` property as the `index`
  /// parameter, the new element is appended to the array.
  ///
  ///     var numbers = [1, 2, 3, 4, 5]
  ///     numbers.insert(100, at: 3)
  ///     numbers.insert(200, at: numbers.endIndex)
  ///
  ///     print(numbers)
  ///     // Prints "[1, 2, 3, 100, 4, 5, 200]"
  ///
  /// - Parameter newElement: The new element to insert into the array.
  /// - Parameter i: The position at which to insert the new element.
  ///   `index` must be a valid index of the array or equal to its `endIndex`
  ///   property.
  ///
  /// - Complexity: O(*n*), where *n* is the length of the array.
  @inlinable
  public mutating func insert(_ newElement: Element, at i: Int) {
    _checkIndex(i)
    self.replaceSubrange(i..<i, with: CollectionOfOne(newElement))
  }

  /// Removes all elements from the array.
  ///
  /// - Parameter keepCapacity: Pass `true` to keep the existing capacity of
  ///   the array after removing its elements. The default value is
  ///   `false`.
  ///
  /// - Complexity: O(*n*), where *n* is the length of the array.
  @inlinable
  public mutating func removeAll(keepingCapacity keepCapacity: Bool = false) {
    if !keepCapacity {
      _buffer = _Buffer()
    }
    else {
      self.replaceSubrange(indices, with: EmptyCollection())
    }
  }

  //===--- algorithms -----------------------------------------------------===//

  @inlinable
  public mutating func _withUnsafeMutableBufferPointerIfSupported<R>(
    _ body: (inout UnsafeMutableBufferPointer<Element>) throws -> R
  ) rethrows -> R? {
    return try withUnsafeMutableBufferPointer {
      (bufferPointer) -> R in
      return try body(&bufferPointer)
    }
  }

  @inlinable
  public func _copyToContiguousArray() -> ContiguousArray<Element> {
    if let n = _buffer.requestNativeBuffer() {
      return ContiguousArray(_buffer: n)
    }
    return _copyCollectionToContiguousArray(_buffer)
  }
}

extension Array : CustomReflectable {
  /// A mirror that reflects the array.
  public var customMirror: Mirror {
    return Mirror(
      self,
      unlabeledChildren: self,
      displayStyle: .collection)
  }
}

extension Array : CustomStringConvertible, CustomDebugStringConvertible {
  /// A textual representation of the array and its elements.
  public var description: String {
    return _makeCollectionDescription(for: self, withTypeName: nil)
  }

  /// A textual representation of the array and its elements, suitable for
  /// debugging.
  public var debugDescription: String {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 1658)
    // Always show sugared representation for Arrays.
    return _makeCollectionDescription(for: self, withTypeName: nil)
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 1661)
  }
}

extension Array {
  @inlinable
  @_transparent
  internal func _cPointerArgs() -> (AnyObject?, UnsafeRawPointer?) {
    let p = _baseAddressIfContiguous
    if _fastPath(p != nil || isEmpty) {
      return (_owner, UnsafeRawPointer(p))
    }
    let n = ContiguousArray(self._buffer)._buffer
    return (n.owner, UnsafeRawPointer(n.firstElementAddress))
  }
}

extension Array {
  /// Calls a closure with a pointer to the array's contiguous storage.
  ///
  /// Often, the optimizer can eliminate bounds checks within an array
  /// algorithm, but when that fails, invoking the same algorithm on the
  /// buffer pointer passed into your closure lets you trade safety for speed.
  ///
  /// The following example shows how you can iterate over the contents of the
  /// buffer pointer:
  ///
  ///     let numbers = [1, 2, 3, 4, 5]
  ///     let sum = numbers.withUnsafeBufferPointer { buffer -> Int in
  ///         var result = 0
  ///         for i in stride(from: buffer.startIndex, to: buffer.endIndex, by: 2) {
  ///             result += buffer[i]
  ///         }
  ///         return result
  ///     }
  ///     // 'sum' == 9
  ///
  /// The pointer passed as an argument to `body` is valid only during the
  /// execution of `withUnsafeBufferPointer(_:)`. Do not store or return the
  /// pointer for later use.
  ///
  /// - Parameter body: A closure with an `UnsafeBufferPointer` parameter that
  ///   points to the contiguous storage for the array.  If no such storage exists, it is created. If
  ///   `body` has a return value, that value is also used as the return value
  ///   for the `withUnsafeBufferPointer(_:)` method. The pointer argument is
  ///   valid only for the duration of the method's execution.
  /// - Returns: The return value, if any, of the `body` closure parameter.
  @inlinable
  public func withUnsafeBufferPointer<R>(
    _ body: (UnsafeBufferPointer<Element>) throws -> R
  ) rethrows -> R {
    return try _buffer.withUnsafeBufferPointer(body)
  }

  /// Calls the given closure with a pointer to the array's mutable contiguous
  /// storage.
  ///
  /// Often, the optimizer can eliminate bounds checks within an array
  /// algorithm, but when that fails, invoking the same algorithm on the
  /// buffer pointer passed into your closure lets you trade safety for speed.
  ///
  /// The following example shows how modifying the contents of the
  /// `UnsafeMutableBufferPointer` argument to `body` alters the contents of
  /// the array:
  ///
  ///     var numbers = [1, 2, 3, 4, 5]
  ///     numbers.withUnsafeMutableBufferPointer { buffer in
  ///         for i in stride(from: buffer.startIndex, to: buffer.endIndex - 1, by: 2) {
  ///             buffer.swapAt(i, i + 1)
  ///         }
  ///     }
  ///     print(numbers)
  ///     // Prints "[2, 1, 4, 3, 5]"
  ///
  /// The pointer passed as an argument to `body` is valid only during the
  /// execution of `withUnsafeMutableBufferPointer(_:)`. Do not store or
  /// return the pointer for later use.
  ///
  /// - Warning: Do not rely on anything about the array that is the target of
  ///   this method during execution of the `body` closure; it might not
  ///   appear to have its correct value. Instead, use only the
  ///   `UnsafeMutableBufferPointer` argument to `body`.
  ///
  /// - Parameter body: A closure with an `UnsafeMutableBufferPointer`
  ///   parameter that points to the contiguous storage for the array.
  ///    If no such storage exists, it is created. If `body` has a return value, that value is also
  ///   used as the return value for the `withUnsafeMutableBufferPointer(_:)`
  ///   method. The pointer argument is valid only for the duration of the
  ///   method's execution.
  /// - Returns: The return value, if any, of the `body` closure parameter.
  @_semantics("array.withUnsafeMutableBufferPointer")
  @inline(__always) // Performance: This method should get inlined into the
  // caller such that we can combine the partial apply with the apply in this
  // function saving on allocating a closure context. This becomes unnecessary
  // once we allocate noescape closures on the stack.
  public mutating func withUnsafeMutableBufferPointer<R>(
    _ body: (inout UnsafeMutableBufferPointer<Element>) throws -> R
  ) rethrows -> R {
    let count = self.count
    // Ensure unique storage
    _buffer._outlinedMakeUniqueBuffer(bufferCount: count)

    // Ensure that body can't invalidate the storage or its bounds by
    // moving self into a temporary working array.
    // NOTE: The stack promotion optimization that keys of the
    // "array.withUnsafeMutableBufferPointer" semantics annotation relies on the
    // array buffer not being able to escape in the closure. It can do this
    // because we swap the array buffer in self with an empty buffer here. Any
    // escape via the address of self in the closure will therefore escape the
    // empty array.

    var work = Array()
    (work, self) = (self, work)

    // Create an UnsafeBufferPointer over work that we can pass to body
    let pointer = work._buffer.firstElementAddress
    var inoutBufferPointer = UnsafeMutableBufferPointer(
      start: pointer, count: count)

    // Put the working array back before returning.
    defer {
      _precondition(
        inoutBufferPointer.baseAddress == pointer &&
        inoutBufferPointer.count == count,
        "Array withUnsafeMutableBufferPointer: replacing the buffer is not allowed")

      (work, self) = (self, work)
    }

    // Invoke the body.
    return try body(&inoutBufferPointer)
  }

  @inlinable
  public func _copyContents(
    initializing buffer: UnsafeMutableBufferPointer<Element>
  ) -> (Iterator,UnsafeMutableBufferPointer<Element>.Index) {

    guard !self.isEmpty else { return (makeIterator(),buffer.startIndex) }

    // It is not OK for there to be no pointer/not enough space, as this is
    // a precondition and Array never lies about its count.
    guard var p = buffer.baseAddress
      else { _preconditionFailure("Attempt to copy contents into nil buffer pointer") }
    _precondition(self.count <= buffer.count, 
      "Insufficient space allocated to copy array contents")

    if let s = _baseAddressIfContiguous {
      p.initialize(from: s, count: self.count)
      // Need a _fixLifetime bracketing the _baseAddressIfContiguous getter
      // and all uses of the pointer it returns:
      _fixLifetime(self._owner)
    } else {
      for x in self {
        p.initialize(to: x)
        p += 1
      }
    }

    var it = IndexingIterator(_elements: self)
    it._position = endIndex
    return (it,buffer.index(buffer.startIndex, offsetBy: self.count))
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 1825)

// Utility method for collections that wish to implement CustomStringConvertible
// and CustomDebugStringConvertible using a bracketed list of elements,
// like an array.
@inlinable // FIXME(sil-serialize-all)
internal func _makeCollectionDescription<C : Collection>
  (for items: C, withTypeName type: String?) -> String {
  var result = ""
  if let type = type {
    result += "\(type)(["
  } else {
    result += "["
  }
  var first = true
  for item in items {
    if first {
      first = false
    } else {
      result += ", "
    }
    debugPrint(item, terminator: "", to: &result)
  }
  result += type != nil ? "])" : "]"
  return result
}

@usableFromInline
@_fixed_layout
internal struct _InitializeMemoryFromCollection<
  C: Collection
> : _PointerFunction {
  @inlinable
  internal func call(_ rawMemory: UnsafeMutablePointer<C.Element>, count: Int) {
    var p = rawMemory
    var q = newValues.startIndex
    for _ in 0..<count {
      p.initialize(to: newValues[q])
      newValues.formIndex(after: &q)
      p += 1
    }
    _expectEnd(of: newValues, is: q)
  }

  @inlinable
  internal init(_ newValues: C) {
    self.newValues = newValues
  }

  @usableFromInline
  internal var newValues: C
}

extension _ArrayBufferProtocol {
  @inlinable
  @inline(never)
  internal mutating func _arrayOutOfPlaceReplace<C : Collection>(
    _ bounds: Range<Int>,
    with newValues: C,
    count insertCount: Int
  ) where C.Element == Element {

    let growth = insertCount - bounds.count
    let newCount = self.count + growth
    var newBuffer = _forceCreateUniqueMutableBuffer(
      newCount: newCount, requiredCapacity: newCount)

    _arrayOutOfPlaceUpdate(
      &newBuffer,
      bounds.lowerBound - startIndex, insertCount,
      _InitializeMemoryFromCollection(newValues)
    )
  }
}

/// A _debugPrecondition check that `i` has exactly reached the end of
/// `s`.  This test is never used to ensure memory safety; that is
/// always guaranteed by measuring `s` once and re-using that value.
@inlinable
internal func _expectEnd<C : Collection>(of s: C, is i: C.Index) {
  _debugPrecondition(
    i == s.endIndex,
    "invalid Collection: count differed in successive traversals")
}

@inlinable
internal func _growArrayCapacity(_ capacity: Int) -> Int {
  return capacity * 2
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 1915)
extension ContiguousArray {
  /// Replaces a range of elements with the elements in the specified
  /// collection.
  ///
  /// This method has the effect of removing the specified range of elements
  /// from the array and inserting the new elements at the same location. The
  /// number of new elements need not match the number of elements being
  /// removed.
  ///
  /// In this example, three elements in the middle of an array of integers are
  /// replaced by the five elements of a `Repeated<Int>` instance.
  ///
  ///      var nums = [10, 20, 30, 40, 50]
  ///      nums.replaceSubrange(1...3, with: repeatElement(1, count: 5))
  ///      print(nums)
  ///      // Prints "[10, 1, 1, 1, 1, 1, 50]"
  ///
  /// If you pass a zero-length range as the `subrange` parameter, this method
  /// inserts the elements of `newElements` at `subrange.startIndex`. Calling
  /// the `insert(contentsOf:at:)` method instead is preferred.
  ///
  /// Likewise, if you pass a zero-length collection as the `newElements`
  /// parameter, this method removes the elements in the given subrange
  /// without replacement. Calling the `removeSubrange(_:)` method instead is
  /// preferred.
  ///
  /// - Parameters:
  ///   - subrange: The subrange of the array to replace. The start and end of
  ///     a subrange must be valid indices of the array.
  ///   - newElements: The new elements to add to the array.
  ///
  /// - Complexity: O(`subrange.count`) if you are replacing a suffix of the
  ///   array with an empty collection; otherwise, O(*n*), where *n* is the
  ///   length of the array.
  @inlinable
  @_semantics("array.mutate_unknown")
  public mutating func replaceSubrange<C>(
    _ subrange: Range<Int>,
    with newElements: C
  ) where C : Collection, C.Element == Element {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 1956)
    _precondition(subrange.lowerBound >= self._buffer.startIndex,
      "ContiguousArray replace: subrange start is negative")
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 1962)

    _precondition(subrange.upperBound <= _buffer.endIndex,
      "ContiguousArray replace: subrange extends past the end")

    let oldCount = _buffer.count
    let eraseCount = subrange.count
    let insertCount = newElements.count
    let growth = insertCount - eraseCount

    if _buffer.requestUniqueMutableBackingBuffer(
      minimumCapacity: oldCount + growth) != nil {

      _buffer.replaceSubrange(
        subrange, with: insertCount, elementsOf: newElements)
    } else {
      _buffer._arrayOutOfPlaceReplace(subrange, with: newElements, count: insertCount)
    }
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 1915)
extension ArraySlice {
  /// Replaces a range of elements with the elements in the specified
  /// collection.
  ///
  /// This method has the effect of removing the specified range of elements
  /// from the array and inserting the new elements at the same location. The
  /// number of new elements need not match the number of elements being
  /// removed.
  ///
  /// In this example, three elements in the middle of an array of integers are
  /// replaced by the five elements of a `Repeated<Int>` instance.
  ///
  ///      var nums = [10, 20, 30, 40, 50]
  ///      nums.replaceSubrange(1...3, with: repeatElement(1, count: 5))
  ///      print(nums)
  ///      // Prints "[10, 1, 1, 1, 1, 1, 50]"
  ///
  /// If you pass a zero-length range as the `subrange` parameter, this method
  /// inserts the elements of `newElements` at `subrange.startIndex`. Calling
  /// the `insert(contentsOf:at:)` method instead is preferred.
  ///
  /// Likewise, if you pass a zero-length collection as the `newElements`
  /// parameter, this method removes the elements in the given subrange
  /// without replacement. Calling the `removeSubrange(_:)` method instead is
  /// preferred.
  ///
  /// - Parameters:
  ///   - subrange: The subrange of the array to replace. The start and end of
  ///     a subrange must be valid indices of the array.
  ///   - newElements: The new elements to add to the array.
  ///
  /// - Complexity: O(`subrange.count`) if you are replacing a suffix of the
  ///   array with an empty collection; otherwise, O(*n*), where *n* is the
  ///   length of the array.
  @inlinable
  @_semantics("array.mutate_unknown")
  public mutating func replaceSubrange<C>(
    _ subrange: Range<Int>,
    with newElements: C
  ) where C : Collection, C.Element == Element {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 1959)
    _precondition(subrange.lowerBound >= _buffer.startIndex,
      "ArraySlice replace: subrange start is before the startIndex")
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 1962)

    _precondition(subrange.upperBound <= _buffer.endIndex,
      "ArraySlice replace: subrange extends past the end")

    let oldCount = _buffer.count
    let eraseCount = subrange.count
    let insertCount = newElements.count
    let growth = insertCount - eraseCount

    if _buffer.requestUniqueMutableBackingBuffer(
      minimumCapacity: oldCount + growth) != nil {

      _buffer.replaceSubrange(
        subrange, with: insertCount, elementsOf: newElements)
    } else {
      _buffer._arrayOutOfPlaceReplace(subrange, with: newElements, count: insertCount)
    }
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 1915)
extension Array {
  /// Replaces a range of elements with the elements in the specified
  /// collection.
  ///
  /// This method has the effect of removing the specified range of elements
  /// from the array and inserting the new elements at the same location. The
  /// number of new elements need not match the number of elements being
  /// removed.
  ///
  /// In this example, three elements in the middle of an array of integers are
  /// replaced by the five elements of a `Repeated<Int>` instance.
  ///
  ///      var nums = [10, 20, 30, 40, 50]
  ///      nums.replaceSubrange(1...3, with: repeatElement(1, count: 5))
  ///      print(nums)
  ///      // Prints "[10, 1, 1, 1, 1, 1, 50]"
  ///
  /// If you pass a zero-length range as the `subrange` parameter, this method
  /// inserts the elements of `newElements` at `subrange.startIndex`. Calling
  /// the `insert(contentsOf:at:)` method instead is preferred.
  ///
  /// Likewise, if you pass a zero-length collection as the `newElements`
  /// parameter, this method removes the elements in the given subrange
  /// without replacement. Calling the `removeSubrange(_:)` method instead is
  /// preferred.
  ///
  /// - Parameters:
  ///   - subrange: The subrange of the array to replace. The start and end of
  ///     a subrange must be valid indices of the array.
  ///   - newElements: The new elements to add to the array.
  ///
  /// - Complexity: O(`subrange.count`) if you are replacing a suffix of the
  ///   array with an empty collection; otherwise, O(*n*), where *n* is the
  ///   length of the array.
  @inlinable
  @_semantics("array.mutate_unknown")
  public mutating func replaceSubrange<C>(
    _ subrange: Range<Int>,
    with newElements: C
  ) where C : Collection, C.Element == Element {
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 1956)
    _precondition(subrange.lowerBound >= self._buffer.startIndex,
      "Array replace: subrange start is negative")
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 1962)

    _precondition(subrange.upperBound <= _buffer.endIndex,
      "Array replace: subrange extends past the end")

    let oldCount = _buffer.count
    let eraseCount = subrange.count
    let insertCount = newElements.count
    let growth = insertCount - eraseCount

    if _buffer.requestUniqueMutableBackingBuffer(
      minimumCapacity: oldCount + growth) != nil {

      _buffer.replaceSubrange(
        subrange, with: insertCount, elementsOf: newElements)
    } else {
      _buffer._arrayOutOfPlaceReplace(subrange, with: newElements, count: insertCount)
    }
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 1982)

//===--- generic helpers --------------------------------------------------===//

extension _ArrayBufferProtocol {
  /// Create a unique mutable buffer that has enough capacity to hold 'newCount'
  /// elements and at least 'requiredCapacity' elements. Set the count of the new
  /// buffer to 'newCount'. The content of the buffer is uninitialized.
  /// The formula used to compute the new buffers capacity is:
  ///   max(requiredCapacity, source.capacity)  if newCount <= source.capacity
  ///   max(requiredCapacity, _growArrayCapacity(source.capacity)) otherwise
  @inlinable
  @inline(never)
  internal func _forceCreateUniqueMutableBuffer(
    newCount: Int, requiredCapacity: Int
  ) -> _ContiguousArrayBuffer<Element> {
    return _forceCreateUniqueMutableBufferImpl(
      countForBuffer: newCount, minNewCapacity: newCount,
      requiredCapacity: requiredCapacity)
  }

  /// Create a unique mutable buffer that has enough capacity to hold
  /// 'minNewCapacity' elements and set the count of the new buffer to
  /// 'countForNewBuffer'. The content of the buffer uninitialized.
  /// The formula used to compute the new buffers capacity is:
  ///   max(minNewCapacity, source.capacity) if minNewCapacity <= source.capacity
  ///   max(minNewCapacity, _growArrayCapacity(source.capacity)) otherwise
  @inlinable
  @inline(never)
  internal func _forceCreateUniqueMutableBuffer(
    countForNewBuffer: Int, minNewCapacity: Int
  ) -> _ContiguousArrayBuffer<Element> {
    return _forceCreateUniqueMutableBufferImpl(
      countForBuffer: countForNewBuffer, minNewCapacity: minNewCapacity,
      requiredCapacity: minNewCapacity)
  }

  /// Create a unique mutable buffer that has enough capacity to hold
  /// 'minNewCapacity' elements and at least 'requiredCapacity' elements and set
  /// the count of the new buffer to 'countForBuffer'. The content of the buffer
  /// uninitialized.
  /// The formula used to compute the new capacity is:
  ///  max(requiredCapacity, source.capacity) if minNewCapacity <= source.capacity
  ///  max(requiredCapacity, _growArrayCapacity(source.capacity))  otherwise
  @inlinable
  internal func _forceCreateUniqueMutableBufferImpl(
    countForBuffer: Int, minNewCapacity: Int,
    requiredCapacity: Int
  ) -> _ContiguousArrayBuffer<Element> {
    _sanityCheck(countForBuffer >= 0)
    _sanityCheck(requiredCapacity >= countForBuffer)
    _sanityCheck(minNewCapacity >= countForBuffer)

    let minimumCapacity = Swift.max(requiredCapacity,
      minNewCapacity > capacity
         ? _growArrayCapacity(capacity) : capacity)

    return _ContiguousArrayBuffer(
      _uninitializedCount: countForBuffer, minimumCapacity: minimumCapacity)
  }
}

@usableFromInline
internal protocol _PointerFunction {
  associatedtype Element
  func call(_: UnsafeMutablePointer<Element>, count: Int)
}

extension _ArrayBufferProtocol {
  /// Initialize the elements of dest by copying the first headCount
  /// items from source, calling initializeNewElements on the next
  /// uninitialized element, and finally by copying the last N items
  /// from source into the N remaining uninitialized elements of dest.
  ///
  /// As an optimization, may move elements out of source rather than
  /// copying when it isUniquelyReferenced.
  @inlinable
  @inline(never)
  internal mutating func _arrayOutOfPlaceUpdate<Initializer>(
    _ dest: inout _ContiguousArrayBuffer<Element>,
    _ headCount: Int, // Count of initial source elements to copy/move
    _ newCount: Int,  // Number of new elements to insert
    _ initializeNewElements: Initializer
  ) where
    Initializer : _PointerFunction,
    Initializer.Element == Element {

    _sanityCheck(headCount >= 0)
    _sanityCheck(newCount >= 0)

    // Count of trailing source elements to copy/move
    let sourceCount = self.count
    let tailCount = dest.count - headCount - newCount
    _sanityCheck(headCount + tailCount <= sourceCount)

    let oldCount = sourceCount - headCount - tailCount
    let destStart = dest.firstElementAddress
    let newStart = destStart + headCount
    let newEnd = newStart + newCount

    // Check to see if we have storage we can move from
    if let backing = requestUniqueMutableBackingBuffer(
      minimumCapacity: sourceCount) {

      let sourceStart = firstElementAddress
      let oldStart = sourceStart + headCount

      // Destroy any items that may be lurking in a _SliceBuffer before
      // its real first element
      let backingStart = backing.firstElementAddress
      let sourceOffset = sourceStart - backingStart
      backingStart.deinitialize(count: sourceOffset)

      // Move the head items
      destStart.moveInitialize(from: sourceStart, count: headCount)

      // Destroy unused source items
      oldStart.deinitialize(count: oldCount)

      initializeNewElements.call(newStart, count: newCount)

      // Move the tail items
      newEnd.moveInitialize(from: oldStart + oldCount, count: tailCount)

      // Destroy any items that may be lurking in a _SliceBuffer after
      // its real last element
      let backingEnd = backingStart + backing.count
      let sourceEnd = sourceStart + sourceCount
      sourceEnd.deinitialize(count: backingEnd - sourceEnd)
      backing.count = 0
    }
    else {
      let headStart = startIndex
      let headEnd = headStart + headCount
      let newStart = _copyContents(
        subRange: headStart..<headEnd,
        initializing: destStart)
      initializeNewElements.call(newStart, count: newCount)
      let tailStart = headEnd + oldCount
      let tailEnd = endIndex
      _copyContents(subRange: tailStart..<tailEnd, initializing: newEnd)
    }
    self = Self(_buffer: dest, shiftedToStartIndex: startIndex)
  }
}

@usableFromInline
@_fixed_layout
internal struct _IgnorePointer<T> : _PointerFunction {
  @inlinable
  internal func call(_: UnsafeMutablePointer<T>, count: Int) {
    _sanityCheck(count == 0)
  }

  @inlinable
  internal init() {
  }
}

extension _ArrayBufferProtocol {
  @inlinable
  @inline(never)
  internal mutating func _outlinedMakeUniqueBuffer(bufferCount: Int) {

    if _fastPath(
        requestUniqueMutableBackingBuffer(minimumCapacity: bufferCount) != nil) {
      return
    }

    var newBuffer = _forceCreateUniqueMutableBuffer(
      newCount: bufferCount, requiredCapacity: bufferCount)
    _arrayOutOfPlaceUpdate(&newBuffer, bufferCount, 0, _IgnorePointer())
  }

  /// Append items from `newItems` to a buffer.
  @inlinable
  internal mutating func _arrayAppendSequence<S : Sequence>(
    _ newItems: S
  ) where S.Element == Element {
    
    // this function is only ever called from append(contentsOf:)
    // which should always have exhausted its capacity before calling
    _sanityCheck(count == capacity)
    var newCount = self.count

    // there might not be any elements to append remaining,
    // so check for nil element first, then increase capacity,
    // then inner-loop to fill that capacity with elements
    var stream = newItems.makeIterator()
    var nextItem = stream.next()
    while nextItem != nil {

      // grow capacity, first time around and when filled
      var newBuffer = _forceCreateUniqueMutableBuffer(
        countForNewBuffer: newCount, 
        // minNewCapacity handles the exponential growth, just
        // need to request 1 more than current count/capacity
        minNewCapacity: newCount + 1)

      _arrayOutOfPlaceUpdate(&newBuffer, newCount, 0, _IgnorePointer())

      let currentCapacity = self.capacity
      let base = self.firstElementAddress

      // fill while there is another item and spare capacity
      while let next = nextItem, newCount < currentCapacity {
        (base + newCount).initialize(to: next)
        newCount += 1
        nextItem = stream.next()
      }
      self.count = newCount
    }
  }
}

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 2197)

extension ContiguousArray : Equatable where Element : Equatable {
  /// Returns a Boolean value indicating whether two arrays contain the same
  /// elements in the same order.
  ///
  /// You can use the equal-to operator (`==`) to compare any two arrays
  /// that store the same, `Equatable`-conforming element type.
  ///
  /// - Parameters:
  ///   - lhs: An array to compare.
  ///   - rhs: Another array to compare.
  @inlinable
  public static func ==(lhs: ContiguousArray<Element>, rhs: ContiguousArray<Element>) -> Bool {
    let lhsCount = lhs.count
    if lhsCount != rhs.count {
      return false
    }

    // Test referential equality.
    if lhsCount == 0 || lhs._buffer.identity == rhs._buffer.identity {
      return true
    }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 2235)

    _sanityCheck(lhs.startIndex == 0 && rhs.startIndex == 0)
    _sanityCheck(lhs.endIndex == lhsCount && rhs.endIndex == lhsCount)

    // We know that lhs.count == rhs.count, compare element wise.
    for idx in 0..<lhsCount {
      if lhs[idx] != rhs[idx] {
        return false
      }
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 2246)

    return true
  }

  /// Returns a Boolean value indicating whether two arrays are not equal.
  ///
  /// Two arrays are equal if they contain the same elements in the same order.
  /// You can use the not-equal-to operator (`!=`) to compare any two arrays
  /// that store the same, `Equatable`-conforming element type.
  ///
  /// - Parameters:
  ///   - lhs: An array to compare.
  ///   - rhs: Another array to compare.
  @inlinable
  public static func !=(lhs: ContiguousArray<Element>, rhs: ContiguousArray<Element>) -> Bool {
    return !(lhs == rhs)
  }
}

extension ContiguousArray: Hashable where Element: Hashable {
  @inlinable // FIXME(sil-serialize-all)
  public func hash(into hasher: inout Hasher) {
    hasher.combine(count) // discriminator
    for element in self {
      hasher.combine(element)
    }
  }

  @inlinable // FIXME(sil-serialize-all)
  public func _rawHashValue(seed: (UInt64, UInt64)) -> Int {
    var hasher = Hasher(_seed: seed)
    // Note that we don't need to use delimiters/discriminators for top-level
    // hashing.
    for element in self {
      hasher.combine(element)
    }
    return hasher._finalize()
  }
}

extension ContiguousArray {
  /// Calls the given closure with a pointer to the underlying bytes of the
  /// array's mutable contiguous storage.
  ///
  /// The array's `Element` type must be a *trivial type*, which can be copied
  /// with just a bit-for-bit copy without any indirection or
  /// reference-counting operations. Generally, native Swift types that do not
  /// contain strong or weak references are trivial, as are imported C structs
  /// and enums.
  ///
  /// The following example copies bytes from the `byteValues` array into
  /// `numbers`, an array of `Int`:
  ///
  ///     var numbers: [Int32] = [0, 0]
  ///     var byteValues: [UInt8] = [0x01, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00]
  ///
  ///     numbers.withUnsafeMutableBytes { destBytes in
  ///         byteValues.withUnsafeBytes { srcBytes in
  ///             destBytes.copyBytes(from: srcBytes)
  ///         }
  ///     }
  ///     // numbers == [1, 2]
  ///
  /// The pointer passed as an argument to `body` is valid only for the
  /// lifetime of the closure. Do not escape it from the closure for later
  /// use.
  ///
  /// - Warning: Do not rely on anything about the array that is the target of
  ///   this method during execution of the `body` closure; it might not
  ///   appear to have its correct value. Instead, use only the
  ///   `UnsafeMutableRawBufferPointer` argument to `body`.
  ///
  /// - Parameter body: A closure with an `UnsafeMutableRawBufferPointer`
  ///   parameter that points to the contiguous storage for the array.
  ///    If no such storage exists, it is created. If `body` has a return value, that value is also
  ///   used as the return value for the `withUnsafeMutableBytes(_:)` method.
  ///   The argument is valid only for the duration of the closure's
  ///   execution.
  /// - Returns: The return value, if any, of the `body` closure parameter.
  @inlinable
  public mutating func withUnsafeMutableBytes<R>(
    _ body: (UnsafeMutableRawBufferPointer) throws -> R
  ) rethrows -> R {
    return try self.withUnsafeMutableBufferPointer {
      return try body(UnsafeMutableRawBufferPointer($0))
    }
  }

  /// Calls the given closure with a pointer to the underlying bytes of the
  /// array's contiguous storage.
  ///
  /// The array's `Element` type must be a *trivial type*, which can be copied
  /// with just a bit-for-bit copy without any indirection or
  /// reference-counting operations. Generally, native Swift types that do not
  /// contain strong or weak references are trivial, as are imported C structs
  /// and enums.
  ///
  /// The following example copies the bytes of the `numbers` array into a
  /// buffer of `UInt8`:
  ///
  ///     var numbers = [1, 2, 3]
  ///     var byteBuffer: [UInt8] = []
  ///     numbers.withUnsafeBytes {
  ///         byteBuffer.append(contentsOf: $0)
  ///     }
  ///     // byteBuffer == [1, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, ...]
  ///
  /// - Parameter body: A closure with an `UnsafeRawBufferPointer` parameter
  ///   that points to the contiguous storage for the array.
  ///    If no such storage exists, it is created. If `body` has a return value, that value is also
  ///   used as the return value for the `withUnsafeBytes(_:)` method. The
  ///   argument is valid only for the duration of the closure's execution.
  /// - Returns: The return value, if any, of the `body` closure parameter.
  @inlinable
  public func withUnsafeBytes<R>(
    _ body: (UnsafeRawBufferPointer) throws -> R
  ) rethrows -> R {
    return try self.withUnsafeBufferPointer {
      try body(UnsafeRawBufferPointer($0))
    }
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 2197)

extension ArraySlice : Equatable where Element : Equatable {
  /// Returns a Boolean value indicating whether two arrays contain the same
  /// elements in the same order.
  ///
  /// You can use the equal-to operator (`==`) to compare any two arrays
  /// that store the same, `Equatable`-conforming element type.
  ///
  /// - Parameters:
  ///   - lhs: An array to compare.
  ///   - rhs: Another array to compare.
  @inlinable
  public static func ==(lhs: ArraySlice<Element>, rhs: ArraySlice<Element>) -> Bool {
    let lhsCount = lhs.count
    if lhsCount != rhs.count {
      return false
    }

    // Test referential equality.
    if lhsCount == 0 || lhs._buffer.identity == rhs._buffer.identity {
      return true
    }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 2221)

    var streamLHS = lhs.makeIterator()
    var streamRHS = rhs.makeIterator()

    var nextLHS = streamLHS.next()
    while nextLHS != nil {
      let nextRHS = streamRHS.next()
      if nextLHS != nextRHS {
        return false
      }
      nextLHS = streamLHS.next()
    }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 2246)

    return true
  }

  /// Returns a Boolean value indicating whether two arrays are not equal.
  ///
  /// Two arrays are equal if they contain the same elements in the same order.
  /// You can use the not-equal-to operator (`!=`) to compare any two arrays
  /// that store the same, `Equatable`-conforming element type.
  ///
  /// - Parameters:
  ///   - lhs: An array to compare.
  ///   - rhs: Another array to compare.
  @inlinable
  public static func !=(lhs: ArraySlice<Element>, rhs: ArraySlice<Element>) -> Bool {
    return !(lhs == rhs)
  }
}

extension ArraySlice: Hashable where Element: Hashable {
  @inlinable // FIXME(sil-serialize-all)
  public func hash(into hasher: inout Hasher) {
    hasher.combine(count) // discriminator
    for element in self {
      hasher.combine(element)
    }
  }

  @inlinable // FIXME(sil-serialize-all)
  public func _rawHashValue(seed: (UInt64, UInt64)) -> Int {
    var hasher = Hasher(_seed: seed)
    // Note that we don't need to use delimiters/discriminators for top-level
    // hashing.
    for element in self {
      hasher.combine(element)
    }
    return hasher._finalize()
  }
}

extension ArraySlice {
  /// Calls the given closure with a pointer to the underlying bytes of the
  /// array's mutable contiguous storage.
  ///
  /// The array's `Element` type must be a *trivial type*, which can be copied
  /// with just a bit-for-bit copy without any indirection or
  /// reference-counting operations. Generally, native Swift types that do not
  /// contain strong or weak references are trivial, as are imported C structs
  /// and enums.
  ///
  /// The following example copies bytes from the `byteValues` array into
  /// `numbers`, an array of `Int`:
  ///
  ///     var numbers: [Int32] = [0, 0]
  ///     var byteValues: [UInt8] = [0x01, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00]
  ///
  ///     numbers.withUnsafeMutableBytes { destBytes in
  ///         byteValues.withUnsafeBytes { srcBytes in
  ///             destBytes.copyBytes(from: srcBytes)
  ///         }
  ///     }
  ///     // numbers == [1, 2]
  ///
  /// The pointer passed as an argument to `body` is valid only for the
  /// lifetime of the closure. Do not escape it from the closure for later
  /// use.
  ///
  /// - Warning: Do not rely on anything about the array that is the target of
  ///   this method during execution of the `body` closure; it might not
  ///   appear to have its correct value. Instead, use only the
  ///   `UnsafeMutableRawBufferPointer` argument to `body`.
  ///
  /// - Parameter body: A closure with an `UnsafeMutableRawBufferPointer`
  ///   parameter that points to the contiguous storage for the array.
  ///    If no such storage exists, it is created. If `body` has a return value, that value is also
  ///   used as the return value for the `withUnsafeMutableBytes(_:)` method.
  ///   The argument is valid only for the duration of the closure's
  ///   execution.
  /// - Returns: The return value, if any, of the `body` closure parameter.
  @inlinable
  public mutating func withUnsafeMutableBytes<R>(
    _ body: (UnsafeMutableRawBufferPointer) throws -> R
  ) rethrows -> R {
    return try self.withUnsafeMutableBufferPointer {
      return try body(UnsafeMutableRawBufferPointer($0))
    }
  }

  /// Calls the given closure with a pointer to the underlying bytes of the
  /// array's contiguous storage.
  ///
  /// The array's `Element` type must be a *trivial type*, which can be copied
  /// with just a bit-for-bit copy without any indirection or
  /// reference-counting operations. Generally, native Swift types that do not
  /// contain strong or weak references are trivial, as are imported C structs
  /// and enums.
  ///
  /// The following example copies the bytes of the `numbers` array into a
  /// buffer of `UInt8`:
  ///
  ///     var numbers = [1, 2, 3]
  ///     var byteBuffer: [UInt8] = []
  ///     numbers.withUnsafeBytes {
  ///         byteBuffer.append(contentsOf: $0)
  ///     }
  ///     // byteBuffer == [1, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, ...]
  ///
  /// - Parameter body: A closure with an `UnsafeRawBufferPointer` parameter
  ///   that points to the contiguous storage for the array.
  ///    If no such storage exists, it is created. If `body` has a return value, that value is also
  ///   used as the return value for the `withUnsafeBytes(_:)` method. The
  ///   argument is valid only for the duration of the closure's execution.
  /// - Returns: The return value, if any, of the `body` closure parameter.
  @inlinable
  public func withUnsafeBytes<R>(
    _ body: (UnsafeRawBufferPointer) throws -> R
  ) rethrows -> R {
    return try self.withUnsafeBufferPointer {
      try body(UnsafeRawBufferPointer($0))
    }
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 2197)

extension Array : Equatable where Element : Equatable {
  /// Returns a Boolean value indicating whether two arrays contain the same
  /// elements in the same order.
  ///
  /// You can use the equal-to operator (`==`) to compare any two arrays
  /// that store the same, `Equatable`-conforming element type.
  ///
  /// - Parameters:
  ///   - lhs: An array to compare.
  ///   - rhs: Another array to compare.
  @inlinable
  public static func ==(lhs: Array<Element>, rhs: Array<Element>) -> Bool {
    let lhsCount = lhs.count
    if lhsCount != rhs.count {
      return false
    }

    // Test referential equality.
    if lhsCount == 0 || lhs._buffer.identity == rhs._buffer.identity {
      return true
    }

// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 2235)

    _sanityCheck(lhs.startIndex == 0 && rhs.startIndex == 0)
    _sanityCheck(lhs.endIndex == lhsCount && rhs.endIndex == lhsCount)

    // We know that lhs.count == rhs.count, compare element wise.
    for idx in 0..<lhsCount {
      if lhs[idx] != rhs[idx] {
        return false
      }
    }
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 2246)

    return true
  }

  /// Returns a Boolean value indicating whether two arrays are not equal.
  ///
  /// Two arrays are equal if they contain the same elements in the same order.
  /// You can use the not-equal-to operator (`!=`) to compare any two arrays
  /// that store the same, `Equatable`-conforming element type.
  ///
  /// - Parameters:
  ///   - lhs: An array to compare.
  ///   - rhs: Another array to compare.
  @inlinable
  public static func !=(lhs: Array<Element>, rhs: Array<Element>) -> Bool {
    return !(lhs == rhs)
  }
}

extension Array: Hashable where Element: Hashable {
  @inlinable // FIXME(sil-serialize-all)
  public func hash(into hasher: inout Hasher) {
    hasher.combine(count) // discriminator
    for element in self {
      hasher.combine(element)
    }
  }

  @inlinable // FIXME(sil-serialize-all)
  public func _rawHashValue(seed: (UInt64, UInt64)) -> Int {
    var hasher = Hasher(_seed: seed)
    // Note that we don't need to use delimiters/discriminators for top-level
    // hashing.
    for element in self {
      hasher.combine(element)
    }
    return hasher._finalize()
  }
}

extension Array {
  /// Calls the given closure with a pointer to the underlying bytes of the
  /// array's mutable contiguous storage.
  ///
  /// The array's `Element` type must be a *trivial type*, which can be copied
  /// with just a bit-for-bit copy without any indirection or
  /// reference-counting operations. Generally, native Swift types that do not
  /// contain strong or weak references are trivial, as are imported C structs
  /// and enums.
  ///
  /// The following example copies bytes from the `byteValues` array into
  /// `numbers`, an array of `Int`:
  ///
  ///     var numbers: [Int32] = [0, 0]
  ///     var byteValues: [UInt8] = [0x01, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00]
  ///
  ///     numbers.withUnsafeMutableBytes { destBytes in
  ///         byteValues.withUnsafeBytes { srcBytes in
  ///             destBytes.copyBytes(from: srcBytes)
  ///         }
  ///     }
  ///     // numbers == [1, 2]
  ///
  /// The pointer passed as an argument to `body` is valid only for the
  /// lifetime of the closure. Do not escape it from the closure for later
  /// use.
  ///
  /// - Warning: Do not rely on anything about the array that is the target of
  ///   this method during execution of the `body` closure; it might not
  ///   appear to have its correct value. Instead, use only the
  ///   `UnsafeMutableRawBufferPointer` argument to `body`.
  ///
  /// - Parameter body: A closure with an `UnsafeMutableRawBufferPointer`
  ///   parameter that points to the contiguous storage for the array.
  ///    If no such storage exists, it is created. If `body` has a return value, that value is also
  ///   used as the return value for the `withUnsafeMutableBytes(_:)` method.
  ///   The argument is valid only for the duration of the closure's
  ///   execution.
  /// - Returns: The return value, if any, of the `body` closure parameter.
  @inlinable
  public mutating func withUnsafeMutableBytes<R>(
    _ body: (UnsafeMutableRawBufferPointer) throws -> R
  ) rethrows -> R {
    return try self.withUnsafeMutableBufferPointer {
      return try body(UnsafeMutableRawBufferPointer($0))
    }
  }

  /// Calls the given closure with a pointer to the underlying bytes of the
  /// array's contiguous storage.
  ///
  /// The array's `Element` type must be a *trivial type*, which can be copied
  /// with just a bit-for-bit copy without any indirection or
  /// reference-counting operations. Generally, native Swift types that do not
  /// contain strong or weak references are trivial, as are imported C structs
  /// and enums.
  ///
  /// The following example copies the bytes of the `numbers` array into a
  /// buffer of `UInt8`:
  ///
  ///     var numbers = [1, 2, 3]
  ///     var byteBuffer: [UInt8] = []
  ///     numbers.withUnsafeBytes {
  ///         byteBuffer.append(contentsOf: $0)
  ///     }
  ///     // byteBuffer == [1, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, ...]
  ///
  /// - Parameter body: A closure with an `UnsafeRawBufferPointer` parameter
  ///   that points to the contiguous storage for the array.
  ///    If no such storage exists, it is created. If `body` has a return value, that value is also
  ///   used as the return value for the `withUnsafeBytes(_:)` method. The
  ///   argument is valid only for the duration of the closure's execution.
  /// - Returns: The return value, if any, of the `body` closure parameter.
  @inlinable
  public func withUnsafeBytes<R>(
    _ body: (UnsafeRawBufferPointer) throws -> R
  ) rethrows -> R {
    return try self.withUnsafeBufferPointer {
      try body(UnsafeRawBufferPointer($0))
    }
  }
}
// ###sourceLocation(file: "/Users/user/Documents/study/swift/swift/stdlib/public/core/Arrays.swift.gyb", line: 2369)

#if _runtime(_ObjC)
// We isolate the bridging of the Cocoa Array -> Swift Array here so that
// in the future, we can eagerly bridge the Cocoa array. We need this function
// to do the bridging in an ABI safe way. Even though this looks useless,
// DO NOT DELETE!
@usableFromInline internal
func _bridgeCocoaArray<T>(_ _immutableCocoaArray: _NSArrayCore) -> Array<T> {
  return Array(_buffer: _ArrayBuffer(nsArray: _immutableCocoaArray))
}

extension Array {
  @inlinable
  public // @SPI(Foundation)
  func _bridgeToObjectiveCImpl() -> AnyObject {
    return _buffer._asCocoaArray()
  }

  /// Tries to downcast the source `NSArray` as our native buffer type.
  /// If it succeeds, creates a new `Array` around it and returns that.
  /// Returns `nil` otherwise.
  // Note: this function exists here so that Foundation doesn't have
  // to know Array's implementation details.
  @inlinable
  public static func _bridgeFromObjectiveCAdoptingNativeStorageOf(
    _ source: AnyObject
  ) -> Array? {
    // If source is deferred, we indirect to get its native storage
    let maybeNative = (source as? _SwiftDeferredNSArray)?._nativeStorage ?? source

    return (maybeNative as? _ContiguousArrayStorage<Element>).map {
      Array(_ContiguousArrayBuffer($0))
    }
  }

  /// Private initializer used for bridging.
  ///
  /// Only use this initializer when both conditions are true:
  ///
  /// * it is statically known that the given `NSArray` is immutable;
  /// * `Element` is bridged verbatim to Objective-C (i.e.,
  ///   is a reference type).
  @inlinable
  public init(_immutableCocoaArray: _NSArrayCore) {
    self = _bridgeCocoaArray(_immutableCocoaArray)
  }
}
#endif

extension ArraySlice {
  @inlinable
  public // @testable
  init(_startIndex: Int) {
    self.init(
      _buffer: _Buffer(
        _buffer: ContiguousArray()._buffer,
        shiftedToStartIndex: _startIndex))
  }
}

// Local Variables:
// eval: (read-only-mode 1)
// End:
