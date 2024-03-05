import XCTest
@testable import SafeTypes

final class ZeroToOneTests: XCTestCase {

    // MARK: - Init

    func test_init_setsValueCorrectly(){
        XCTAssertNil(ZeroToOne(1.1))
        XCTAssertNil(ZeroToOne(12.3))
        XCTAssertNil(ZeroToOne(-1))
        XCTAssertNil(ZeroToOne(-0.5))
        XCTAssertNil(ZeroToOne(-42))
        XCTAssertEqual(MinusOneToOne(0)?.value, 0)
        XCTAssertEqual(MinusOneToOne(1.0)?.value, 1.0)
        XCTAssertEqual(MinusOneToOne(0.1)?.value, 0.1)
        XCTAssertEqual(MinusOneToOne(0.0)?.value, 0.0)
        XCTAssertEqual(MinusOneToOne(0.5)?.value, 0.5)
        XCTAssertEqual(MinusOneToOne(0.65)?.value, 0.65)
    }
}
