//
//  TypeProtocols.swift
//
//
//  Created by David Sweeris on 2/28/20.
//

import Swift

public protocol ArrayType: RandomAccessCollection, MutableCollection where CollectionType.Element == Element, CollectionType.Index == Int, CollectionType.SubSequence == SubSequence, CollectionType.Indices == Range<Int>
{
    associatedtype CollectionType: ArrayType
//    typealias Element = CollectionType.Element
//    typealias Index = CollectionType.Index
//    typealias SubSequence = CollectionType.SubSequence
//    
//    typealias Indices = Range<Int>

//    // Just a way to get an honest array.
//    @inlinable
//    var _asArray: [Element] {get set}
    
    // Most of the tool tip stuff was copied from Apple's docs
    
    // Inspecting an Array
    /// A Boolean value indicating whether the collection is empty.
    @inlinable
    var isEmpty: Bool {get}
    /// The number of elements in the array.
    @inlinable
    var count: Int {get}
    /// The total number of elements that the array can contain without allocating new storage.
    @inlinable
    var capacity: Int {get}
    
    // Accessing Elements
    /// Accesses the element at the specified position.
    // Apparently this is provided by some up-stream protocol
//        subscript(index: Int) -> Element { get set }
    /// The first element of the collection.
    @inlinable
    var first: Element? {get}
    /// The last element of the collection.
    @inlinable
    var last: Element? {get}
    /// Accesses a contiguous subrange of the array’s elements.
    @inlinable
    subscript(bounds: Range<Int>) -> ArraySlice<Element> { get set }
    /// Accesses a contiguous subrange of the collection’s elements.
    @inlinable
    subscript(bounds: Range<Int>) -> Slice<Array<Element>> { get set }
    /// Accesses the contiguous subrange of the collection’s elements specified by a range expression.
    @inlinable
    subscript<R>(r: R) -> ArraySlice<Element> where R : RangeExpression, Self.Index == R.Bound { get set }
//    @inlinable
//    subscript(x: (UnboundedRange_) -> ()) -> ArraySlice<Element> { get set }
    /// Returns a random element of the collection.
    @inlinable
    func randomElement() -> Element?
    /// Returns a random element of the collection, using the given generator as a source for randomness.
    @inlinable
    func randomElement<T>(using generator: inout T) -> Element? where T : RandomNumberGenerator
    
    // Adding Elements
    /// Adds a new element at the end of the array.
    @inlinable
    mutating func append(_ newElement: Element)
    /// Inserts a new element at the specified position.
    @inlinable
    mutating func insert(_ newElement: Element, at i: Int)
    /// Inserts the elements of a sequence into the collection at the specified position.
    @inlinable
    mutating func insert<C>(contentsOf newElements: C, at i: Int) where C : Collection, Self.Element == C.Element
    /// Replaces a range of elements with the elements in the specified collection.
    @inlinable
    mutating func replaceSubrange<C>(_ subrange: Range<Int>, with newElements: C) where Element == C.Element, C : Collection
    /// Replaces the specified subrange of elements with the given collection.
    @inlinable
    mutating func replaceSubrange<C, R>(_ subrange: R, with newElements: C) where C : Collection, R : RangeExpression, Self.Element == C.Element, Self.Index == R.Bound
    /// Reserves enough space to store the specified number of elements.
    @inlinable
    mutating func reserveCapacity(_ minimumCapacity: Int)
    
