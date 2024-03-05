import XCTest
@testable import SafeTypes

final class MinusOneToOneTests: XCTestCase {

    // MARK: - Init

    func test_init_setsValueCorrectly(){
        XCTAssertNil(MinusOneToOne(1.1))
        XCTAssertNil(MinusOneToOne(12.3))
        XCTAssertNil(MinusOneToOne(Float(12.3)))
        XCTAssertNil(MinusOneToOne(-1.2))
        XCTAssertNil(MinusOneToOne(42))
        XCTAssertEqual(MinusOneToOne(-1)?.value, -1)
        XCTAssertEqual(MinusOneToOne(1.0)?.value, 1.0)
        XCTAssertEqual(MinusOneToOne(0)?.value, 0)
        XCTAssertEqual(MinusOneToOne(0.0)?.value, 0.0)
        XCTAssertEqual(MinusOneToOne(-0.5)?.value, -0.5)
        XCTAssertEqual(MinusOneToOne(0.5)?.value, 0.5)
    }
}
