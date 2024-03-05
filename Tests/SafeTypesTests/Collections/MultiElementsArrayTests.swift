import XCTest
@testable import SafeTypes

final class MultiElementsArrayTests: XCTestCase {

    // MARK: - Init

    func test_init_setsItemsCorrectly() {
        XCTAssertNil(MultiElementsArray<Any>([]))
        XCTAssertEqual(MultiElementsArray(1, 2).items, [1, 2])
        XCTAssertEqual(MultiElementsArray(1, 2, 3).items, [1, 2, 3])
        XCTAssertEqual(MultiElementsArray(1, 2, 3, 4).items, [1, 2, 3, 4])
        XCTAssertEqual(MultiElementsArray(MultiElementsArray(1, 2), MultiElementsArray(3, 4)), MultiElementsArray(1, 2, 3, 4))
        XCTAssertNil(MultiElementsArray(repeating: 1, count: -1))
        XCTAssertNil(MultiElementsArray(repeating: 1, count: 0))
        XCTAssertNil(MultiElementsArray(repeating: 1, count: 1))
        XCTAssertEqual(MultiElementsArray(repeating: 1, count: 2), MultiElementsArray(1, 1))
    }

    // MARK: - Array

    func test_isEmpty_returnsFalse() {
        XCTAssertFalse(MultiElementsArray(1, 2).isEmpty)
        XCTAssertFalse(MultiElementsArray(1, 2, 3).isEmpty)
        XCTAssertFalse(MultiElementsArray(1, 2, 3, 4).isEmpty)
    }

    func test_first_returnsCorrectly() {
        XCTAssertEqual(MultiElementsArray(2, 1).first, 2)
        XCTAssertEqual(MultiElementsArray(3, 2, 1).first, 3)
        XCTAssertEqual(MultiElementsArray(4, 3, 2, 1).first, 4)
    }

    func test_last_returnsCorrectly() {
        XCTAssertEqual(MultiElementsArray(1, 2).last, 2)
        XCTAssertEqual(MultiElementsArray(1, 2, 3).last, 3)
        XCTAssertEqual(MultiElementsArray(1, 2, 3, 4).last, 4)
    }

    func test_count_returnsCorrectly() {
        XCTAssertEqual(MultiElementsArray(1, 2).count, 2)
        XCTAssertEqual(MultiElementsArray(1, 2, 3).count, 3)
        XCTAssertEqual(MultiElementsArray(1, 2, 3, 4).count, 4)
    }

