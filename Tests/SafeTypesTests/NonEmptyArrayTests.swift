import XCTest
import SafeTypes

final class NonEmptyArrayTests: XCTestCase {

    // MARK: - Init

    func test_init_setsItemsCorrectly() {
        XCTAssertNil(NonEmptyArray<Any>([]))
        XCTAssertEqual(NonEmptyArray(1).items, [1])
        XCTAssertEqual(NonEmptyArray(1, 2).items, [1, 2])
        XCTAssertEqual(NonEmptyArray(1, 2, 3).items, [1, 2, 3])
        XCTAssertEqual(NonEmptyArray(1, 2, 3, 4).items, [1, 2, 3, 4])
    }

    func test_first_returnsCorrectly() {
        XCTAssertEqual(NonEmptyArray(1).first, 1)
        XCTAssertEqual(NonEmptyArray(2, 1).first, 2)
        XCTAssertEqual(NonEmptyArray(3, 2, 1).first, 3)
        XCTAssertEqual(NonEmptyArray(4, 3, 2, 1).first, 4)
    }

    func test_last_returnsCorrectly() {
        XCTAssertEqual(NonEmptyArray(1).last, 1)
        XCTAssertEqual(NonEmptyArray(1, 2).last, 2)
        XCTAssertEqual(NonEmptyArray(1, 2, 3).last, 3)
        XCTAssertEqual(NonEmptyArray(1, 2, 3, 4).last, 4)
    }

    func test_count_returnsCorrectly() {
        XCTAssertEqual(NonEmptyArray(1).count, 1)
        XCTAssertEqual(NonEmptyArray(1, 2).count, 2)
        XCTAssertEqual(NonEmptyArray(1, 2, 3).count, 3)
        XCTAssertEqual(NonEmptyArray(1, 2, 3, 4).count, 4)
    }

    // MARK: - Sequence

    func test_forIn_loopsCorrectly() {
        let sut = NonEmptyArray(1, 2, 3)

        var items: [Int] = []
        for item in sut {
            items.append(item)
        }

        XCTAssertEqual(items, sut.items)
    }

    func test_forEach_loopsCorrectly() {
        let sut = NonEmptyArray(1, 2, 3)

        var items: [Int] = []
        sut.forEach {
            items.append($0)
        }

        XCTAssertEqual(items, sut.items)
    }

    func test_map_mapsCorrectly() {
        let sut = NonEmptyArray(1, 2, 3)

        let items = sut.map { $0 }

        XCTAssertEqual(items, sut.items)
    }

    func test_reduce_reducesItemsCorrectly() {
        let sut = NonEmptyArray(1, 2, 3)

        let sum = sut.reduce(0, +)

        XCTAssertEqual(sum, 6)
    }

    // MARK: - Other

    func test_remove_returnsCorrectly() {
        var sut = NonEmptyArray(1,2,3)

        XCTAssertEqual(sut.remove(at: 2), 3)
        XCTAssertEqual(sut.remove(at: 1), 2)
        XCTAssertNil(sut.remove(at: 0))
        XCTAssertNil(sut.remove(at: 0))
        XCTAssertEqual(sut.items, [1])
        XCTAssertEqual(sut.count, 1)
    }

    func test_reversed_returnsCorrectly() {
        XCTAssertEqual(NonEmptyArray(1, 2, 3).reversed(), NonEmptyArray(3, 2, 1))
        XCTAssertEqual(NonEmptyArray(1, 2, 3).reversed().reversed(), NonEmptyArray(1, 2, 3))
        XCTAssertEqual(NonEmptyArray(3, 2, 1).reversed(), NonEmptyArray(1, 2, 3))
    }
}
