//
//  CollectionVia.swift
//
//  Created by David Sweeris on 11/29/19.
//  Copyright © 2019 David Sweeris. All rights reserved.
//

import Foundation

public protocol CollectionVia: Collection where Element == CollectionType.Element, Iterator == CollectionType.Iterator {
    associatedtype CollectionType: Collection
    @inlinable static var collectionVia: KeyPath<Self, CollectionType> {get}
}

extension CollectionVia {
    @inlinable public var startIndex: CollectionType.Index { self[keyPath: Self.collectionVia].startIndex }
    @inlinable public var endIndex: CollectionType.Index   { self[keyPath: Self.collectionVia].endIndex }
    @inlinable public var indices: CollectionType.Indices  { self[keyPath: Self.collectionVia].indices }
    @inlinable public var isEmpty: Bool                    { self[keyPath: Self.collectionVia].isEmpty }
    @inlinable public var count: Int                       { self[keyPath: Self.collectionVia].count }
    
    @inlinable public func makeIterator() -> CollectionType.Iterator {
        self[keyPath: Self.collectionVia].makeIterator()
    }
    @inlinable public func index(_ i: CollectionType.Index, offsetBy distance: Int) -> CollectionType.Index {
        self[keyPath: Self.collectionVia].index(i, offsetBy: distance)
    }
    @inlinable public func index(_ i: CollectionType.Index, offsetBy distance: Int, limitedBy limit: CollectionType.Index) -> CollectionType.Index? {
        self[keyPath: Self.collectionVia].index(i, offsetBy: distance, limitedBy: limit)
    }
    @inlinable public func distance(from start: CollectionType.Index, to end: CollectionType.Index) -> Int {
        self[keyPath: Self.collectionVia].distance(from: start, to: end)
    }
    @inlinable public func index(after i: CollectionType.Index) -> CollectionType.Index {
        self[keyPath: Self.collectionVia].index(after: i)
    }
    @inlinable public func formIndex(after i: inout CollectionType.Index) {
        self[keyPath: Self.collectionVia].formIndex(after: &i)
    }
}

extension CollectionVia {
    @inlinable public subscript(position: CollectionType.Index) -> CollectionType.Element          { self[keyPath: Self.collectionVia][position] }
    @inlinable public subscript(bounds: Range<CollectionType.Index>) -> CollectionType.SubSequence { self[keyPath: Self.collectionVia][bounds] }
}
//
//extension CollectionVia where CollectionType: Equatable {
//    static func == (lhs: Self, rhs: Self) -> Bool {
//        lhs[keyPath: collectionVia] == rhs[keyPath: collectionVia]
//    }
//    static func == (lhs: Self, rhs: CollectionType) -> Bool {
//        lhs[keyPath: collectionVia] == rhs
//    }
//}
