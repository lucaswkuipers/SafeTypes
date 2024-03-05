import XCTest
@testable import SafeTypes

final class NegativeTests: XCTestCase {

    // MARK: - Init

    func test_init_setsValueCorrectly(){
        XCTAssertNil(Negative(1))
        XCTAssertNil(Negative(12.3))
        XCTAssertNil(Negative(Float(12.3)))
        XCTAssertNil(Negative(Int.zero))
        XCTAssertNil(Negative(Double.zero))
        XCTAssertNil(Negative(Float.zero))
        XCTAssertEqual(Negative(-1)?.value, -1)
        XCTAssertEqual(Negative(-2.0)?.value, -2.0)
        XCTAssertEqual(Negative(-Float(123))?.value, -Float(123))
    }

    // MARK: - Multiplication

    func test_multiplication_returnsCorrectly() {
        XCTAssertEqual(Negative(-1)! * Negative(-1)!, Positive(1))
        XCTAssertEqual(Negative(-1)! * Positive(1)!, Negative(-1))
    }

    // MARK: - Addition

    func test_addition_returnsCorrectly() {
        XCTAssertEqual(Negative(-2)! + Negative(-3)!, Negative(-5))
    }

    // MARK: - Division

    func test_division_returnsCorrectly() {
        XCTAssertEqual(Negative(-10)! / Positive(2)!, NonPositive(-5)!)
    }

    // MARK: - IsMultiple

    func test_isMultiple_returnsCorrectly() {
        XCTAssertTrue(Negative(-9)!.isMultiple(of: 3))
        XCTAssertFalse(Negative(-9)!.isMultiple(of: 2))
    }

    // MARK: - Equatable

    func test_equatable_returnsCorrectly() {
        XCTAssertEqual(Negative(-1)!, Negative(-1))
        XCTAssertNotEqual(Negative(-1)!, Negative(-2))
    }

    // MARK: - Comparable

    func test_comparable_returnsCorrectly() {
        XCTAssertLessThan(Negative(-2)!, Negative(-1)!)
        XCTAssertGreaterThan(Negative(-1)!, Negative(-2)!)
        XCTAssertLessThanOrEqual(Negative(-2)!, Negative(-1)!)
        XCTAssertGreaterThanOrEqual(Negative(-1)!, Negative(-2)!)
    }
}
