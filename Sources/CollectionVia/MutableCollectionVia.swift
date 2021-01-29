//
//  MutableCollectionVia.swift
//  
//
//  Created by David Sweeris on 2/25/20.
//

import Foundation

public protocol MutableCollectionVia : MutableCollection, CollectionVia where CollectionType: MutableCollection {
    //FIXME: Figure out why this breaks if I take the compiler's advice and express the redeclaration of `CollectionType` as a `where` clause. Specifically, something in the type inference system stops working and you have start adding lots of typealiases at the, um, "conformance site". I think maybe the compiler is forgetting that `WritableKeyPath` inherits from `KeyPath` and can fulfill `CollectionVia`'s requirements even though it doesn't require a writable keypath? I'm pretty sure it has something to do with that because the other *Via protocols don't require the keypath to be writable and they don't seem to mind infering everything.
    
//    associatedtype CollectionType: MutableCollection
    static var collectionVia: WritableKeyPath<Self, CollectionType> {get}
}

public extension MutableCollectionVia {
    subscript(position: CollectionType.Index) -> CollectionType.Element {
        get           { self[keyPath: Self.collectionVia][position] }
        set(newValue) { self[keyPath: Self.collectionVia][position] = newValue }
    }
    
    subscript(bounds: Range<CollectionType.Index>) -> CollectionType.SubSequence {
        get           { self[keyPath: Self.collectionVia][bounds] }
        set(newValues){ self[keyPath: Self.collectionVia][bounds] = newValues}
    }
}

//TODO: Figure out why this song & dance is even necessary. The fact that no type coersion is happening here means (I think) that `CollectionVia`'s keypath req should be filled by `MutableCollectionVia`'s writable keypath. Feels like I'm missing something here. By declaring a _WritableKeyPath_ static property and just assigning the existing writable version of `collectionVia` to it, we force the compiler to pick the version from `MutableCollectionVia` instead of `CollectionVia`. We then use this value to give the compiler a value for the regular, non-writable keypath that `CollectionVia` wants. TBH I'm not even sure this should compile, but it works so... I guess it's ok? Probably not.
public extension MutableCollectionVia {
    // RIP 80 column people
    private static var aSpecificallyWritableKeyPathToAvoidConfusionWithTheOstensiblyImmutableCollectionViaProtocolRequirement: WritableKeyPath<Self, CollectionType> { collectionVia }
    // And then "cast" it back to a regular keypath to make the compiler happy
    static var collectionVia: KeyPath<Self, CollectionType> { aSpecificallyWritableKeyPathToAvoidConfusionWithTheOstensiblyImmutableCollectionViaProtocolRequirement }
}
