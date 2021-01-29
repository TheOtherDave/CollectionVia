//
//  RangeReplaceableCollectionVia.swift
//  
//
//  Created by David Sweeris on 2/28/20.
//

import Swift

/// A collection that supports replacement of an arbitrary subrange of elements
/// with the elements of another collection.
///
/// Range-replaceable collections provide operations that insert and remove
/// elements. For example, you can add elements to an array of strings by
/// calling any of the inserting or appending operations that the
/// `RangeReplaceableCollection` protocol defines.
///
///     var bugs = ["Aphid", "Damselfly"]
///     bugs.append("Earwig")
///     bugs.insert(contentsOf: ["Bumblebee", "Cicada"], at: 1)
///     print(bugs)
///     // Prints "["Aphid", "Bumblebee", "Cicada", "Damselfly", "Earwig"]"
///
/// Likewise, `RangeReplaceableCollection` types can remove one or more
/// elements using a single operation.
///
///     bugs.removeLast()
///     bugs.removeSubrange(1...2)
///     print(bugs)
///     // Prints "["Aphid", "Damselfly"]"
///
///     bugs.removeAll()
///     print(bugs)
///     // Prints "[]"
///
/// Lastly, use the eponymous `replaceSubrange(_:with:)` method to replace
/// a subrange of elements with the contents of another collection. Here,
/// three elements in the middle of an array of integers are replaced by the
/// five elements of a `Repeated<Int>` instance.
///
///      var nums = [10, 20, 30, 40, 50]
///      nums.replaceSubrange(1...3, with: repeatElement(1, count: 5))
///      print(nums)
///      // Prints "[10, 1, 1, 1, 1, 1, 50]"
///
/// Conforming to the RangeReplaceableCollection Protocol
/// =====================================================
///
/// To add `RangeReplaceableCollection` conformance to your custom collection,
/// add an empty initializer and the `replaceSubrange(_:with:)` method to your
/// custom type. `RangeReplaceableCollection` provides default implementations
/// of all its other methods using this initializer and method. For example,
/// the `removeSubrange(_:)` method is implemented by calling
/// `replaceSubrange(_:with:)` with an empty collection for the `newElements`
/// parameter. You can override any of the protocol's required methods to
/// provide your own custom implementation.
public protocol RangeReplaceableCollectionVia : CollectionVia, RangeReplaceableCollection where CollectionType: RangeReplaceableCollection {

    /// Creates a new, empty collection.
    init()

    /// Replaces the specified subrange of elements with the given collection.
    ///
    /// This method has the effect of removing the specified range of elements
    /// from the collection and inserting the new elements at the same location.
    /// The number of new elements need not match the number of elements being
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
    /// Calling this method may invalidate any existing indices for use with this
    /// collection.
    ///
    /// - Parameters:
    ///   - subrange: The subrange of the collection to replace. The bounds of
    ///     the range must be valid indices of the collection.
    ///   - newElements: The new elements to add to the collection.
    ///
    /// - Complexity: O(*n* + *m*), where *n* is length of this collection and
    ///   *m* is the length of `newElements`. If the call to this method simply
    ///   appends the contents of `newElements` to the collection, this method is
    ///   equivalent to `append(contentsOf:)`.
    mutating func replaceSubrange<C>(_ subrange: Range<Self.Index>, with newElements: C) where C : Collection, Self.Element == C.Element
}

extension RangeReplaceableCollectionVia where Self: MutableCollectionVia, CollectionType.Element == Element {
    mutating func replaceSubrange<C>(_ subrange: Range<CollectionType.Index>, with newElements: C) where C : Collection, Self.Element == C.Element {
        self[keyPath: Self.collectionVia].replaceSubrange(subrange, with: newElements)
    }
}
