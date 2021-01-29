//
//  ArrayVia.swift
//  
//
//  Created by David Sweeris on 2/28/20.
//

import Foundation

public protocol ArrayVia: ArrayType {
    static var collectionVia: WritableKeyPath<Self, CollectionType> { get }
}

extension ArrayVia {
    /// The position of the first element in a nonempty array.
    ///
    /// For an instance of `Array`, `startIndex` is always zero. If the array
    /// is empty, `startIndex` is equal to `endIndex`.
    @inlinable
    var startIndex: Int {
        self[keyPath: Self.collectionVia].startIndex
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
    @inlinable
    var endIndex: Int {
        self[keyPath: Self.collectionVia].endIndex
    }

    /// Returns the position immediately after the given index.
    ///
    /// - Parameter i: A valid index of the collection. `i` must be less than
    ///   `endIndex`.
    /// - Returns: The index immediately after `i`.
    @inlinable
    func index(after i: Int) -> Int {
        self[keyPath: Self.collectionVia].index(after: i)
    }

    @inlinable
    var indices: Range<Int> {
        self[keyPath: Self.collectionVia].indices
    }
    /// Replaces the given index with its successor.
    ///
    /// - Parameter i: A valid index of the collection. `i` must be less than
    ///   `endIndex`.
    @inlinable
    func formIndex(after i: inout Int) {
        self[keyPath: Self.collectionVia].formIndex(after: &i)
    }

    /// Returns the position immediately before the given index.
    ///
    /// - Parameter i: A valid index of the collection. `i` must be greater than
    ///   `startIndex`.
    /// - Returns: The index immediately before `i`.
    @inlinable
    func index(before i: Int) -> Int {
        self[keyPath: Self.collectionVia].index(before: i)
    }

    /// Replaces the given index with its predecessor.
    ///
    /// - Parameter i: A valid index of the collection. `i` must be greater than
    ///   `startIndex`.
    @inlinable
    func formIndex(before i: inout Int) {
        self[keyPath: Self.collectionVia].formIndex(before: &i)
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
    /// The value passed as `distance` must not offset `i` beyond the bounds of
    /// the collection.
    ///
    /// - Parameters:
    ///   - i: A valid index of the array.
    ///   - distance: The distance to offset `i`.
    /// - Returns: An index offset by `distance` from the index `i`. If
    ///   `distance` is positive, this is the same value as the result of
    ///   `distance` calls to `index(after:)`. If `distance` is negative, this
    ///   is the same value as the result of `abs(distance)` calls to
    ///   `index(before:)`.
    @inlinable
    func index(_ i: Int, offsetBy distance: Int) -> Int {
        self[keyPath: Self.collectionVia].index(i, offsetBy: distance)
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
    /// The value passed as `distance` must not offset `i` beyond the bounds of
    /// the collection, unless the index passed as `limit` prevents offsetting
    /// beyond those bounds.
    ///
    /// - Parameters:
    ///   - i: A valid index of the array.
    ///   - distance: The distance to offset `i`.
    ///   - limit: A valid index of the collection to use as a limit. If
    ///     `distance > 0`, `limit` has no effect if it is less than `i`.
    ///     Likewise, if `distance < 0`, `limit` has no effect if it is greater
    ///     than `i`.
    /// - Returns: An index offset by `distance` from the index `i`, unless that
    ///   index would be beyond `limit` in the direction of movement. In that
    ///   case, the method returns `nil`.
    ///
    /// - Complexity: O(1)
    @inlinable
    func index(
      _ i: Int, offsetBy distance: Int, limitedBy limit: Int
    ) -> Int? {
        self[keyPath: Self.collectionVia].index(i, offsetBy: distance, limitedBy: limit)
    }

    /// Returns the distance between two indices.
    ///
    /// - Parameters:
    ///   - start: A valid index of the collection.
    ///   - end: Another valid index of the collection. If `end` is equal to
    ///     `start`, the result is zero.
    /// - Returns: The distance between `start` and `end`.
    @inlinable
    func distance(from start: Int, to end: Int) -> Int {
        self[keyPath: Self.collectionVia].distance(from: start, to: end)
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
    ///   unless the array's storage is shared with another array or uses a
    ///   bridged `NSArray` instance as its storage, in which case writing is
    ///   O(*n*), where *n* is the length of the array.
    @inlinable
    subscript(index: Int) -> CollectionType.Element {
      get { return self[keyPath: Self.collectionVia][index] }
      set { self[keyPath: Self.collectionVia][index] = newValue }
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
    subscript(bounds: Range<Int>) -> ArraySlice<CollectionType.Element> {
      get { self[keyPath: Self.collectionVia][bounds] }
      set { self[keyPath: Self.collectionVia][bounds] = newValue }
    }
    @inlinable
    subscript(bounds: Range<Int>) -> Slice<Array<CollectionType.Element>> {
        get { self[keyPath: Self.collectionVia][bounds] }
        set { self[keyPath: Self.collectionVia][bounds] = newValue }
    }
    /// The number of elements in the array.
    @inlinable
    var count: Int {
        self[keyPath: Self.collectionVia].count
    }

    
    @inlinable
    var capacity: Int { self[keyPath: Self.collectionVia].capacity }

    mutating func append(_ newElement: CollectionType.Element) { self[keyPath: Self.collectionVia].append(newElement) }
    mutating func insert(_ newElement: CollectionType.Element, at i: Int) { self[keyPath: Self.collectionVia].insert(newElement, at: i) }
    mutating func insert<C>(contentsOf newElements: C, at i: Int) where C : Collection, CollectionType.Element == C.Element {
        self[keyPath: Self.collectionVia].insert(contentsOf: newElements, at: i)
    }
    mutating func replaceSubrange<C>(_ subrange: Range<Int>, with newElements: C) where C : Collection, CollectionType.Element == C.Element {
        self[keyPath: Self.collectionVia].replaceSubrange(subrange, with: newElements)
    }
    mutating func replaceSubrange<C, R>(_ subrange: R, with newElements: C) where C : Collection, R : RangeExpression, CollectionType.Element == C.Element, R.Bound == Range<Int>.Element {
        self[keyPath: Self.collectionVia].replaceSubrange(subrange, with: newElements)
    }

    mutating func reserveCapacity(_ minimumCapacity: Int) {
        self[keyPath: Self.collectionVia].reserveCapacity(minimumCapacity)
    }
    
    mutating func append<S>(contentsOf newElements: S) where S : Sequence, CollectionType.Element == S.Element {
        self[keyPath: Self.collectionVia].append(contentsOf: newElements)
    }
    
    mutating func remove(at index: Int) -> CollectionType.Element {
        self[keyPath: Self.collectionVia].remove(at: index)
    }
    
    mutating func removeFirst() -> CollectionType.Element {
        self[keyPath: Self.collectionVia].removeFirst()
    }
    
    mutating func removeFirst(_ k: Int) {
        self[keyPath: Self.collectionVia].removeFirst(k)
    }
    
    mutating func removeLast() -> CollectionType.Element {
        self[keyPath: Self.collectionVia].removeLast()
    }
    
    mutating func removeLast(_ k: Int) {
        self[keyPath: Self.collectionVia].removeLast(k)
    }
    
    mutating func removeSubrange(_ bounds: Range<Int>) {
        self[keyPath: Self.collectionVia].removeSubrange(bounds)
    }
    
    mutating func removeSubrange<R>(_ bounds: R) where R : RangeExpression, R.Bound == Range<Int>.Element {
        self[keyPath: Self.collectionVia].removeSubrange(bounds)
    }

    mutating func removeAll(where shouldBeRemoved: (CollectionType.Element) throws -> Bool) rethrows {
        try self[keyPath: Self.collectionVia].removeAll(where: shouldBeRemoved)
    }
    
    mutating func removeAll(keepingCapacity keepCapacity: Bool) {
        self[keyPath: Self.collectionVia].removeAll(keepingCapacity: keepCapacity)
    }
    
    mutating func popLast() -> CollectionType.Element? {
        self[keyPath: Self.collectionVia].popLast()
    }
    
    func makeIterator() -> IndexingIterator<Array<CollectionType.Element>> {
        self[keyPath: Self.collectionVia].makeIterator()
    }
    
    @available(OSX 10.15, *)
    func applying(_ difference: CollectionDifference<CollectionType.Element>) -> Array<CollectionType.Element>? {
        self[keyPath: Self.collectionVia].applying(difference)
    }
    
    func withUnsafeBufferPointer<R>(_ body: (UnsafeBufferPointer<CollectionType.Element>) throws -> R) rethrows -> R {
        try self[keyPath: Self.collectionVia].withUnsafeBufferPointer(body)
    }
    
    mutating func withUnsafeMutableBufferPointer<R>(_ body: (inout UnsafeMutableBufferPointer<CollectionType.Element>) throws -> R) rethrows -> R {
        try self[keyPath: Self.collectionVia].withUnsafeMutableBufferPointer(body)
    }
    
    func withUnsafeBytes<R>(_ body: (UnsafeRawBufferPointer) throws -> R) rethrows -> R {
        try self[keyPath: Self.collectionVia].withUnsafeBytes(body)
    }
    
    mutating func withUnsafeMutableBytes<R>(_ body: (UnsafeMutableRawBufferPointer) throws -> R) rethrows -> R {
        try self[keyPath: Self.collectionVia].withUnsafeMutableBytes(body)
    }
    
}


extension ArrayVia where Element: Equatable {






//    var self[keyPath: Self.collectionVia]: [Element] {
//        get { self[keyPath: Self.collectionVia].self[keyPath: Self.collectionVia] }
//        set { self[keyPath: Self.collectionVia].self[keyPath: Self.collectionVia] = newValue }
//    }
//
    @inlinable func makeIterator() -> IndexingIterator<Array<CollectionType.Element>> {
        self[keyPath: Self.collectionVia].makeIterator()
    }
}

extension ArrayVia {
    mutating func sort(by areInIncreasingOrder: (CollectionType.Element, CollectionType.Element) throws -> Bool) rethrows {
        try self[keyPath: Self.collectionVia].sort(by: areInIncreasingOrder)
    }
}

extension ArrayVia {
}

//struct Test: ArrayVia {
//    static var collectionVia: WritableKeyPath<Test, [Int]> = \Test.data
//    var data: [Int]
//}


extension ArrayVia where CollectionType.Element: Equatable, CollectionType: Equatable, CollectionType.Element == Element {
    /// Returns a Boolean value indicating whether the sequence contains the given element.
    @inlinable
    func contains(_ element: CollectionType.Element) -> Bool {
        self[keyPath: Self.collectionVia].contains(element)
    }
    /// Returns a Boolean value indicating whether two arrays contain the same elements in the same order.
    /// Available when Element conforms to Equatable.
    @inlinable
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs[keyPath: collectionVia] == rhs[keyPath: collectionVia]
    }
    /// Returns a Boolean value indicating whether two values are not equal.
    /// Available when Element conforms to Equatable.
    @inlinable
    static func != (lhs: Self, rhs: Self) -> Bool {
        lhs[keyPath: collectionVia] != rhs[keyPath: collectionVia]
    }
    /// Returns a Boolean value indicating whether this sequence and another sequence contain the same elements in the same order.
    /// Available when Element conforms to Equatable.
    @inlinable
    func elementsEqual<OtherSequence>(_ other: OtherSequence) -> Bool where OtherSequence : Sequence, Self.Element == OtherSequence.Element {
        self[keyPath: Self.collectionVia].elementsEqual(other)
    }
    /// Returns the first index where the specified value appears in the collection.
    /// Available when Element conforms to Equatable.
    @inlinable
    func firstIndex(of element: Element) -> Int? {
        self[keyPath: Self.collectionVia].firstIndex(of: element)
    }
    /// Returns the last index where the specified value appears in the collection.
    /// Available when Element conforms to Equatable.
    @inlinable
    func lastIndex(of element: Element) -> Int? {
        self[keyPath: Self.collectionVia].lastIndex(of: element)
    }
    /// Returns the longest possible subsequences of the collection, in order, around elements equal to the given element.
    /// Available when Element conforms to Equatable.
    @inlinable
    func split(separator: Element, maxSplits: Int = Int.max, omittingEmptySubsequences: Bool = true) -> [ArraySlice<Element>] {
        self[keyPath: Self.collectionVia].split(separator: separator, maxSplits: maxSplits, omittingEmptySubsequences: omittingEmptySubsequences)
    }
    /// Returns the difference needed to produce this collection’s ordered elements from the given collection.
    /// Available when Element conforms to Equatable.
    @available(OSX 10.15, *)
    @inlinable
    func difference<C>(from other: C) -> CollectionDifference<Element> where C : BidirectionalCollection, Self.Element == C.Element {
        self[keyPath: Self.collectionVia].difference(from: other)
    }
    /// Returns a Boolean value indicating whether the initial elements of the sequence are the same as the elements in another sequence.
    /// Available when Element conforms to Equatable.
    @inlinable
    func starts<PossiblePrefix>(with possiblePrefix: PossiblePrefix) -> Bool where PossiblePrefix : Sequence, Self.Element == PossiblePrefix.Element {
        self[keyPath: Self.collectionVia].starts(with: possiblePrefix)
    }
}
