//
//  File.swift
//  
//
//  Created by David Sweeris on 2/25/20.
//

import Foundation

public protocol BidirectionalCollectionVia : CollectionVia, BidirectionalCollection where CollectionType : BidirectionalCollection {}

extension BidirectionalCollectionVia {
    /// Returns the position immediately before the given index.
    ///
    /// - Parameter i: A valid index of the collection. `i` must be greater than
    ///   `startIndex`.
    /// - Returns: The index value immediately before `i`.
    func index(before i: CollectionType.Index) -> CollectionType.Index {
       self[keyPath: Self.collectionVia].index(before: i)
    }
    
    /// Replaces the given index with its predecessor.
    ///
    /// - Parameter i: A valid index of the collection. `i` must be greater than
    ///   `startIndex`.
    func formIndex(before i: inout CollectionType.Index) {
        self[keyPath: Self.collectionVia].formIndex(before: &i)
    }
    
    /// Returns the distance between two indices.
    ///
    /// Unless the collection conforms to the `BidirectionalCollection` protocol,
    /// `start` must be less than or equal to `end`.
    ///
    /// - Parameters:
    ///   - start: A valid index of the collection.
    ///   - end: Another valid index of the collection. If `end` is equal to
    ///     `start`, the result is zero.
    /// - Returns: The distance between `start` and `end`. The result can be
    ///   negative only if the collection conforms to the
    ///   `BidirectionalCollection` protocol.
    ///
    /// - Complexity: O(1) if the collection conforms to
    ///   `RandomAccessCollection`; otherwise, O(*k*), where *k* is the
    ///   resulting distance.
    func distance(from start: CollectionType.Index, to end: CollectionType.Index) -> Int {
        self[keyPath: Self.collectionVia].distance(from: start, to: end)
    }
}
