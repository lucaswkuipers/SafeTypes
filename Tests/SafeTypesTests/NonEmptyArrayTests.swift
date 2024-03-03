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
        XCTAssertEqual(NonEmptyArray(NonEmptyArray(1, 2), NonEmptyArray(3, 4)), NonEmptyArray(1, 2, 3, 4))
    }

    // MARK: - Array

    func test_isEmpty_returnsFalse() {
        XCTAssertFalse(NonEmptyArray(1).isEmpty)
        XCTAssertFalse(NonEmptyArray(1, 2).isEmpty)
        XCTAssertFalse(NonEmptyArray(1, 2, 3).isEmpty)
        XCTAssertFalse(NonEmptyArray(1, 2, 3, 4).isEmpty)
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

    func test_append_appendsItemsCorrectly() {
        var sut = NonEmptyArray(1)

        sut.append(2)
        XCTAssertEqual(sut.items, [1, 2])

        sut.append(3, 4)
        XCTAssertEqual(sut.items, [1, 2, 3, 4])

        sut.append(5, 6, 7)
        XCTAssertEqual(sut.items, [1, 2, 3, 4, 5, 6, 7])

        sut.append(contentsOf: NonEmptyArray(8, 9))
        XCTAssertEqual(sut.items, [1, 2, 3, 4, 5, 6, 7, 8, 9])
    }

    func test_insert_insertsItemsCorrectly() {
        var sut = NonEmptyArray(1)

        sut.insert(3, at: 1)
        XCTAssertEqual(sut.items, [1, 3])

        sut.insert(2, at: 1)
        XCTAssertEqual(sut.items, [1, 2, 3])

        sut.insert(4, at: 3)
        XCTAssertEqual(sut.items, [1, 2, 3, 4])

        sut.insert(0, at: 0)
        XCTAssertEqual(sut.items, [0, 1, 2, 3, 4])
    }

    func test_comparable_correctlyComparesNonEmptyArrays() {
        XCTAssertFalse(NonEmptyArray(1, 2) < NonEmptyArray(1, 2))
        XCTAssertFalse(NonEmptyArray(1, 2) > NonEmptyArray(1, 2))

        XCTAssertTrue(NonEmptyArray(1, 2) < NonEmptyArray(2, 1))
        XCTAssertFalse(NonEmptyArray(1, 2) > NonEmptyArray(2, 1))

        XCTAssertTrue(NonEmptyArray(1) < NonEmptyArray(1, 2))
        XCTAssertFalse(NonEmptyArray(1) > NonEmptyArray(1, 2))

        XCTAssertFalse(NonEmptyArray(1, 2) < NonEmptyArray(1))
        XCTAssertTrue(NonEmptyArray(1, 2) > NonEmptyArray(1))
    }

    func test_remove_returnsCorrectly() {
        var sut = NonEmptyArray(1,2,3)

        XCTAssertEqual(sut.remove(at: 2), 3)
        XCTAssertEqual(sut.remove(at: 1), 2)
        XCTAssertNil(sut.remove(at: 0))
        XCTAssertNil(sut.remove(at: 0))
        XCTAssertEqual(sut.items, [1])
        XCTAssertEqual(sut.count, 1)
        XCTAssertFalse(sut.isEmpty)
    }

    func test_remove_whenOutOfBounds_returnsNil() {
        var sut = NonEmptyArray(1,2,3)

        XCTAssertNil(sut.remove(at: -1))
        XCTAssertNil(sut.remove(at: 42))
        XCTAssertEqual(sut.items, [1, 2, 3])
        XCTAssertEqual(sut.count, 3)
        XCTAssertFalse(sut.isEmpty)
    }

    func test_addition_returnsCorrectly() {
        var sut = NonEmptyArray(1)

        sut += NonEmptyArray(2)
        XCTAssertEqual(sut, NonEmptyArray(1, 2))

        sut += NonEmptyArray(3)
        XCTAssertEqual(sut, NonEmptyArray(1, 2, 3))

        XCTAssertEqual(NonEmptyArray(1, 2) + NonEmptyArray(3, 4), NonEmptyArray(1, 2, 3, 4))
        XCTAssertEqual(NonEmptyArray("Foo") + NonEmptyArray("Bar"), NonEmptyArray("Foo", "Bar"))
        XCTAssertEqual(NonEmptyArray("Foo") + ["Bar"], NonEmptyArray("Foo", "Bar"))
    }

    func test_reversed_returnsCorrectly() {
        XCTAssertEqual(NonEmptyArray(1, 2, 3).reversed(), NonEmptyArray(3, 2, 1))
        XCTAssertEqual(NonEmptyArray(1, 2, 3).reversed().reversed(), NonEmptyArray(1, 2, 3))
        XCTAssertEqual(NonEmptyArray(3, 2, 1).reversed(), NonEmptyArray(1, 2, 3))
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

    // MARK: - Collection

    func test_startIndex_returnsZero() {
        XCTAssertEqual(NonEmptyArray(1).startIndex, 0)
        XCTAssertEqual(NonEmptyArray(1, 2).startIndex, 0)
        XCTAssertEqual(NonEmptyArray(1, 2, 3).startIndex, 0)
        XCTAssertEqual(NonEmptyArray(1, 2, 3, 4).startIndex, 0)
    }

    func test_endIndex_returnsCorrectly() {
        XCTAssertEqual(NonEmptyArray(1).endIndex, 1)
        XCTAssertEqual(NonEmptyArray(1, 2).endIndex, 2)
        XCTAssertEqual(NonEmptyArray(1, 2, 3).endIndex, 3)
        XCTAssertEqual(NonEmptyArray(1, 2, 3, 4).endIndex, 4)
    }

    // MARK: - MutableCollection

    func test_subscriptPosition_accessCorrectElement() {
        var sut = NonEmptyArray(1, 2, 3, 4)

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
}
