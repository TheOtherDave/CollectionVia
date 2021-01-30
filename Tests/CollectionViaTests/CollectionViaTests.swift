import XCTest
@testable import CollectionVia


// I'm not actually sure what all to test here. It seems like if this compiles, then it _should_ "just work" since there's no real logic to any of the code -- it all just forwards implementations on to wherever the keypath leads it. However, this does demonstrate that type inference is working the way I want it to, and it's probably good to make sure something isn't forwarded to the wrong property.
final class CollectionViaTests: XCTestCase {
    struct ASequence<T: Sequence>: SequenceVia {
        static var sequenceVia: KeyPath<ASequence, T> { \ASequence.data }
        var data: T
    }

    struct ACollection<T: Collection> : CollectionVia {
        static var collectionVia: KeyPath<ACollection, T> { \ACollection.data }
        var data: T
    }

    struct ABidirectionalCollection<T: BidirectionalCollection> : BidirectionalCollectionVia {
        static var collectionVia: KeyPath<ABidirectionalCollection, T> { \ABidirectionalCollection.data }
        var data: T
    }

    struct AMutableCollection<T: MutableCollection> : MutableCollectionVia {
        static var collectionVia: WritableKeyPath<AMutableCollection, T> { \AMutableCollection.data }
        var data: T
    }

    struct ARandomAccessCollection<T: RandomAccessCollection> : RandomAccessCollectionVia {
        static var collectionVia: KeyPath<ARandomAccessCollection, T> { \ARandomAccessCollection.data }
        var data: T
    }

    struct ARangeReplaceableCollection<T: RangeReplaceableCollection> : RangeReplaceableCollectionVia {
        static var collectionVia: WritableKeyPath<ARangeReplaceableCollection, T> { \ARangeReplaceableCollection.data }
        var data: T = T()
    }

    let testIntArray = [1,2,3,4]
    let testStrArray = ["hello","world"]
    let testDict = [1:"hello",2:"world"]
        
    // `Collection` refines `Sequence`, so idealy `CollectionVia` would refine `SequenceVia`. However, I've had some issues getting the type inference to work without having to manually specify all the typealiases and such (mostly revolving around `MutableCollectionVia`), so I'm grouping the tests by protocol so that I can easily check the intented protocol conformances.
    func testASequence() {
        testSequence(ASequence(data: testIntArray), against: testIntArray)
        testSequence(ASequence(data: testStrArray), against: testStrArray)
        testSequence(ASequence(data: testDict), against: testDict)
    }
    func testACollection() {
        testCollection(ACollection(data: testIntArray), against: testIntArray)
        testCollection(ACollection(data: testStrArray), against: testStrArray)
        testCollection(ACollection(data: testDict), against: testDict)

    }
    func testABidirectionalCollection() {
        testBidirectionalCollection(ABidirectionalCollection(data: testIntArray), against: testIntArray)
        testBidirectionalCollection(ABidirectionalCollection(data: testStrArray), against: testStrArray)
        // Apparently `Dictionary` doesn't conform to `BidirectionalCollection`.
//        testBidirectionalCollection(ABidirectionalCollection(data: testDict), against: testDict)
    }
    func testAMutableCollection() {
        testMutableCollection(AMutableCollection(data: testIntArray), against: testIntArray)
        testMutableCollection(AMutableCollection(data: testStrArray), against: testStrArray)
        // Apparently `Dictionary` doesn't conform to `MutableCollection`.
//        testMutableCollection(AMutableCollection(data: testDict), against: testDict)
    }
    func testARandomAccessCollection() {
        testRandomAccessCollection(ARandomAccessCollection(data: testIntArray), against: testIntArray)
        testRandomAccessCollection(ARandomAccessCollection(data: testStrArray), against: testStrArray)
        // Apparently `Dictionary` doesn't conform to `RandomAccessCollection`.
//        testRandomAccessCollection(ARandomAccessCollection(data: testDict), against: testDict)
    }

    func testARangeReplaceableCollection() {
        testRangeReplaceableCollection(ARangeReplaceableCollection(data: testIntArray), against: testIntArray)
        testRangeReplaceableCollection(ARangeReplaceableCollection(data: testStrArray), against: testStrArray)
        // Apparently `Dictionary` doesn't conform to `RangeReplaceableCollection`.
//        testRangeReplaceableCollection(ARangeReplaceableCollection(data: testDict), against: testDict)
    }

    //MARK: Protocol conformance testing functions
    func testSequence<S1:Sequence, S2:Sequence>(_ s1: S1, against s2: S2) where
        S1.Element == S2.Element
    {
        // Check underestimatedCount
        XCTAssert(s1.underestimatedCount == s2.underestimatedCount)

        // IIUC, this is a reasonable way to test the `makeIterator()` function.
        var s1ForIn = [S1.Element]()
        for e in s1 { s1ForIn.append(e) }
        var s2ForIn = [S2.Element]()
        for e in s2 { s2ForIn.append(e) }
        
        // I don't want to add `Equatable` requirements because `Dictionary.Element` is a tuple and can't conform to anything. This isn't particularly rigorous IMHO, but everything here either conforms to `CustomStringConvertible` or is a tuple of things which conform, and poking around in a playgroud leads me to believe that this will work.
        XCTAssert(s1ForIn.map { "\($0)" } == s2ForIn.map { "\($0)" })
    }
    
