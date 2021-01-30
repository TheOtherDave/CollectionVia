import XCTest

#if !canImport(ObjectiveC)
@inlinable public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(CollectionViaTests.allTests),
    ]
}
#endif
