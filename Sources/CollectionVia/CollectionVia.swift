//
//  CollectionVia.swift
//
//  Created by David Sweeris on 11/29/19.
//  Copyright © 2019 David Sweeris. All rights reserved.
//

import Foundation

public protocol CollectionVia: Collection {//where CollectionType.Indices == DefaultIndices<Self> {
    associatedtype CollectionType : Collection
//    typealias Element = CollectionType.Element
//    typealias Index = CollectionType.Index
    // Something about manually spelling this particular associated type out really throws type inference for a loop
//    typealias Indices = CollectionType.Indices
//    typealias Iterator = CollectionType.Iterator
//    typealias SubSequence = CollectionType.SubSequence

    static var collectionVia: KeyPath<Self, CollectionType> {get}
}

extension CollectionVia {
    public var startIndex: CollectionType.Index { self[keyPath: Self.collectionVia].startIndex }
    public var endIndex: CollectionType.Index   { self[keyPath: Self.collectionVia].endIndex }
    public var indices: CollectionType.Indices  { self[keyPath: Self.collectionVia].indices }
    public var isEmpty: Bool                    { self[keyPath: Self.collectionVia].isEmpty }
    public var count: Int                       { self[keyPath: Self.collectionVia].count }
    
    public subscript(position: CollectionType.Index) -> CollectionType.Element          { self[keyPath: Self.collectionVia][position] }
    public subscript(bounds: Range<CollectionType.Index>) -> CollectionType.SubSequence { self[keyPath: Self.collectionVia][bounds] }
    
    public func makeIterator() -> CollectionType.Iterator {
        self[keyPath: Self.collectionVia].makeIterator()
    }
    public func index(_ i: CollectionType.Index, offsetBy distance: Int) -> CollectionType.Index {
        self[keyPath: Self.collectionVia].index(i, offsetBy: distance)
    }
    public func index(_ i: CollectionType.Index, offsetBy distance: Int, limitedBy limit: CollectionType.Index) -> CollectionType.Index? {
        self[keyPath: Self.collectionVia].index(i, offsetBy: distance, limitedBy: limit)
    }
    public func distance(from start: CollectionType.Index, to end: CollectionType.Index) -> Int {
        self[keyPath: Self.collectionVia].distance(from: start, to: end)
    }
    public func index(after i: CollectionType.Index) -> CollectionType.Index {
        self[keyPath: Self.collectionVia].index(after: i)
    }
    public func formIndex(after i: inout CollectionType.Index) {
        self[keyPath: Self.collectionVia].formIndex(after: &i)
    }
}
