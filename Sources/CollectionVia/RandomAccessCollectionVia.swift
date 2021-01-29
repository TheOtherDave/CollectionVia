//
//  File.swift
//  
//
//  Created by David Sweeris on 2/25/20.
//

import Foundation

//The property & function descriptions don't seem to copy over from the collection protocols, so I left them in.

public protocol RandomAccessCollectionVia : RandomAccessCollection, BidirectionalCollectionVia where CollectionType: RandomAccessCollection {}

extension RandomAccessCollectionVia {
    /// The indices that are valid for subscripting the collection, in ascending
    /// order.
    ///
    /// A collection's `indices` property can hold a strong reference to the
    /// collection itself, causing the collection to be nonuniquely referenced.
    /// If you mutate the collection while iterating over its indices, a strong
    /// reference can result in an unexpected copy of the collection. To avoid
    /// the unexpected copy, use the `index(after:)` method starting with
    /// `startIndex` to produce indices instead.
    ///
    ///     var c = MyFancyCollection([10, 20, 30, 40, 50])
    ///     var i = c.startIndex
    ///     while i != c.endIndex {
    ///         c[i] /= 5
    ///         i = c.index(after: i)
    ///     }
    ///     // c == MyFancyCollection([2, 4, 6, 8, 10])
    var indices: CollectionType.Indices { self[keyPath: Self.collectionVia].indices }
    
    /// Accesses a contiguous subrange of the collection's elements.
    ///
    /// The accessed slice uses the same indices for the same elements as the
    /// original collection uses. Always use the slice's `startIndex` property
    /// instead of assuming that its indices start at a particular value.
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
    ///     let index = streetsSlice.firstIndex(of: "Evarts")    // 4
    ///     print(streets[index!])
    ///     // Prints "Evarts"
    ///
    /// - Parameter bounds: A range of the collection's indices. The bounds of
    ///   the range must be valid indices of the collection.
    ///
    /// - Complexity: O(1)
//    I understand that these can have more performant implementations depending on exactly which protocols a type conforms to, but we're just forwarding them here so I don't think it matters. Also I don't want to deal with any "ambiguous whatever" errors until I know everything's working correctly.
//    subscript(bounds: Range<CollectionType.Index>) -> CollectionType.SubSequence { get }
//
//    override subscript(position: Self.Index) -> Self.Element { get }

    var startIndex: CollectionType.Index { self[keyPath: Self.collectionVia].startIndex }
    var endIndex: CollectionType.Index { self[keyPath: Self.collectionVia].endIndex }
}