    // Combining Arrays
    /// Adds the elements of a sequence or collection to the end of this collection.
    @inlinable
    mutating func append<S>(contentsOf newElements: S) where S : Sequence, Self.Element == S.Element
//    /// Creates a new collection by concatenating the elements of a sequence and a collection.
//    @inlinable
//    static func + <Other>(lhs: Other, rhs: Self) -> Self where Other : Sequence, Self.Element == Other.Element
//    /// Creates a new collection by concatenating the elements of a collection and a sequence.
//    @inlinable
//    static func + <Other>(lhs: Self, rhs: Other) -> Self where Other : Sequence, Self.Element == Other.Element
//    /// Creates a new collection by concatenating the elements of a collection and a sequence.
//    @inlinable
//    static func + (lhs: Self, rhs: Self) -> Self
//    /// Creates a new collection by concatenating the elements of two collections.
//    @inlinable
//    static func + <Other>(lhs: Self, rhs: Other) -> Self where Other : RangeReplaceableCollection, Self.Element == Other.Element
    /// Appends the elements of a sequence to a range-replaceable collection.
    @inlinable
    static func += <Other>(lhs: inout Self, rhs: Other) where Other : Sequence, Self.Element == Other.Element
    @inlinable
    static func += (lhs: inout Self, rhs: Self)
    
    // Removing Elements
    /// Removes and returns the element at the specified position.
    @inlinable
    @discardableResult mutating func remove(at index: Int) -> Element
    /// Removes and returns the first element of the collection.
    @inlinable
    @discardableResult mutating func removeFirst() -> Element
    /// Removes the specified number of elements from the beginning of the collection.
    @inlinable
    mutating func removeFirst(_ k: Int)
    /// Removes and returns the last element of the collection.
    @inlinable
    @discardableResult mutating func removeLast() -> Element
    /// Removes the specified number of elements from the end of the collection.
    @inlinable
    mutating func removeLast(_ k: Int)
    /// Removes the elements in the specified subrange from the collection.
    @inlinable
    mutating func removeSubrange(_ bounds: Range<Int>)
    /// Removes the elements in the specified subrange from the collection.
    @inlinable
    mutating func removeSubrange<R>(_ bounds: R) where R : RangeExpression, Self.Index == R.Bound
    /// Removes all the elements that satisfy the given predicate.
    @inlinable
    mutating func removeAll(where shouldBeRemoved: (Element) throws -> Bool) rethrows
    /// Removes all elements from the array. Should be "keepCapacity: Bool = false"
    @inlinable
    mutating func removeAll(keepingCapacity keepCapacity: Bool)
    /// Removes and returns the last element of the collection.
    @inlinable
    mutating func popLast() -> Element?
    
