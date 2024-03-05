import XCTest
@testable import SafeTypes

final class NonEmptyStringTests: XCTestCase {

    // MARK: - Init

    func test_init_setsItemsCorrectly() {
        XCTAssertNil(NonEmptyString(""))
        XCTAssertEqual(NonEmptyString(" ")?.string, " ")
        XCTAssertEqual(NonEmptyString(" a ")?.string, " a ")
        XCTAssertEqual(NonEmptyString("hey")?.string, "hey")
    }

    // MARK: - Array

    func test_isEmpty_returnsFalse() {
        XCTAssertFalse(NonEmptyString("a")!.isEmpty)
        XCTAssertFalse(NonEmptyString("ab")!.isEmpty)
        XCTAssertFalse(NonEmptyString(" ")!.isEmpty)
    }

    func test_count_returnsCorrectly() {
        XCTAssertEqual(NonEmptyString(" ")?.string.count, 1)
        XCTAssertEqual(NonEmptyString(" a ")?.string.count, 3)
        XCTAssertEqual(NonEmptyString("hey")?.string.count, 3)
    }

    func test_append_appendsItemsCorrectly() {
        var sut = NonEmptyString("a")!

        sut.append("b")
        XCTAssertEqual(sut.string, "ab")

        sut.append("c", "d")
        XCTAssertEqual(sut.string, "abcd")

        sut.append("ef")
        XCTAssertEqual(sut.string, "abcdef")

        sut.append(contentsOf: NonEmptyString("gh")!)
        XCTAssertEqual(sut.string, "abcdefgh")
    }

    func test_insert_insertsItemsCorrectly() {
        var sut = NonEmptyString("a")!

        sut.insert("c", at: 1)
        XCTAssertEqual(sut.string, "ac")

        sut.insert("b", at: 1)

        XCTAssertEqual(sut.string, "abc")

        sut.insert("d", at: 3)
        XCTAssertEqual(sut.string, "abcd")


        sut.insert(" ", at: 0)
        XCTAssertEqual(sut.string, " abcd")
    }

    func test_comparable_correctlyComparesNonEmptyStrings() {
        XCTAssertFalse(NonEmptyString("ab")! < NonEmptyString("ab")!)
        XCTAssertFalse(NonEmptyString("ab")! > NonEmptyString("ab")!)

        XCTAssertTrue(NonEmptyString("a")! < NonEmptyString("b")!)
        XCTAssertFalse(NonEmptyString("a")! > NonEmptyString("b")!)

        XCTAssertFalse(NonEmptyString("ab")! < NonEmptyString("a")!)
        XCTAssertTrue(NonEmptyString("ab")! > NonEmptyString("a")!)
    }

    func test_remove_returnsCorrectly() {
        var sut = NonEmptyString("abc")!

        XCTAssertEqual(sut.remove(at: 2), "c")
        XCTAssertEqual(sut.remove(at: 1), "b")
        XCTAssertNil(sut.remove(at: 0))
        XCTAssertNil(sut.remove(at: 0))
        XCTAssertEqual(sut.string, "a")
        XCTAssertEqual(sut.count, 1)
        XCTAssertFalse(sut.isEmpty)
    }

    func test_remove_whenOutOfBounds_returnsNil() {
        var sut = NonEmptyString("abc")!

        XCTAssertNil(sut.remove(at: -1))
        XCTAssertNil(sut.remove(at: 42))
        XCTAssertEqual(sut.string, "abc")
        XCTAssertEqual(sut.count, 3)
        XCTAssertFalse(sut.isEmpty)
    }

    func test_addition_returnsCorrectly() {
        var sut = NonEmptyString("a")!

        sut += NonEmptyString("b")!
        XCTAssertEqual(sut, NonEmptyString("ab"))

        sut += NonEmptyString("c")!
        XCTAssertEqual(sut, NonEmptyString("abc")!)

        XCTAssertEqual(NonEmptyString("ab")! + NonEmptyString("cd")!, NonEmptyString("abcd")!)
        XCTAssertEqual(NonEmptyString("Foo")! + NonEmptyString("Bar")!, NonEmptyString("FooBar")!)
        XCTAssertEqual(NonEmptyString("Foo")! + "Bar", NonEmptyString("FooBar")!)
    }

    func test_reversed_returnsCorrectly() {
        XCTAssertEqual(NonEmptyString("abc")!.reversed(), NonEmptyString("cba")!)
        XCTAssertEqual(NonEmptyString("abc")!.reversed().reversed(), NonEmptyString("abc")!)
        XCTAssertEqual(NonEmptyString("a")!.reversed(), NonEmptyString("a")!)
    }

    func test_random_returnsElementContained() {
        let sut = NonEmptyString("abc")!

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
        let sut = NonEmptyString("abc")!

        var string = ""
        for character in sut {
            string.append(character)
        }

        XCTAssertEqual(string, sut.string)
    }

    func test_forEach_loopsCorrectly() {
        let sut = NonEmptyString("abc")!

        var string = ""
        sut.forEach {
            string.append($0)
        }

        XCTAssertEqual(string, sut.string)
    }

    func test_map_mapsCorrectly() {
        let sut = NonEmptyString("abc")!

        let string = sut.map { $0 }

        XCTAssertEqual(String(string), sut.string)
    }

    func test_reduce_reducesItemsCorrectly() {
        let sut = NonEmptyString("abc")!

        let string = sut.reduce("") { $0 + String($1) }

        XCTAssertEqual(string, sut.string)
    }

    // MARK: - Collection

    func test_startIndex_returnsZero() {
        XCTAssertEqual(NonEmptyString("a")!.startIndex, 0)
        XCTAssertEqual(NonEmptyString("ab")!.startIndex, 0)
        XCTAssertEqual(NonEmptyString("abc")!.startIndex, 0)
        XCTAssertEqual(NonEmptyString("abcd")!.startIndex, 0)
    }

    func test_endIndex_returnsCorrectly() {
        XCTAssertEqual(NonEmptyString("a")!.endIndex, 1)
        XCTAssertEqual(NonEmptyString("ab")!.endIndex, 2)
        XCTAssertEqual(NonEmptyString("abc")!.endIndex, 3)
        XCTAssertEqual(NonEmptyString("abcd")!.endIndex, 4)
    }

    // MARK: - MutableCollection

    func test_subscriptPosition_accessCorrectElement() {
        var sut = NonEmptyString("abcd")!

        XCTAssertEqual(sut[0], "a")
        XCTAssertEqual(sut[1], "b")
        XCTAssertEqual(sut[2], "c")
        XCTAssertEqual(sut[3], "d")

        sut[0] = "d"
        sut[1] = "c"
        sut[2] = "b"
        sut[3] = "a"

        XCTAssertEqual(sut[0], "d")
        XCTAssertEqual(sut[1], "c")
        XCTAssertEqual(sut[2], "b")
        XCTAssertEqual(sut[3], "a")
    }

    func test_max_returnsCorrectly() {
        let sut = NonEmptyString("abc")!

        XCTAssertEqual(sut.max(), "c")
    }
}
