//
//  SequenceVia.swift
//  
//
//  Created by David Sweeris on 2/24/20.
//

import Swift

public protocol SequenceVia : Sequence where Element == SequenceType.Element, Iterator == SequenceType.Iterator {
    associatedtype SequenceType : Sequence
    
    static var sequenceVia: KeyPath<Self, SequenceType> {get}
}

extension SequenceVia {
    var underestimatedCount: Int                 { self[keyPath: Self.sequenceVia].underestimatedCount }
    func makeIterator() -> SequenceType.Iterator { self[keyPath: Self.sequenceVia].makeIterator() }
    
    func withContiguousStorageIfAvailable<R>(_ body: (UnsafeBufferPointer<Self.Element>) throws -> R) rethrows -> R? {
        try self[keyPath: Self.sequenceVia].withContiguousStorageIfAvailable(body)
    }
}
