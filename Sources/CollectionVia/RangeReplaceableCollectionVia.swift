//
//  RangeReplaceableCollectionVia.swift
//  
//
//  Created by David Sweeris on 2/28/20.
//

import Swift

public protocol RangeReplaceableCollectionVia: RangeReplaceableCollection where
    Element == CollectionType.Element,
    Iterator == CollectionType.Iterator,
    SubSequence == CollectionType.SubSequence
{
    associatedtype CollectionType: RangeReplaceableCollection
    @inlinable static var collectionVia: WritableKeyPath<Self, CollectionType> {get}
    init()
}

extension RangeReplaceableCollectionVia {
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


// TODO: Figure out why there needs to be a different versions depending on whether `CollectionType` conforms to `MutableCollection`. I suspect it's because `RangeReplaceableCollection` refines `Collection` instead of `MutableCollection`. Dunno why... seems to me that the "Replacable" part kinda implies mutability, but ¯\_(ツ)_/¯
extension RangeReplaceableCollectionVia {
    @inlinable public subscript(position: CollectionType.Index) -> CollectionType.Element {
        get { self[keyPath: Self.collectionVia][position] }
    }
    @inlinable public subscript(bounds: Range<CollectionType.Index>) -> CollectionType.SubSequence {
        get { self[keyPath: Self.collectionVia][bounds] }
    }
}
extension RangeReplaceableCollectionVia where CollectionType: MutableCollection {
    @inlinable public subscript(position: CollectionType.Index) -> CollectionType.Element {
        get { self[keyPath: Self.collectionVia][position] }
        set { self[keyPath: Self.collectionVia][position] = newValue }
    }
    @inlinable public subscript(bounds: Range<CollectionType.Index>) -> CollectionType.SubSequence {
        get { self[keyPath: Self.collectionVia][bounds] }
        set { self[keyPath: Self.collectionVia][bounds] = newValue }
    }
}

extension RangeReplaceableCollectionVia {
    public mutating func replaceSubrange<C>(_ subrange: Range<CollectionType.Index>, with newElements: C) where C : Collection, Self.Element == C.Element {
        self[keyPath: Self.collectionVia].replaceSubrange(subrange, with: newElements)
    }
}

struct ARangeReplaceableCollection<T: RangeReplaceableCollection> : RangeReplaceableCollectionVia {
    static var collectionVia: WritableKeyPath<ARangeReplaceableCollection, T> { \ARangeReplaceableCollection.data }
    var data: T
    init() {
        data = T()
    }
}
