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

    // MARK: - Multiplication

    func test_multiplication_returnsCorrectly() {
        // Positive * Positive = Positive (Int)
        XCTAssertEqual(Positive(1)! * Positive(1)!, Positive(1))
        XCTAssertEqual(Positive(1)! * Positive(2)!, Positive(2))
        XCTAssertEqual(Positive(2)! * Positive(1)!, Positive(2))
        XCTAssertEqual(Positive(3)! * Positive(4)!, Positive(12))
        XCTAssertEqual(Positive(4)! * Positive(3)!, Positive(12))
        XCTAssertEqual(Positive(7)! * Positive(8)!, Positive(56))

        // Positive * Negative = Negative (Int)
        XCTAssertEqual(Positive(1)! * Negative(-1)!, Negative(-1))
        XCTAssertEqual(Positive(1)! * Negative(-2)!, Negative(-2))
        XCTAssertEqual(Positive(2)! * Negative(-1)!, Negative(-2))
        XCTAssertEqual(Positive(3)! * Negative(-4)!, Negative(-12))
        XCTAssertEqual(Positive(4)! * Negative(-3)!, Negative(-12))
        XCTAssertEqual(Positive(7)! * Negative(-8)!, Negative(-56))

        // Positive * Positive = NonNegative (Double)
        XCTAssertEqual(Positive(0.5)! * Positive(1)!, NonNegative(0.5))
        XCTAssertEqual(Positive(0.5)! * Positive(0.5)!, NonNegative(0.25))
        XCTAssertEqual(Positive(0.01)! * Positive(0.01)!, NonNegative(0.0001))
        XCTAssertEqual(Positive(1.5)! * Positive(1.5)!, NonNegative(2.25))
        XCTAssertEqual(Positive(4.0)! * Positive(3.0)!, NonNegative(12))
        XCTAssertEqual(Positive(7.0)! * Positive(8)!, NonNegative(56.0))

        // Positive * Negative = NonPositive (Double)
        XCTAssertEqual(Positive(0.5)! * Negative(-1)!, NonPositive(-0.5))
        XCTAssertEqual(Positive(0.5)! * Negative(-0.5)!, NonPositive(-0.25))
        XCTAssertEqual(Positive(0.01)! * Negative(-0.01)!, NonPositive(-0.0001))
        XCTAssertEqual(Positive(1.5)! * Negative(-1.5)!, NonPositive(-2.25))
        XCTAssertEqual(Positive(4.0)! * Negative(-3.0)!, NonPositive(-12))
        XCTAssertEqual(Positive(7.0)! * Negative(-8)!, NonPositive(-56.0))
    }

    // MARK: - Addition

    func test_addition_returnsCorrectly() {
        XCTAssertEqual(Positive(1)! + Positive(1)!, Positive(2))
        XCTAssertEqual(Positive(1)! + Positive(2)!, Positive(3))
        XCTAssertEqual(Positive(2)! + Positive(1)!, Positive(3))
        XCTAssertEqual(Positive(3)! + Positive(4)!, Positive(7))
        XCTAssertEqual(Positive(7)! + Positive(8)!, Positive(15))
    }

    // MARK: - Division

    func test_division_returnsCorrectly() {
        XCTAssertEqual(Positive(1)! / Positive(2.0)!, NonNegative(0.5))
        XCTAssertEqual(Positive(1)! / Positive(1)!, NonNegative(1))
        XCTAssertEqual(Positive(1)! / Positive(0.1)!, NonNegative(10))

        XCTAssertEqual(Positive(1)! / Negative(-2.0)!, NonPositive(-0.5))
        XCTAssertEqual(Positive(1)! / Negative(-1)!, NonPositive(-1))
        XCTAssertEqual(Positive(1)! / Negative(-0.1)!, NonPositive(-10))
    }

    // MARK: - Modulo

    func test_modulo_returnsCorrectly() {
        XCTAssertEqual(Positive(10)! % Positive(3)!, NonNegative(1))
        XCTAssertEqual(Positive(15)! % Positive(5)!, NonNegative(0))
    }

    // MARK: - IsMultiple

    func test_isMultiple_returnsCorrectly() {
        XCTAssertTrue(Positive(9)!.isMultiple(of: 3))
        XCTAssertFalse(Positive(9)!.isMultiple(of: 2))
    }

    // MARK: - Equatable

    func test_equatable_returnsCorrectly() {
        XCTAssertEqual(Positive(1)!, Positive(1))
        XCTAssertNotEqual(Positive(1)!, Positive(2))
    }

    // MARK: - Comparable

    func test_comparable_returnsCorrectly() {
        XCTAssertLessThan(Positive(1)!, Positive(2)!)
        XCTAssertGreaterThan(Positive(2)!, Positive(1)!)
        XCTAssertLessThanOrEqual(Positive(1)!, Positive(2)!)
        XCTAssertGreaterThanOrEqual(Positive(2)!, Positive(1)!)
    }
}
