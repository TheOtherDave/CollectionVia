import XCTest
@testable import CollectionVia

// I'm not actually sure what all to test here. All I ever really did was claim that a type conformed to the relevant protocols, then fiddled with the `*Via` protocol extensions until the type system was happy. It seems like if it compiles it _should_ "just work". There's no real "testable" logic to any of this -- just forwarding implementations to the keypath. Although, it is probably good to make sure something isn't forwarded to the wrong property.

final class CollectionViaTests: XCTestCase {
    
    struct ASequence<T: Sequence> : SequenceVia {
        typealias CollectionType = T
        static var sequenceVia: KeyPath<ASequence, T> { \ASequence.data }
        var data: T
    }
    
    struct ACollection<T: Collection> : CollectionVia {
        typealias CollectionType = T
        static var collectionVia: KeyPath<ACollection, T> { \ACollection.data }
        var data: T
    }

    struct AMutableCollection<T: MutableCollection> : MutableCollectionVia {
        typealias CollectionType = T
        static var collectionVia: WritableKeyPath<AMutableCollection, T> { \AMutableCollection.data }
        var data: T
    }
    
    struct AnArray<T: ArrayType>: ArrayVia {
        func enumerated() -> EnumeratedSequence<Array<T.Element>> {
            data.enumerated()
        }
        
        var lazy: LazySequence<Array<T.Element>> {
            data.lazy
        }
        
        func drop(while predicate: (T.Element) throws -> Bool) rethrows -> ArraySlice<T.Element> {
            try data.drop(while: predicate)
        }
        
        func dropLast(_ k: Int) -> ArraySlice<T.Element> {
            data.dropLast(k)
        }
        
        func dropFirst(_ k: Int) -> ArraySlice<T.Element> {
            data.dropFirst(k)
        }
        
        func suffix(from start: Int) -> ArraySlice<T.Element> {
            data.suffix(from: start)
        }
        
        func suffix(_ maxLength: Int) -> ArraySlice<T.Element> {
            data.suffix(maxLength)
        }
        
        func prefix(while predicate: (T.Element) throws -> Bool) rethrows -> ArraySlice<T.Element> {
            try data.prefix(while: predicate)
        }
        
        func prefix(upTo end: Int) -> ArraySlice<T.Element> {
            data.prefix(upTo: end)
        }
        
        func prefix(through position: Int) -> ArraySlice<T.Element> {
            data.prefix(through: position)
        }
        
        func prefix(_ maxLength: Int) -> ArraySlice<T.Element> {
            data.prefix(maxLength)
        }
        
        static func += <Other>(lhs: inout CollectionViaTests.AnArray<T>, rhs: Other) where Other : Sequence, Self.CollectionType.Element == Other.Element {
            lhs.data += rhs
        }
        
        subscript<R>(r: R) -> ArraySlice<T.Element> where R : RangeExpression, R.Bound == Int {
            get {
                data[r]
            }
            set(newValue) {
                data[r] = newValue
            }
        }
        
        typealias CollectionType = T
        static var collectionVia: WritableKeyPath<AnArray, T> { \AnArray.data }
        var data: T
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let testData = [1,2,3,4]
        let coll = ACollection(data: testData)
        
        // Test some basic properties
        XCTAssert(coll.count == testData.count)
        XCTAssert(coll.startIndex == testData.startIndex)
        XCTAssert(coll.endIndex == testData.endIndex)
        
        XCTAssert(coll[coll.startIndex] == testData[testData.startIndex])
        XCTAssert(coll.first == testData.first)
        
        // ensure the `for _ in _` mechanism is working
        var collForIn = 0
        for e in coll { collForIn += e }
        var testForIn = 0
        for e in testData { testForIn += e }
        XCTAssert(collForIn == testForIn)
        
        // Just double-checking that the type system can handle "double-inference"
//        let _ = ACollection(data: coll)

    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
