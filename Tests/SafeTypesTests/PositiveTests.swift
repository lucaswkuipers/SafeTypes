import XCTest
@testable import SafeTypes

final class PositiveTests: XCTestCase {

    // MARK: - Init

    func test_init_setsValueCorrectly(){
        XCTAssertNil(Positive(-1))
        XCTAssertNil(Positive(-12.3))
        XCTAssertNil(Positive(Float(-12.3)))
        XCTAssertNil(Positive(Int.zero))
        XCTAssertNil(Positive(Double.zero))
        XCTAssertNil(Positive(Float.zero))
        XCTAssertEqual(Positive(1)?.value, 1)
        XCTAssertEqual(Positive(2.0)?.value, 2.0)
        XCTAssertEqual(Positive(Float(123))?.value, Float(123))
    }
}