    // Finding Elements
    /// Returns a Boolean value indicating whether the sequence contains an element that satisfies the given predicate.
    @inlinable
    func contains(where predicate: (Element) throws -> Bool) rethrows -> Bool
    /// Returns a Boolean value indicating whether every element of a sequence satisfies a given predicate.
    @inlinable
    func allSatisfy(_ predicate: (Element) throws -> Bool) rethrows -> Bool
    /// Returns the first element of the sequence that satisfies the given predicate.
    @inlinable
    func first(where predicate: (Element) throws -> Bool) rethrows -> Element?
    /// Returns the first index in which an element of the collection satisfies the given predicate.
    @inlinable
    func firstIndex(where predicate: (Element) throws -> Bool) rethrows -> Int?
    /// Returns the last element of the sequence that satisfies the given predicate.
    @inlinable
    func last(where predicate: (Element) throws -> Bool) rethrows -> Element?
    /// Returns the index of the last element in the collection that matches the given predicate.
    @inlinable
    func lastIndex(where predicate: (Element) throws -> Bool) rethrows -> Int?
    /// Returns the minimum element in the sequence, using the given predicate as the comparison between elements.
    @warn_unqualified_access func min(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows -> Element?
    /// Returns the maximum element in the sequence, using the given predicate as the comparison between elements.
    @warn_unqualified_access func max(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows -> Element?
    
    // Selecting Elements
    /// Returns a subsequence, up to the specified maximum length, containing the initial elements of the collection.
    @inlinable
    func prefix(_ maxLength: Int) -> ArraySlice<Element>
    /// Returns a subsequence from the start of the collection through the specified position.
    @inlinable
    func prefix(through position: Int) -> ArraySlice<Element>
    /// Returns a subsequence from the start of the collection up to, but not including, the specified position.
    @inlinable
    func prefix(upTo end: Int) -> ArraySlice<Element>
    /// Returns a subsequence containing the initial elements until predicate returns false and skipping the remaining elements.
    @inlinable
    func prefix(while predicate: (Element) throws -> Bool) rethrows -> ArraySlice<Element>
    /// Returns a subsequence, up to the given maximum length, containing the final elements of the collection.
    @inlinable
    func suffix(_ maxLength: Int) -> ArraySlice<Element>
    /// Returns a subsequence from the specified position to the end of the collection.
    @inlinable
    func suffix(from start: Int) -> ArraySlice<Element>
    
    // Excluding Elements
    /// Returns a subsequence containing all but the given number of initial elements. Should be "k: Int = 1"
    @inlinable
    func dropFirst(_ k: Int) -> ArraySlice<Element>
    /// Returns a subsequence containing all but the specified number of final elements.
    @inlinable
    func dropLast(_ k: Int) -> ArraySlice<Element>
    /// Returns a subsequence by skipping elements while predicate returns true and returning the remaining elements.
    @inlinable
    func drop(while predicate: (Element) throws -> Bool) rethrows -> ArraySlice<Element>
    
    // Transforming an Array
    /// Returns an array containing the results of mapping the given closure over the sequence’s elements.
    @inlinable
    func map<T>(_ transform: (Element) throws -> T) rethrows -> [T]
    /// Returns an array containing the concatenated results of calling the given transformation with each element of this sequence.
    @inlinable
    func flatMap<SegmentOfResult>(_ transform: (Element) throws -> SegmentOfResult) rethrows -> [SegmentOfResult.Element] where SegmentOfResult : Sequence
    /// Returns an array containing the non-nil results of calling the given transformation with each element of this sequence.
    @inlinable
    func compactMap<ElementOfResult>(_ transform: (Element) throws -> ElementOfResult?) rethrows -> [ElementOfResult]
    /// Returns the result of combining the elements of the sequence using the given closure.
    @inlinable
    func reduce<Result>(_ initialResult: Result, _ nextPartialResult: (Result, Element) throws -> Result) rethrows -> Result
    /// Returns the result of combining the elements of the sequence using the given closure.
    @inlinable
    func reduce<Result>(into initialResult: Result, _ updateAccumulatingResult: (inout Result, Element) throws -> ()) rethrows -> Result
    /// A sequence containing the same elements as this sequence, but on which some operations, such as map and filter, are implemented lazily.
    @inlinable
    var lazy: LazySequence<Array<Element>> { get }
    
    // Iterating Over an Array's Elements
    /// Calls the given closure on each element in the sequence in the same order as a for-in loop.
    @inlinable
    func forEach(_ body: (Element) throws -> Void) rethrows
    /// Returns a sequence of pairs (n, x), where n represents a consecutive integer starting at zero and x represents an element of the sequence.
    @inlinable
    func enumerated() -> EnumeratedSequence<Array<Element>>
    /// Returns an iterator over the elements of the collection.
    @inlinable
    func makeIterator() -> IndexingIterator<Array<Element>>
    /// A value less than or equal to the number of elements in the collection.
    @inlinable
    var underestimatedCount: Int { get }
    
    // Reordering an Array's Elements
    /// Sorts the collection in place, using the given predicate as the comparison between elements.
    mutating func sort(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows
    /// Reverses the elements of the collection in place.
    mutating func reverse()
    /// Returns a view presenting the elements of the collection in reverse order.
    @inlinable
    func reversed() -> ReversedCollection<Self>
    /// Shuffles the collection in place.
    mutating func shuffle()
    /// Shuffles the collection in place, using the given generator as a source for randomness.
    mutating func shuffle<T>(using generator: inout T) where T : RandomNumberGenerator
    /// Reorders the elements of the collection such that all the elements that match the given predicate are after all the elements that don’t match.
    mutating func partition(by belongsInSecondPartition: (Element) throws -> Bool) rethrows -> Int
    /// Exchanges the values at the specified indices of the collection.
    mutating func swapAt(_ i: Int, _ j: Int)
    
    // Splitting and Joining Elements
    /// Returns the longest possible subsequences of the collection, in order, that don’t contain elements satisfying the given predicate. Should be "maxSplits: Int = Int.max, omittingEmptySubsequences: Bool = true, whereSeparator isSeparator: (Element) throws -> Bool"
    @inlinable
    func split(maxSplits: Int, omittingEmptySubsequences: Bool, whereSeparator isSeparator: (Element) throws -> Bool) rethrows -> [ArraySlice<Element>]
    
    // Creating and Applying Differences
    /// Applies the given difference to this collection.
    @available(OSX 10.15, *)
    @inlinable
    func applying(_ difference: CollectionDifference<Element>) -> Array<Element>?
    
    /// Returns the difference needed to produce this collection’s ordered elements from the given collection, using the given predicate as an equivalence test.
    @available(OSX 10.15, *)
    @inlinable
    func difference<C>(from other: C, by areEquivalent: (C.Element, Element) -> Bool) -> CollectionDifference<Element> where C : BidirectionalCollection, Self.Element == C.Element
    
    // Comparing Arrays
    /// Returns a Boolean value indicating whether this sequence and another sequence contain equivalent elements in the same order, using the given predicate as the equivalence test.
    @inlinable
    func elementsEqual<OtherSequence>(_ other: OtherSequence, by areEquivalent: (Element, OtherSequence.Element) throws -> Bool) rethrows -> Bool where OtherSequence : Sequence
    /// Returns a Boolean value indicating whether the initial elements of the sequence are equivalent to the elements in another sequence, using the given predicate as the equivalence test.
    @inlinable
    func starts<PossiblePrefix>(with possiblePrefix: PossiblePrefix, by areEquivalent: (Element, PossiblePrefix.Element) throws -> Bool) rethrows -> Bool where PossiblePrefix : Sequence
    /// Returns a Boolean value indicating whether the sequence precedes another sequence in a lexicographical (dictionary) ordering, using the given predicate to compare elements.
    @inlinable
    func lexicographicallyPrecedes<OtherSequence>(_ other: OtherSequence, by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows -> Bool where OtherSequence : Sequence, Self.Element == OtherSequence.Element
    
    // Manipulating Indices
    /// The position of the first element in a nonempty array.
    @inlinable
    var startIndex: Int { get }
    /// The array’s “past the end” position—that is, the position one greater than the last valid subscript argument.
    @inlinable
    var endIndex: Int { get }
    /// Returns the position immediately after the given index.
    @inlinable
    func index(after i: Int) -> Int
    /// Replaces the given index with its successor.
    @inlinable
    func formIndex(after i: inout Int)
    /// Returns the position immediately before the given index.
    @inlinable
    func index(before i: Int) -> Int
    /// Replaces the given index with its predecessor.
    @inlinable
    func formIndex(before i: inout Int)
    /// Returns an index that is the specified distance from the given index.
    @inlinable
    func index(_ i: Int, offsetBy distance: Int) -> Int
    /// Offsets the given index by the specified distance.
    @inlinable
    func formIndex(_ i: inout Int, offsetBy distance: Int)
    /// Returns an index that is the specified distance from the given index, unless that distance is beyond a given limiting index.
    @inlinable
    func index(_ i: Int, offsetBy distance: Int, limitedBy limit: Int) -> Int?
    /// Offsets the given index by the specified distance, or so that it equals the given limiting index.
    @inlinable
    func formIndex(_ i: inout Int, offsetBy distance: Int, limitedBy limit: Int) -> Bool
    /// Returns the distance between two indices.
    @inlinable
    func distance(from start: Int, to end: Int) -> Int
    /// The indices that are valid for subscripting the collection, in ascending order.
    @inlinable
    var indices: Range<Int> {get}
    
    // Accessing Underlying Storage
    /// Calls a closure with a pointer to the array’s contiguous storage.
    @inlinable
    func withUnsafeBufferPointer<R>(_ body: (UnsafeBufferPointer<Element>) throws -> R) rethrows -> R
    /// Calls the given closure with a pointer to the array’s mutable contiguous storage.
    mutating func withUnsafeMutableBufferPointer<R>(_ body: (inout UnsafeMutableBufferPointer<Element>) throws -> R) rethrows -> R
    /// Calls the given closure with a pointer to the underlying bytes of the array’s contiguous storage.
    @inlinable
    func withUnsafeBytes<R>(_ body: (UnsafeRawBufferPointer) throws -> R) rethrows -> R
    /// Calls the given closure with a pointer to the underlying bytes of the array’s mutable contiguous storage.
    mutating func withUnsafeMutableBytes<R>(_ body: (UnsafeMutableRawBufferPointer) throws -> R) rethrows -> R
    /// Call body(p), where p is a pointer to the collection’s contiguous storage. If no such storage exists, it is first created. If the collection does not support an internal representation in a form of contiguous storage, body is not called and nil is returned.
    @inlinable
    func withContiguousStorageIfAvailable<R>(_ body: (UnsafeBufferPointer<Element>) throws -> R) rethrows -> R?
    /// Call body(p), where p is a pointer to the collection’s mutable contiguous storage. If no such storage exists, it is first created. If the collection does not support an internal representation in a form of mutable contiguous storage, body is not called and nil is returned.
    mutating func withContiguousMutableStorageIfAvailable<R>(_ body: (inout UnsafeMutableBufferPointer<Element>) throws -> R) rethrows -> R?
    
    // Related Array Types
    //    struct ContiguousArray
    //    A contiguously stored array.
    //    struct ArraySlice
    //    A slice of an Array, ContiguousArray, or ArraySlice instance.
    //    Reference Types
    //    Use bridged reference types when you need reference semantics or Foundation-specific behavior.
    //    class NSArray
    //    An object representing a static ordered collection, for use instead of an Array constant in cases that require reference semantics.
    //    class NSMutableArray
    //    An object representing a dynamic ordered collection, for use instead of an Array variable in cases that require reference semantics.
    
    // Supporting Types
    //    typealias Array.Index
    //    The index type for arrays, Int.
    //    typealias Array.Indices
    //    The type that represents the indices that are valid for subscripting an array, in ascending order.
    //    typealias Array.Iterator
    //    The type that allows iteration over an array’s elements.
    //    typealias Array.ArrayLiteralElement
    //    The type of the elements of an array literal.
    //    typealias Array.SubSequence
    //    A sequence that represents a contiguous subrange of the collection’s elements.
    
    // Infrequently Used Functionality
    //    init(arrayLiteral: Element...)
    //    Creates an array from the given array literal.
    //    @inlinable
//    var hashValue: Int
    //    The hash value.
    //    Available when Element conforms to Hashable.
    // Type Aliases
    //    typealias Array.Regions
    //    Available when Element is UInt8.
    //    Initializers
    //    init(fromSplitComplex: DSPDoubleSplitComplex, scale: Double, count: Int)
    //    Available when Element is Double.
    //    init(fromSplitComplex: DSPSplitComplex, scale: Float, count: Int)
    //    Available when Element is Float.
    //    Instance Properties
    //    @inlinable
//    var regions: CollectionOfOne<Array<UInt8>>
    //    Available when Element is UInt8.
}

public protocol EquatableArrayType: ArrayType, Equatable where Element: Equatable {
    /// Returns a Boolean value indicating whether the sequence contains the given element.
    @inlinable
    func contains(_ element: Element) -> Bool
    /// Returns a Boolean value indicating whether two arrays contain the same elements in the same order.
    /// Available when Element conforms to Equatable.
    static func == (lhs: Self, rhs: Self) -> Bool
    /// Returns a Boolean value indicating whether two values are not equal.
    /// Available when Element conforms to Equatable.
    static func != (lhs: Self, rhs: Self) -> Bool
    /// Returns a Boolean value indicating whether this sequence and another sequence contain the same elements in the same order.
    /// Available when Element conforms to Equatable.
    @inlinable
    func elementsEqual<OtherSequence>(_ other: OtherSequence) -> Bool where OtherSequence : Sequence, Self.Element == OtherSequence.Element
    /// Returns the first index where the specified value appears in the collection.
    /// Available when Element conforms to Equatable.
    @inlinable
    func firstIndex(of element: Element) -> Int?
    /// Returns the last index where the specified value appears in the collection.
    /// Available when Element conforms to Equatable.
    @inlinable
    func lastIndex(of element: Element) -> Int?
    /// Returns the longest possible subsequences of the collection, in order, around elements equal to the given element.
    /// Available when Element conforms to Equatable. Should be "separator: Element, maxSplits: Int = Int.max, omittingEmptySubsequences: Bool = true"
    @inlinable
    func split(separator: Element, maxSplits: Int, omittingEmptySubsequences: Bool) -> [ArraySlice<Element>]
    /// Returns the difference needed to produce this collection’s ordered elements from the given collection.
    /// Available when Element conforms to Equatable.
    @available(OSX 10.15, *)
    @inlinable
    func difference<C>(from other: C) -> CollectionDifference<Element> where C : BidirectionalCollection, Self.Element == C.Element
    /// Returns a Boolean value indicating whether the initial elements of the sequence are the same as the elements in another sequence.
    /// Available when Element conforms to Equatable.
    @inlinable
    func starts<PossiblePrefix>(with possiblePrefix: PossiblePrefix) -> Bool where PossiblePrefix : Sequence, Self.Element == PossiblePrefix.Element
}

public protocol StringArrayType: ArrayType where Element == String {
    /// Returns a new string by concatenating the elements of the sequence, adding the given separator between each element.
    @inlinable
    func joined(separator: String) -> String
}

public protocol StringProtocolArrayType: ArrayType where Element: StringProtocol {
    /// Returns a new string by concatenating the elements of the sequence, adding the given separator between each element.
    @inlinable
    func joined(separator: String) -> String
}

public protocol SequenceArrayType: ArrayType where Element: Sequence {
    /// Returns the elements of this sequence of sequences, concatenated.
    @inlinable
    func joined() -> FlattenSequence<Array<Element>>
    /// Returns the concatenated elements of this sequence of sequences, inserting the given separator between each element.
    @inlinable
    func joined<Separator>(separator: Separator) -> JoinedSequence<Array<Element>> where Separator : Sequence, Separator.Element == Self.Element.Element
}

public protocol ComparableArrayType: ArrayType where Element: Comparable {
    /// Returns a Boolean value indicating whether the sequence precedes another sequence in a lexicographical (dictionary) ordering, using the less-than operator (<) to compare elements.
    /// Available when Element conforms to Comparable.
    @inlinable
    func lexicographicallyPrecedes<OtherSequence>(_ other: OtherSequence) -> Bool where OtherSequence : Sequence, Self.Element == OtherSequence.Element
    /// Returns the minimum element in the sequence.
    /// Available when Element conforms to Comparable.
    @warn_unqualified_access
    @inlinable
    func min() -> Element?
    /// Returns the maximum element in the sequence.
    /// Available when Element conforms to Comparable.
    @warn_unqualified_access
    @inlinable
    func max() -> Element?
    /// Sorts the collection in place.
    /// Available when Element conforms to Comparable.
    @inlinable
    mutating func sort()
    /// Returns the elements of the sequence, sorted.
    /// Available when Element conforms to Comparable.
    @inlinable
    func sorted() -> Self
}

public protocol InitableArrayType: ArrayType {
    
    /// Returns the elements of the sequence, sorted using the given predicate as the comparison between elements.
    @inlinable
    func sorted(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows -> Self

    /// Returns the elements of the sequence, shuffled.
    @inlinable
    func shuffled() -> Self
    /// Returns the elements of the sequence, shuffled using the given generator as a source for randomness.
    @inlinable
    func shuffled<T>(using generator: inout T) -> Self where T : RandomNumberGenerator
}