    func test_append_appendsItemsCorrectly() {
        var sut = MultiElementsArray(1, 2)
        XCTAssertEqual(sut.items, [1, 2])

        sut.append(3)
        XCTAssertEqual(sut.items, [1, 2, 3])

        sut.append(4, 5)
        XCTAssertEqual(sut.items, [1, 2, 3, 4, 5])

        sut.append(6, 7, 8)
        XCTAssertEqual(sut.items, [1, 2, 3, 4, 5, 6, 7, 8])

        sut.append(contentsOf: NonEmptyArray(9, 10))
        XCTAssertEqual(sut.items, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
    }

    func test_insert_insertsItemsCorrectly() {
        var sut = MultiElementsArray(1, 2)

        sut.insert(3, at: 2)
        XCTAssertEqual(sut.items, [1, 2, 3])

        XCTAssertEqual(sut.items, [1, 2, 3])

        sut.insert(4, at: 3)
        XCTAssertEqual(sut.items, [1, 2, 3, 4])

        sut.insert(0, at: 0)
        XCTAssertEqual(sut.items, [0, 1, 2, 3, 4])

        sut.insert(123, at: 0)
        XCTAssertEqual(sut.items, [123, 0, 1, 2, 3, 4])
    }

    func test_comparable_correctlyComparesNonEmptyArrays() {
        XCTAssertFalse(MultiElementsArray(1, 2) < MultiElementsArray(1, 2))
        XCTAssertFalse(MultiElementsArray(1, 2) > MultiElementsArray(1, 2))

        XCTAssertTrue(MultiElementsArray(1, 2) < MultiElementsArray(2, 1))
        XCTAssertFalse(MultiElementsArray(1, 2) > MultiElementsArray(2, 1))

        XCTAssertTrue(MultiElementsArray(1, 2) < MultiElementsArray(1, 2, 3))
        XCTAssertFalse(MultiElementsArray(1, 2) > MultiElementsArray(1, 2, 3))

        XCTAssertFalse(MultiElementsArray(1, 2, 3) < MultiElementsArray(1, 2))
        XCTAssertTrue(MultiElementsArray(1, 2, 3) > MultiElementsArray(1, 2))
    }

    func test_remove_returnsCorrectly() {
        var sut = MultiElementsArray(1, 2, 3)

        XCTAssertEqual(sut.remove(at: 2), 3)
        XCTAssertNil(sut.remove(at: 0))
        XCTAssertNil(sut.remove(at: 0))
        XCTAssertNil(sut.remove(at: 0))
        XCTAssertEqual(sut.items, [1, 2])
        XCTAssertEqual(sut.count, 2)
        XCTAssertFalse(sut.isEmpty)
    }

    func test_remove_whenOutOfBounds_returnsNil() {
        var sut = MultiElementsArray(1, 2, 3)

        XCTAssertNil(sut.remove(at: -1))
        XCTAssertNil(sut.remove(at: 42))
        XCTAssertEqual(sut.items, [1, 2, 3])
        XCTAssertEqual(sut.count, 3)
        XCTAssertFalse(sut.isEmpty)
    }

    func test_addition_returnsCorrectly() {
        var sut = MultiElementsArray(1, 2)

        sut += NonEmptyArray(3)
        XCTAssertEqual(sut, MultiElementsArray(1, 2, 3))

        sut += MultiElementsArray(4, 5)
        XCTAssertEqual(sut, MultiElementsArray(1, 2, 3, 4, 5))

        XCTAssertEqual(MultiElementsArray(1, 2) + MultiElementsArray(3, 4), MultiElementsArray(1, 2, 3, 4))
        XCTAssertEqual(MultiElementsArray("A", "B") + NonEmptyArray("C"), MultiElementsArray("A", "B", "C"))
        XCTAssertEqual(MultiElementsArray("A", "B") + ["C"], MultiElementsArray("A", "B", "C"))
    }

    func test_reversed_returnsCorrectly() {
        XCTAssertEqual(MultiElementsArray(1, 2, 3).reversed(), MultiElementsArray(3, 2, 1))
        XCTAssertEqual(MultiElementsArray(1, 2, 3).reversed().reversed(), MultiElementsArray(1, 2, 3))
        XCTAssertEqual(MultiElementsArray(3, 2, 1).reversed(), MultiElementsArray(1, 2, 3))
    }

    func test_random_returnsElementContained() {
        let sut = MultiElementsArray(1, 2, 3, 4, 5)

        XCTAssertTrue(sut.contains(sut.randomElement()))
        XCTAssertTrue(sut.contains(sut.randomElement()))
        XCTAssertTrue(sut.contains(sut.randomElement()))
        XCTAssertTrue(sut.contains(sut.randomElement()))
        XCTAssertTrue(sut.contains(sut.randomElement()))
        XCTAssertTrue(sut.contains(sut.randomElement()))
        XCTAssertTrue(sut.contains(sut.randomElement()))
        XCTAssertTrue(sut.contains(sut.randomElement()))
        XCTAssertTrue(sut.contains(sut.randomElement()))
        XCTAssertTrue(sut.contains(sut.randomElement()))
        XCTAssertTrue(sut.contains(sut.randomElement()))
        XCTAssertTrue(sut.contains(sut.randomElement()))
        XCTAssertTrue(sut.contains(sut.randomElement()))
        XCTAssertTrue(sut.contains(sut.randomElement()))
    }

    // MARK: - Sequence

    func test_forIn_loopsCorrectly() {
        let sut = MultiElementsArray(1, 2, 3)

        var items: [Int] = []
        for item in sut {
            items.append(item)
        }

        XCTAssertEqual(items, sut.items)
    }

    func test_forEach_loopsCorrectly() {
        let sut = MultiElementsArray(1, 2, 3)

        var items: [Int] = []
        sut.forEach {
            items.append($0)
        }

        XCTAssertEqual(items, sut.items)
    }

    func test_map_mapsCorrectly() {
        let sut = MultiElementsArray(1, 2, 3)

        let items = sut.map { $0 }

        XCTAssertEqual(items, sut.items)
    }

    func test_reduce_reducesItemsCorrectly() {
        let sut = MultiElementsArray(1, 2, 3)

        let sum = sut.reduce(0, +)

        XCTAssertEqual(sum, 6)
    }

    // MARK: - Collection

    func test_startIndex_returnsZero() {
        XCTAssertEqual(MultiElementsArray(1, 2).startIndex, 0)
        XCTAssertEqual(MultiElementsArray(1, 2, 3).startIndex, 0)
        XCTAssertEqual(MultiElementsArray(1, 2, 3, 4).startIndex, 0)
    }

    func test_endIndex_returnsCorrectly() {
        XCTAssertEqual(MultiElementsArray(1, 2).endIndex, 2)
        XCTAssertEqual(MultiElementsArray(1, 2, 3).endIndex, 3)
        XCTAssertEqual(MultiElementsArray(1, 2, 3, 4).endIndex, 4)
    }

    // MARK: - MutableCollection

    func test_subscriptPosition_accessCorrectElement() {
        var sut = MultiElementsArray(1, 2, 3, 4)

        XCTAssertEqual(sut[0], 1)
        XCTAssertEqual(sut[1], 2)
        XCTAssertEqual(sut[2], 3)
        XCTAssertEqual(sut[3], 4)

        sut[0] = 4
        sut[1] = 3
        sut[2] = 2
        sut[3] = 1

        XCTAssertEqual(sut[0], 4)
        XCTAssertEqual(sut[1], 3)
        XCTAssertEqual(sut[2], 2)
        XCTAssertEqual(sut[3], 1)
    }

    func test_max_returnsCorrectly() {
        let sut = MultiElementsArray(1, 2, 3)

        XCTAssertEqual(sut.max(), 3)
    }
}