    func testCollection<C1: Collection, C2: Collection>(_ c1: C1, against c2: C2) where
        C1.Element == C2.Element,
        C1.Index == C2.Index,
        C1.SubSequence == C2.SubSequence
    {
        // Ensure that a `CollectionVia` type also passes the `Sequence` tests
        testSequence(c1, against: c2)
        
        XCTAssert(c1.count == c2.count)
        
        let c1StartIdx = c1.startIndex
        let c2StartIdx = c2.startIndex
        let c1EndIdx = c1.endIndex
        let c2EndIdx = c2.endIndex

        XCTAssert(c1StartIdx == c2StartIdx)
        XCTAssert(c1EndIdx == c2EndIdx)
        XCTAssert(c1.index(c1StartIdx, offsetBy: 0) == c2.index(c2StartIdx, offsetBy: 0))
        XCTAssert(c1.index(c1StartIdx, offsetBy: 1) == c2.index(c2StartIdx, offsetBy: 1))
        XCTAssert(c1.index(c1StartIdx, offsetBy: c1.count-1, limitedBy: c1EndIdx) == c2.index(c2StartIdx, offsetBy: c2.count-1, limitedBy: c2EndIdx))
        XCTAssert(c1.index(c1StartIdx, offsetBy: c1.count+1, limitedBy: c1EndIdx) == c2.index(c2StartIdx, offsetBy: c2.count+1, limitedBy: c2EndIdx))
        XCTAssert(c1.distance(from: c1StartIdx, to: c1EndIdx) == c2.distance(from: c2StartIdx, to: c2EndIdx))
        XCTAssert(c1.index(after: c1StartIdx) == c2.index(after: c2StartIdx))
        
        var vDataIndex = c1StartIdx
        var vArrayIndex = c2StartIdx
        
        c1.formIndex(after: &vDataIndex)
        c2.formIndex(after: &vArrayIndex)
        XCTAssert(vDataIndex == vArrayIndex)
        c1.formIndex(&vDataIndex, offsetBy: 1)
        c2.formIndex(&vArrayIndex, offsetBy: 1)
        XCTAssert(vDataIndex == vArrayIndex)
        
        // I don't want to add `Equatable` requirements because `Dictionary.Element` is a tuple and can't conform to anything. This isn't particularly rigorous IMHO, but everything here either conforms to `CustomStringConvertible` or is a tuple of things which conform, and poking around in a playgroud leads me to believe that this will work.
        XCTAssert("\(c1[c1.startIndex])" == "\(c2[c2.startIndex])")
        XCTAssert("\(c1[c1.startIndex...])" == "\(c2[c2.startIndex...])")
        XCTAssert("\(c1.first!)" == "\(c2.first!)")
    }

    func testBidirectionalCollection<C1: BidirectionalCollection, C2: BidirectionalCollection>(_ c1: C1, against c2: C2) where
        C1.Element == C2.Element,
        C1.Index == C2.Index,
        C1.SubSequence == C2.SubSequence
    {
        // Ensure that a `BidirectionalCollectionVia` type also passes the `Collection` tests
        testCollection(c1, against: c2)
        
        XCTAssert(c1.index(before: c1.endIndex) == c2.index(before: c2.endIndex))
    }
    
    func testMutableCollection<C1: MutableCollection, C2: MutableCollection>(_ c1: C1, against c2: C2) where
        C1.Element == C2.Element,
        C1.Index == C2.Index,
        C1.SubSequence == C2.SubSequence
    {
        // Ensure that a `MutableCollectionVia` type also passes the `Collection` tests
        testCollection(c1, against: c2)

        var c1 = c1
        var c2 = c2
        c1[c1.startIndex] = c1[c1.indices.reversed().first!]
        c2[c2.startIndex] = c2[c2.indices.reversed().first!]
        XCTAssert("\(c1.first!)" == "\(c2.first!)")
    }
    
    func testRangeReplaceableCollection<C1: RangeReplaceableCollection, C2: RangeReplaceableCollection>(_ c1: C1, against c2: C2) where
        C1.Element == C2.Element,
        C1.Index == C2.Index,
        C1.SubSequence == C2.SubSequence
    {
        // Ensure that a `RandomAccessCollectionVia` type also passes the `Collection` tests
        testCollection(c1, against: c2)

    }
    
    func testRandomAccessCollection<C1: RandomAccessCollection, C2: RandomAccessCollection>(_ c1: C1, against c2: C2) where
        C1.Element == C2.Element,
        C1.Index == C2.Index,
        C1.SubSequence == C2.SubSequence
    {
        // Ensure that a `RandomAccessCollectionVia` type also passes the `Collection` tests
        testCollection(c1, against: c2)

    }

    
    static var allTests = [
        ("testASequence", testASequence),
        ("testACollection", testACollection),
        ("testABidirectionalCollection", testABidirectionalCollection),
        ("testAMutableCollection", testAMutableCollection),
        ("testARandomAccessCollection", testARandomAccessCollection),
    ]
}
