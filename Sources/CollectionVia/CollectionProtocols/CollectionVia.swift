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
    var startIndex: CollectionType.Index { self[keyPath: Self.collectionVia].startIndex }
    var endIndex: CollectionType.Index   { self[keyPath: Self.collectionVia].endIndex }
    var indices: CollectionType.Indices  { self[keyPath: Self.collectionVia].indices }
    var isEmpty: Bool                    { self[keyPath: Self.collectionVia].isEmpty }
    var count: Int                       { self[keyPath: Self.collectionVia].count }
    
    subscript(position: CollectionType.Index) -> CollectionType.Element          { self[keyPath: Self.collectionVia][position] }
    subscript(bounds: Range<CollectionType.Index>) -> CollectionType.SubSequence { self[keyPath: Self.collectionVia][bounds] }
    
    func makeIterator() -> CollectionType.Iterator {
        self[keyPath: Self.collectionVia].makeIterator()
    }
    func index(_ i: CollectionType.Index, offsetBy distance: Int) -> CollectionType.Index {
        self[keyPath: Self.collectionVia].index(i, offsetBy: distance)
    }
    func index(_ i: CollectionType.Index, offsetBy distance: Int, limitedBy limit: CollectionType.Index) -> CollectionType.Index? {
        self[keyPath: Self.collectionVia].index(i, offsetBy: distance, limitedBy: limit)
    }
    func distance(from start: CollectionType.Index, to end: CollectionType.Index) -> Int {
        self[keyPath: Self.collectionVia].distance(from: start, to: end)
    }
    func index(after i: CollectionType.Index) -> CollectionType.Index {
        self[keyPath: Self.collectionVia].index(after: i)
    }
    func formIndex(after i: inout CollectionType.Index) {
        self[keyPath: Self.collectionVia].formIndex(after: &i)
    }
}


//public protocol ArrayVia : RandomAccessMutableCollectionVia where CollectionType == Array<Element> {
////    typealias CollectionType = Array<Element>
////    typealias Index = Array<Element>.Index
////    typealias Indices = Array<Element>.Indices
////    typealias SubSequence = Array<Element>.SubSequence
////
////    static var collectionVia: WritableKeyPath<Self, [Element]> {get}
//}
//extension ArrayVia {
//    public var startIndex: Index {
//        self[keyPath: Self.collectionVia].startIndex
//    }
//    public var endIndex: Index {
//        self[keyPath: Self.collectionVia].endIndex
//    }
//    public var indices: Indices {
//        self[keyPath: Self.collectionVia].indices
//    }
//    public func index(after i: Index) -> Index {
//        self[keyPath: Self.collectionVia].index(after: i)
//    }
//    public func index(before i: Index) -> Index {
//        self[keyPath: Self.collectionVia].index(before: i)
//    }
//    public subscript(position: Index) -> Element {
//        get { self[keyPath: Self.collectionVia][position] }
//        set { self[keyPath: Self.collectionVia][position] = newValue }
//    }
//    public subscript(bounds: Range<Index>) -> SubSequence {
//        get {self[keyPath: Self.collectionVia][bounds]}
//        set {self[keyPath: Self.collectionVia][bounds] = newValue}
//    }
//    public mutating func append(_ newElement: Element) {
//        self[keyPath: Self.collectionVia].append(newElement)
//    }
//    public mutating func append<S> (contentsOf s: S) where S: Sequence, S.Element == Element {
//        self[keyPath: Self.collectionVia].append(contentsOf: s)
//    }
//    public mutating func insert(_ newElement: Element, at: Int) {
//        self[keyPath: Self.collectionVia].insert(newElement, at: at)
//    }
//    public mutating func insert<C> (contentsOf: C, at: Int) where C: Collection, C.Element == Element {
//        self[keyPath: Self.collectionVia].insert(contentsOf: contentsOf, at: at)
//    }
//}
//
//

