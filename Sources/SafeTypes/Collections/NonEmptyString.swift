public struct NonEmptyString {
    public var string: String {
        String(characters.items)
    }

    private var characters: NonEmptyArray<Character>

    public init(_ characters: NonEmptyArray<Character>) {
        self.characters = characters
    }

    public init?(_ string: String) {
        guard let characters = NonEmptyArray(Array(string)) else {
            return nil
        }
        self.characters = characters
    }
}

// MARK: - Array

extension NonEmptyString {
    public var capacity: Int {
        characters.capacity
    }

    public func withUnsafeBufferPointer<R>(_ body: (UnsafeBufferPointer<Character>) throws -> R) rethrows -> R {
        try characters.withUnsafeBufferPointer(body)
    }

    public func withUnsafeBytes<R>(_ body: (UnsafeRawBufferPointer) throws -> R) rethrows -> R {
        try characters.withUnsafeBytes(body)
    }

    public func filter(_ isIncluded: (Character) throws -> Bool) rethrows -> [Character] {
        try characters.filter(isIncluded)
    }

    public func dropLast(_ k: Int) -> ArraySlice<Element> {
        characters.dropLast(count)
    }

    public func suffix(_ maxLength: Int) -> ArraySlice<Element> {
        characters.suffix(maxLength)
    }

    public func dropFirst(_ k: Int = 1) -> ArraySlice<Element> {
        characters.dropFirst(k)
    }

    public func drop(while predicate: (Element) throws -> Bool) rethrows -> ArraySlice<Element> {
        try characters.drop(while: predicate)
    }

    public func prefix(_ maxLength: Int) -> ArraySlice<Element> {
        characters.prefix(maxLength)
    }

    public func prefix(while predicate: (Element) throws -> Bool) rethrows -> ArraySlice<Element> {
        try characters.prefix(while: predicate)
    }

    public func prefix(upTo end: Int) -> ArraySlice<Element> {
        characters.prefix(upTo: end)
    }

    public func suffix(from start: Int) -> ArraySlice<Element> {
        characters.suffix(from: start)
    }

    public func prefix(through position: Int) -> ArraySlice<Element> {
        characters.prefix(through: position)
    }

    public func split(maxSplits: Int = Int.max, omittingEmptySubsequences: Bool = true, whereSeparator isSeparator: (Element) throws -> Bool) rethrows -> [ArraySlice<Element>] {
        try characters.split(maxSplits: maxSplits, omittingEmptySubsequences: omittingEmptySubsequences, whereSeparator: isSeparator)
    }

    public var last: Element {
        characters.last
    }

    public func firstIndex(where predicate: (Element) throws -> Bool) rethrows -> Int? {
        try characters.firstIndex(where: predicate)
    }

    public func last(where predicate: (Element) throws -> Bool) rethrows -> Element? {
        try characters.last(where: predicate)
    }

    public func lastIndex(where predicate: (Element) throws -> Bool) rethrows -> Int? {
        try characters.lastIndex(where: predicate)
    }

    public func shuffled<T>(using generator: inout T) -> NonEmptyString where T : RandomNumberGenerator {
        NonEmptyString(characters.shuffled(using: &generator))
    }

    public var isEmpty: Bool { false }

    public var first: Element {
        characters.first
    }

    public var count: Positive<Int> {
        characters.count
    }

    public func reversed() -> NonEmptyString {
        NonEmptyString(characters.reversed())
    }

    public func index(_ i: Int, offsetBy distance: Int) -> Int {
        characters.index(i, offsetBy: distance)
    }

    public func index(_ i: Int, offsetBy distance: Int, limitedBy limit: Int) -> Int? {
        characters.index(i, offsetBy: distance, limitedBy: limit)
    }

    public var lazy: LazySequence<Array<Element>> {
        characters.lazy
    }

    // MARK: - Mutating

    public mutating func popLast() -> Element? {
        guard count > 1 else {
            return nil
        }

        return characters.popLast()
    }

    public mutating func removeLast(_ k: Int) {
        guard k < count else {
            characters.removeLast(count - 1)
            return
        }

        characters.removeLast(k)
    }

    public mutating func removeFirst() -> Element? {
        guard count > 1 else {
            return nil
        }

        return characters.removeFirst()
    }

