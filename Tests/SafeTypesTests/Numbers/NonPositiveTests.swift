import XCTest
@testable import SafeTypes

final class NonPositiveTests: XCTestCase {

    // MARK: - Init

    func test_init_setsValueCorrectly(){
        XCTAssertNil(NonPositive(1))
        XCTAssertNil(NonPositive(12.3))
        XCTAssertNil(NonPositive(Float(12.3)))
        XCTAssertEqual(NonPositive(0)!.value, 0)
        XCTAssertEqual(NonPositive(0.0)!.value, 0.0)
        XCTAssertEqual(NonPositive(-1)?.value, -1)
        XCTAssertEqual(NonPositive(-2.0)?.value, -2.0)
        XCTAssertEqual(NonPositive(Float(-123))?.value, Float(-123))
    }

    // MARK: - Multiplication

    func test_multiplication_returnsCorrectly() {
        // NonPositive * NonPositive = NonNegative
        XCTAssertEqual(NonPositive(-1)! * NonPositive(-1)!, NonNegative(1)!)
        XCTAssertEqual(NonPositive(-1)! * NonPositive(-2)!, NonNegative(2)!)
        XCTAssertEqual(NonPositive(-2)! * NonPositive(-1)!, NonNegative(2.0)!)
        XCTAssertEqual(NonPositive(-3)! * NonPositive(-4)!, NonNegative(12)!)
        XCTAssertEqual(NonPositive(-4)! * NonPositive(-3.0)!, NonNegative(12)!)
        XCTAssertEqual(NonPositive(-7)! * NonPositive(-8)!, NonNegative(56)!)

        // NonPositive * Negative = NonPositive
        XCTAssertEqual(NonPositive(-1)! * Negative(-1)!, NonNegative(1)!)
        XCTAssertEqual(NonPositive(-1)! * Negative(-2)!, NonNegative(2)!)
        XCTAssertEqual(NonPositive(-2.0)! * Negative(-1)!, NonNegative(2)!)
        XCTAssertEqual(NonPositive(-3)! * Negative(-4)!, NonNegative(12)!)
        XCTAssertEqual(NonPositive(-4)! * Negative(-3)!, NonNegative(12)!)
        XCTAssertEqual(NonPositive(-7)! * Negative(-8)!, NonNegative(56)!)
    }

    // MARK: - Addition

    func test_addition_returnsCorrectly() {
        XCTAssertEqual(NonPositive(-1)! + NonPositive(-1)!, NonPositive(-2))
        XCTAssertEqual(NonPositive(-1)! + NonPositive(-2)!, NonPositive(-3))
        XCTAssertEqual(NonPositive(-2)! + NonPositive(-1)!, NonPositive(-3))
        XCTAssertEqual(NonPositive(-3)! + NonPositive(-4)!, NonPositive(-7))
        XCTAssertEqual(NonPositive(-7)! + NonPositive(-8)!, NonPositive(-15))
    }

    // MARK: - Equatable

    func test_equatable_returnsCorrectly() {
        XCTAssertEqual(NonPositive(-1)!, NonPositive(-1))
        XCTAssertNotEqual(NonPositive(-1)!, NonPositive(-2))
    }

    // MARK: - Comparable

    func test_comparable_returnsCorrectly() {
        XCTAssertLessThan(NonPositive(-2)!, NonPositive(-1)!)
        XCTAssertGreaterThan(NonPositive(-1)!, NonPositive(-2)!)
        XCTAssertLessThanOrEqual(NonPositive(-2)!, NonPositive(-1)!)
        XCTAssertGreaterThanOrEqual(NonPositive(-1)!, NonPositive(-2)!)
    }
}
