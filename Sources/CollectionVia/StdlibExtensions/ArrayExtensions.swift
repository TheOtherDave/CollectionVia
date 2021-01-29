//
//  File.swift
//  
//
//  Created by David Sweeris on 1/15/21.
//

import Foundation

extension Array: ArrayType {
    public typealias CollectionType = Array
}

extension Array: EquatableArrayType where Element: Equatable {}
extension Array: StringArrayType where Element == String {}
extension Array: StringProtocolArrayType where Element: StringProtocol {}
extension Array: ComparableArrayType where Element: Comparable {}
extension Array: SequenceArrayType where Element: Sequence {}
