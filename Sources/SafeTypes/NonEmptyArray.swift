public struct NonEmptyArray<Element> {
    private(set) public var items: [Element]

    public init?(_ items: [Element]) {
        guard !items.isEmpty else {
            return nil
        }
        self.items = items
    }

    public init?<S>(_ elements: S) where S : Sequence, Element == S.Element {
        let items = Array(elements)
        guard !items.isEmpty else {
            return nil
        }
        self.items = items
    }

    public init(_ head: Element, _ tail: Element...) {
        self.items = CollectionOfOne(head) + tail
    }

    public init<S>(_ lhs: NonEmptyArray, _ rhs: S) where S : Sequence, Element == S.Element {
        self.items = lhs.items + rhs
    }

    public init?(repeating repeatedValue: Element, count: Int) {
        guard count > 0 else {
            return nil
        }

        self.items = Array(repeating: repeatedValue, count: count)
    }
}

// MARK: - Array

extension NonEmptyArray {
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

    public mutating func popLast() -> Element? {
        guard count > 1 else {
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

    public var last: Element {
        items.last!
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

    public mutating func partition(by belongsInSecondPartition: (Element) throws -> Bool) rethrows -> Int {
        try items.partition(by: belongsInSecondPartition)
    }

    public func shuffled<T>(using generator: inout T) -> [Element] where T : RandomNumberGenerator {
        items.shuffled(using: &generator)
    }

    public mutating func shuffle<T>(using generator: inout T) where T : RandomNumberGenerator {
        items.shuffle()
    }

    public var lazy: LazySequence<Array<Element>> {
        items.lazy
    }

    public mutating func swapAt(_ i: Int, _ j: Int) {
        items.swapAt(i, j)
    }

     public var isEmpty: Bool { false }

     public var first: Element {
        items.first!
    }

     public var count: Int {
        items.count
    }

    public func reversed() -> NonEmptyArray {
        NonEmptyArray(items.reversed())!
    }
    
    public func index(_ i: Int, offsetBy distance: Int) -> Int {
        items.index(i, offsetBy: distance)
    }

    public func index(_ i: Int, offsetBy distance: Int, limitedBy limit: Int) -> Int? {
        items.index(i, offsetBy: distance, limitedBy: limit)
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

    public mutating func insert(_ newElement: Element, at index: Int){
        items.insert(newElement, at: index)
    }

    public mutating func remove(at index: Int) -> Element? {
        guard items.count > 1 else {
            return nil
        }

        guard items.indices.contains(index) else {
            return nil
        }

        return items.remove(at: index)
    }

    public static func + <S>(lhs: NonEmptyArray, rhs: S) -> NonEmptyArray<Element> where S : Sequence, Element == S.Element {
        NonEmptyArray(lhs, rhs)
    }

     public static func +=(lhs: inout NonEmptyArray, rhs: NonEmptyArray) {
        lhs.append(contentsOf: rhs.items)
    }
}

// MARK: - Sequence

extension NonEmptyArray: Sequence {
     public func makeIterator() -> IndexingIterator<[Element]> {
        items.makeIterator()
    }
}

// MARK: - Collection

extension NonEmptyArray: Collection {
     public var startIndex: Int {
        items.startIndex
    }

     public var endIndex: Int {
        items.endIndex
    }
}

// MARK: - MutableCollection

extension NonEmptyArray: MutableCollection {
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

extension NonEmptyArray: BidirectionalCollection {

     public func index(before i: Int) -> Int {
        items.index(before: i)
    }

     public func index(after i: Int) -> Int {
        items.index(after: i)
    }
}

// MARK: - CustomStringConvertible

extension NonEmptyArray: CustomStringConvertible {
    public var description: String {
        items.description
    }
}

// MARK: - Comparable

extension NonEmptyArray: Comparable where Element: Comparable {
    public static func < (lhs: NonEmptyArray<Element>, rhs: NonEmptyArray<Element>) -> Bool {
        for (v1, v2) in zip(lhs.items, rhs.items){
            if v1 != v2 { return v1 < v2 }
        }
        return lhs.count < rhs.count
    }
}

// MARK: - RandomAccessCollection

extension NonEmptyArray: RandomAccessCollection {}

// MARK: - Equatable

extension NonEmptyArray: Equatable where Element: Equatable {}

// MARK: - Hashable

extension NonEmptyArray: Hashable where Element: Hashable {}

// MARK: - Sendable

extension NonEmptyArray: Sendable where Element: Sendable {}

// MARK: - Encodable

extension NonEmptyArray: Encodable where Element: Encodable {}

// MARK: - Decodable

extension NonEmptyArray: Decodable where Element: Decodable {}