    public mutating func removeFirst(_ k: Int) {
        guard count > k else {
            removeFirst(count - 1)
            return
        }

        return characters.removeFirst(k)
    }

    public mutating func partition(by belongsInSecondPartition: (Element) throws -> Bool) rethrows -> Int {
        try characters.partition(by: belongsInSecondPartition)
    }

    public mutating func shuffle<T>(using generator: inout T) where T : RandomNumberGenerator {
        characters.shuffle()
    }

    public func shuffled() -> NonEmptyString {
        NonEmptyString(characters.shuffled())
    }

    public mutating func swapAt(_ i: Int, _ j: Int) {
        characters.swapAt(i, j)
    }

    public mutating func append(_ newElement: Element) {
        characters.append(newElement)
    }

    public mutating func append(_ newElements: Element...) {
        characters.append(contentsOf: newElements)
    }

    public mutating func append<S>(contentsOf newElements: S) where S : Sequence, Element == S.Element{
        characters.append(contentsOf: newElements)
    }

    public mutating func insert(_ newElement: Element, at i: Int){
        characters.insert(newElement, at: i)
    }

    public mutating func remove(at i: Int) -> Element? {
        guard characters.count > 1 else {
            return nil
        }

        guard characters.indices.contains(i) else {
            return nil
        }

        return characters.remove(at: i)
    }

    // MARK: - Static

    public static func +<S>(lhs: NonEmptyString, rhs: S) -> NonEmptyString where S : Sequence, Element == S.Element {
        NonEmptyString(lhs.characters + rhs)
    }

    public static func +=(lhs: inout NonEmptyString, rhs: NonEmptyString) {
        lhs.append(contentsOf: rhs.characters)
    }
}

// MARK: - Sequence

extension NonEmptyString: Sequence {
    public func makeIterator() -> IndexingIterator<[Character]> {
        characters.makeIterator()
    }
}

extension NonEmptyString: Collection {
    public var startIndex: Int {
        0
    }

    public var endIndex: Int {
        characters.endIndex
    }

    public func randomElement<T>(using generator: inout T) -> Character where T : RandomNumberGenerator {
        characters.randomElement(using: &generator)
    }

    public func randomElement() -> Character {
        characters.randomElement()
    }

    public func max() -> Character  {
        characters.max()
    }

    public func max(by areInIncreasingOrder: (Character, Character) throws -> Bool) rethrows -> Character {
        try characters.max(by: areInIncreasingOrder)
    }

    public func min() -> Character {
        characters.min()
    }

    public func min(by areInIncreasingOrder: (Character, Character) throws -> Bool) rethrows -> Character {
        try characters.min(by: areInIncreasingOrder)
    }

    public func sorted(by areInIncreasingOrder: (Character, Character) throws -> Bool) rethrows -> NonEmptyString {
        NonEmptyString(try characters.sorted(by: areInIncreasingOrder))
    }
}

// MARK: - MutableCollection

extension NonEmptyString: MutableCollection {
    public subscript(position: Int) -> Character {
        get {
            return characters[position]
        }
        set {
            return characters[position] = newValue
        }
    }
}

// MARK: - BidirectionalCollection

extension NonEmptyString: BidirectionalCollection {
    public func index(before i: Int) -> Int {
        i - 1
    }

    public func index(after i: Int) -> Int {
        i + 1
    }
}

// MARK: - CustomStringConvertible

extension NonEmptyString: CustomStringConvertible {
    public var description: String {
        string.description
    }
}

// MARK: - CustomDebugStringConvertible

extension NonEmptyString: CustomDebugStringConvertible {
    public var debugDescription: String {
        string.debugDescription
    }
}

// MARK: - Comparable

extension NonEmptyString: Comparable {
    public static func < (lhs: NonEmptyString, rhs: NonEmptyString) -> Bool {
        lhs.string < rhs.string
    }
}

// MARK: - RandomAccessCollection

extension NonEmptyString: RandomAccessCollection {}

// MARK: - Equatable

extension NonEmptyString: Equatable {}

// MARK: - Hashable

extension NonEmptyString: Hashable {}

// MARK: - Sendable

extension NonEmptyString: Sendable {}

// MARK: - Codable

extension NonEmptyString: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let string = try container.decode(String.self)

        guard let value = NonEmptyString(string) else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Empty string is invalid.")
        }

        self = value
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.string)
    }
}
