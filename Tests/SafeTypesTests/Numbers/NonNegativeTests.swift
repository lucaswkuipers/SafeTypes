import XCTest
@testable import SafeTypes

final class NonNegativeTests: XCTestCase {

    // MARK: - Init

    func test_init_setsValueCorrectly(){
        XCTAssertNil(NonNegative(-1))
        XCTAssertNil(NonNegative(-12.3))
        XCTAssertNil(NonNegative(Float(-12.3)))
        XCTAssertEqual(NonNegative(0)!.value, 0)
        XCTAssertEqual(NonNegative(0.0)!.value, 0.0)
        XCTAssertEqual(NonNegative(1)?.value, 1)
        XCTAssertEqual(NonNegative(2.0)?.value, 2.0)
        XCTAssertEqual(NonNegative(Float(123))?.value, Float(123))
    }

    // MARK: - Multiplication

    func test_multiplication_returnsCorrectly() {
        // NonNegative * NonNegative = NonNegative
        XCTAssertEqual(NonNegative(1)! * NonNegative(1)!, NonNegative(1))
        XCTAssertEqual(NonNegative(1)! * NonNegative(2)!, NonNegative(2))
        XCTAssertEqual(NonNegative(2)! * NonNegative(1)!, NonNegative(2.0))
        XCTAssertEqual(NonNegative(3)! * NonNegative(4)!, NonNegative(12))
        XCTAssertEqual(NonNegative(4)! * NonNegative(3.0)!, NonNegative(12))
        XCTAssertEqual(NonNegative(7)! * NonNegative(8)!, NonNegative(56))

        // NonNegative * Negative = NonPositive
        XCTAssertEqual(NonNegative(1)! * Negative(-1.0)!, NonPositive(-1))
        XCTAssertEqual(NonNegative(1)! * Negative(-2)!, NonPositive(-2))
        XCTAssertEqual(NonNegative(2.0)! * Negative(-1)!, NonPositive(-2))
        XCTAssertEqual(NonNegative(3)! * Negative(-4)!, NonPositive(-12))
        XCTAssertEqual(NonNegative(4)! * Negative(-3)!, NonPositive(-12))
        XCTAssertEqual(NonNegative(7)! * Negative(-8)!, NonPositive(-56))
    }

    // MARK: - Addition

    func test_addition_returnsCorrectly() {
        XCTAssertEqual(NonNegative(1)! + NonNegative(1)!, NonNegative(2))
        XCTAssertEqual(NonNegative(1)! + NonNegative(2)!, NonNegative(3))
        XCTAssertEqual(NonNegative(2)! + NonNegative(1)!, NonNegative(3))
        XCTAssertEqual(NonNegative(3)! + NonNegative(4)!, NonNegative(7))
        XCTAssertEqual(NonNegative(7)! + NonNegative(8)!, NonNegative(15))
    }

    // MARK: - Equatable

    func test_equatable_returnsCorrectly() {
        XCTAssertEqual(NonNegative(1)!, NonNegative(1))
        XCTAssertNotEqual(NonNegative(1)!, NonNegative(2))
    }

    // MARK: - Comparable

    func test_comparable_returnsCorrectly() {
        XCTAssertLessThan(NonNegative(1)!, NonNegative(2)!)
        XCTAssertGreaterThan(NonNegative(2)!, NonNegative(1)!)
        XCTAssertLessThanOrEqual(NonNegative(1)!, NonNegative(2)!)
        XCTAssertGreaterThanOrEqual(NonNegative(2)!, NonNegative(1)!)
    }
}
