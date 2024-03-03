public struct NonEmptyArray<Element> {
    private(set) public var items: [Element]

    public init?(_ items: [Element]) {
        guard !items.isEmpty else {
            return nil
        }
        self.items = items
    }

    public init(_ head: Element, _ tail: Element...) {
        self.items = CollectionOfOne(head) + tail
    }

    public init(_ lhs: NonEmptyArray<Element>, _ rhs: NonEmptyArray<Element>) {
        self.items = lhs.items + rhs.items
    }
}

// MARK: - Array

extension NonEmptyArray {
    public var first: Element {
        items.first!
    }

    public var last: Element {
        items.last!
    }

    public var count: Int {
        items.count
    }

    public mutating func append(_ newElement: Element) {
        items.append(newElement)
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
        return items.remove(at: i)
    }

    @inlinable public static func +(lhs: NonEmptyArray, rhs: NonEmptyArray) -> NonEmptyArray {
        NonEmptyArray(lhs, rhs)
    }

    @inlinable public static func +=(lhs: inout NonEmptyArray, rhs: NonEmptyArray) {
        lhs.append(contentsOf: rhs.items)
    }
}

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

    public subscript(position: Int) -> Element {
        items[position]
    }

    public func index(after i: Int) -> Int {
        items.index(after: i)
    }

    public func reversed() -> NonEmptyArray {
        NonEmptyArray(items.reversed())!
    }
}

// MARK: - CustomStringConvertible

extension NonEmptyArray: CustomStringConvertible where Element: CustomStringConvertible {
    public var description: String {
        items.description
    }
}
