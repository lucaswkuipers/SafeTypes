public struct MultiElementsArray<Element> {
    public private(set) var items: [Element] {
        get {
            [head, second] + tail
        }
        set {
            guard let head = newValue.first,
                  let second = newValue.dropFirst().first else {
                return
            }
            self.head = head
            self.second = second
            self.tail = Array(newValue.dropFirst(2))
        }
    }

    private var head: Element
    private var second: Element
    private var tail: [Element]

    public init(_ head: Element, _ second: Element, _ tail: Element...) {
        self.head = head
        self.second = second
        self.tail = tail
    }

    public init?(_ items: [Element]) {
        guard let head = items.first,
              let second = items.dropFirst().first else {
            return nil
        }
        self.head = head
        self.second = second
        self.tail = Array(items.dropFirst(2))
    }

    public init?<S>(_ head: Element, _ second: Element, _ tail: S) where S : Sequence, Element == S.Element {
        self.head = head
        self.second = second
        self.tail = Array(tail)
    }

    public init?<S>(_ elements: S) where S : Sequence, Element == S.Element {
        self.init(Array(elements))
    }

    public init<S>(_ lhs: MultiElementsArray, _ rhs: S) where S : Sequence, Element == S.Element {
        self.head = lhs.head
        self.second = lhs.second
        self.tail = lhs.tail + rhs
    }

    public init?(repeating repeatedValue: Element, count: Int) {
        guard count > 1 else {
            return nil
        }
        self.head = repeatedValue
        self.second = repeatedValue
        self.tail = Array(repeating: repeatedValue, count: count - 2)
    }
}

extension MultiElementsArray {
    public var toNonEmptyArray: NonEmptyArray<Element> {
        NonEmptyArray(head, CollectionOfOne(second) + tail)
    }
}

// MARK: - Array

extension MultiElementsArray {
    public var capacity: Int {
        items.capacity
    }

    public func withUnsafeBufferPointer<R>(_ body: (UnsafeBufferPointer<Element>) throws -> R) rethrows -> R {
        try items.withUnsafeBufferPointer(body)
    }

    public func withUnsafeBytes<R>(_ body: (UnsafeRawBufferPointer) throws -> R) rethrows -> R {
        try items.withUnsafeBytes(body)
    }

    public func filter(_ isIncluded: (Element) throws -> Bool) rethrows -> [Element] {
        try items.filter(isIncluded)
    }

    public func dropLast(_ k: Int) -> ArraySlice<Element> {
        items.dropLast(count)
    }

    public func suffix(_ maxLength: Int) -> ArraySlice<Element> {
        items.suffix(maxLength)
    }

    public func dropFirst(_ k: Int = 1) -> ArraySlice<Element> {
        items.dropFirst(k)
    }

    public func drop(while predicate: (Element) throws -> Bool) rethrows -> ArraySlice<Element> {
        try items.drop(while: predicate)
    }

    public func prefix(_ maxLength: Int) -> ArraySlice<Element> {
        items.prefix(maxLength)
    }

    public func prefix(while predicate: (Element) throws -> Bool) rethrows -> ArraySlice<Element> {
        try items.prefix(while: predicate)
    }

    public func prefix(upTo end: Int) -> ArraySlice<Element> {
        items.prefix(upTo: end)
    }

    public func suffix(from start: Int) -> ArraySlice<Element> {
        items.suffix(from: start)
    }

    public func prefix(through position: Int) -> ArraySlice<Element> {
        items.prefix(through: position)
    }

    public func split(maxSplits: Int = Int.max, omittingEmptySubsequences: Bool = true, whereSeparator isSeparator: (Element) throws -> Bool) rethrows -> [ArraySlice<Element>] {
        try items.split(maxSplits: maxSplits, omittingEmptySubsequences: omittingEmptySubsequences, whereSeparator: isSeparator)
    }

    public var last: Element {
        tail.last ?? head
    }

    public func firstIndex(where predicate: (Element) throws -> Bool) rethrows -> Int? {
        try items.firstIndex(where: predicate)
    }

    public func last(where predicate: (Element) throws -> Bool) rethrows -> Element? {
        try items.last(where: predicate)
    }

    public func lastIndex(where predicate: (Element) throws -> Bool) rethrows -> Int? {
        try items.lastIndex(where: predicate)
    }

    public func shuffled<T>(using generator: inout T) -> MultiElementsArray<Element> where T : RandomNumberGenerator {
        MultiElementsArray(items.shuffled(using: &generator)) ?? self
    }

    public var isEmpty: Bool { false }

    public var first: Element {
        head
    }

    public var count: Positive<Int> {
        Positive(tail.count + 2)!
    }

    public func reversed() -> MultiElementsArray {
        MultiElementsArray(items.reversed())!
    }

    public func index(_ i: Int, offsetBy distance: Int) -> Int {
        items.index(i, offsetBy: distance)
    }

    public func index(_ i: Int, offsetBy distance: Int, limitedBy limit: Int) -> Int? {
        items.index(i, offsetBy: distance, limitedBy: limit)
    }

    public var lazy: LazySequence<Array<Element>> {
        items.lazy
    }

    // MARK: - Mutating

