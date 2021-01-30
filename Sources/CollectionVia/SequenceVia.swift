//
//  SequenceVia.swift
//  
//
//  Created by David Sweeris on 2/24/20.
//

import Swift

public protocol SequenceVia : Sequence where Element == SequenceType.Element, Iterator == SequenceType.Iterator {
    associatedtype SequenceType : Sequence
    @inlinable static var sequenceVia: KeyPath<Self, SequenceType> {get}
}

extension SequenceVia {
    @inlinable public var underestimatedCount: Int {
        self[keyPath: Self.sequenceVia].underestimatedCount
    }
    @inlinable public func makeIterator() -> SequenceType.Iterator {
        self[keyPath: Self.sequenceVia].makeIterator()
    }
}
