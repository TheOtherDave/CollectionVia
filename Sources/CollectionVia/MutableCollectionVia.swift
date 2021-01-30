//
//  MutableCollectionVia.swift
//  
//
//  Created by David Sweeris on 2/25/20.
//

import Foundation

public protocol MutableCollectionVia: MutableCollection where CollectionType: MutableCollection {
    associatedtype CollectionType
    @inlinable static var collectionVia: WritableKeyPath<Self, CollectionType> {get}
}

extension MutableCollectionVia {
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

extension MutableCollectionVia {
    @inlinable public subscript(position: CollectionType.Index) -> CollectionType.Element {
        get { self[keyPath: Self.collectionVia][position] }
        set { self[keyPath: Self.collectionVia][position] = newValue }
    }
    @inlinable public subscript(bounds: Range<CollectionType.Index>) -> CollectionType.SubSequence {
        get { self[keyPath: Self.collectionVia][bounds] }
        set { self[keyPath: Self.collectionVia][bounds] = newValue }
    }
}

////TODO: Figure out why this song & dance is even necessary. The fact that no type coersion is happening here means (I think) that `CollectionVia`'s keypath req should be filled by `MutableCollectionVia`'s writable keypath. Feels like I'm missing something here. By declaring a _WritableKeyPath_ static property and just assigning the existing writable version of `collectionVia` to it, we force the compiler to pick the version from `MutableCollectionVia` instead of `CollectionVia`. We then use this value to give the compiler a value for the regular, non-writable keypath that `CollectionVia` wants. TBH I'm not even sure this should compile, but it works so... I guess it's ok? Probably not.
//public extension MutableCollectionVia {
//    // RIP 80 column people
//    private static var aSpecificallyWritableKeyPathToAvoidConfusionWithTheOstensiblyImmutableCollectionViaProtocolRequirement: WritableKeyPath<Self, CollectionType> { collectionVia }
//    // And then "cast" it back to a regular keypath to make the compiler happy
//    @inlinable static var collectionVia: KeyPath<Self, CollectionType> { aSpecificallyWritableKeyPathToAvoidConfusionWithTheOstensiblyImmutableCollectionViaProtocolRequirement }
//}