    public mutating func popLast() -> Element? {
        guard count > 2 else {
            return nil
        }

        return items.popLast()
    }

    public mutating func removeLast(_ k: Int) {
        guard k < count else {
            items.removeLast(count - 1)
            return
        }

        items.removeLast(k)
    }

    public mutating func removeFirst() -> Element? {
        guard count > 1 else {
            return nil
        }

        return items.removeFirst()
    }

    public mutating func removeFirst(_ k: Int) {
        guard count > k else {
            removeFirst(count - 1)
            return
        }

        return items.removeFirst(k)
    }

    public mutating func partition(by belongsInSecondPartition: (Element) throws -> Bool) rethrows -> Int {
        try items.partition(by: belongsInSecondPartition)
    }

    public mutating func shuffle<T>(using generator: inout T) where T : RandomNumberGenerator {
        items.shuffle()
    }

    public func shuffled() -> MultiElementsArray<Element> {
        MultiElementsArray(items.shuffled()) ?? self
    }

    public mutating func swapAt(_ i: Int, _ j: Int) {
        items.swapAt(i, j)
    }

    public mutating func append(_ newElement: Element) {
        items.append(newElement)
    }

    public mutating func append(_ newElements: Element...) {
        items.append(contentsOf: newElements)
    }

    public mutating func append<S>(contentsOf newElements: S) where S : Sequence, Element == S.Element{
        items.append(contentsOf: newElements)
    }

    public mutating func insert(_ newElement: Element, at i: Int){
        items.insert(newElement, at: i)
    }

    public mutating func remove(at i: Int) -> Element? {
        guard items.count > 1 else {
            return nil
        }

        guard items.indices.contains(i) else {
            return nil
        }

        return items.remove(at: i)
    }

    // MARK: - Static

    public static func +<S>(lhs: MultiElementsArray, rhs: S) -> MultiElementsArray<Element> where S : Sequence, Element == S.Element {
        MultiElementsArray(lhs, rhs)
    }

    public static func +=(lhs: inout MultiElementsArray, rhs: MultiElementsArray) {
        lhs.append(contentsOf: rhs.items)
    }
}

// MARK: - Sequence

extension MultiElementsArray: Sequence {
    public func makeIterator() -> IndexingIterator<[Element]> {
        items.makeIterator()
    }
}

// MARK: - Collection

extension MultiElementsArray: Collection {
    public var startIndex: Int {
        .zero
    }

    public var endIndex: Int {
        tail.endIndex + 2
    }

    public func randomElement<T>(using generator: inout T) -> Element where T : RandomNumberGenerator {
        items.randomElement(using: &generator) ?? head
    }

    public func randomElement() -> Element {
        items.randomElement() ?? head
    }

    public func max() -> Element where Element: Comparable {
        items.max() ?? head
    }

    public func max(by areInIncreasingOrder: (Self.Element, Self.Element) throws -> Bool) rethrows -> Element {
        try items.max(by: areInIncreasingOrder) ?? head
    }

    public func min() -> Element where Element: Comparable {
        items.min() ?? head
    }

    public func min(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows -> Element {
        try items.min(by: areInIncreasingOrder) ?? head
    }

    public func sorted(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows -> MultiElementsArray<Element> {
        MultiElementsArray(try items.sorted(by: areInIncreasingOrder)) ?? self
    }
}

// MARK: - MutableCollection

extension MultiElementsArray: MutableCollection {
    public subscript(position: Int) -> Element {
        get {
            return items[position]
        }
        set {
            return items[position] = newValue
        }
    }
}

// MARK: - BidirectionalCollection

extension MultiElementsArray: BidirectionalCollection {

    public func index(before i: Int) -> Int {
        i - 1
    }

    public func index(after i: Int) -> Int {
        i + 1
    }
}

// MARK: - CustomStringConvertible

extension MultiElementsArray: CustomStringConvertible {
    public var description: String {
        items.description
    }
}

// MARK: - CustomDebugStringConvertible

extension MultiElementsArray: CustomDebugStringConvertible {
    public var debugDescription: String {
        items.debugDescription
    }
}

// MARK: - CustomReflectable

extension MultiElementsArray: CustomReflectable {
    public var customMirror: Mirror {
        items.customMirror
    }
}

// MARK: - Comparable

extension MultiElementsArray: Comparable where Element: Comparable {
    public static func < (lhs: MultiElementsArray<Element>, rhs: MultiElementsArray<Element>) -> Bool {
        for (v1, v2) in zip(lhs.items, rhs.items){
            if v1 != v2 { return v1 < v2 }
        }
        return lhs.count < rhs.count
    }
}

// MARK: - RandomAccessCollection

extension MultiElementsArray: RandomAccessCollection {}

// MARK: - Equatable

extension MultiElementsArray: Equatable where Element: Equatable {}

// MARK: - Hashable

extension MultiElementsArray: Hashable where Element: Hashable {}

// MARK: - Sendable

extension MultiElementsArray: Sendable where Element: Sendable {}

// MARK: - Encodable

extension MultiElementsArray: Encodable where Element: Encodable {}

// MARK: - Decodable

extension MultiElementsArray: Decodable where Element: Decodable {}
