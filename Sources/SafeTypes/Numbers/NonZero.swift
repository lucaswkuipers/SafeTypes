public struct NonZero<Value: Number> {
    public let value: Value

    public init?(_ value: Value) {
        guard value != .zero else {
            return nil
        }
        self.value = value
    }

    public init(_ positive: Positive<Value>) {
        self.init(positive.value)!
    }

    public init(_ negative: Negative<Value>) {
        self.init(negative.value)!
    }
}

// MARK: - Equatable

extension NonZero: Equatable where Value: Equatable {
    public static func ==(lhs: NonZero, rhs: Value) -> Bool {
        lhs.value == rhs
    }

    public static func ==(lhs: Value, rhs: NonZero) -> Bool {
        lhs == rhs.value
    }
}

// MARK: - Comparable

extension NonZero: Comparable {
    public static func < (lhs: NonZero<Value>, rhs: NonZero<Value>) -> Bool {
        lhs.value < rhs.value
    }
}

// MARK: - CustomStringConvertible

extension NonZero: CustomStringConvertible where Value: CustomStringConvertible {
    public var description: String {
        value.description
    }
}

// MARK: - CustomDebugStringConvertible

extension NonZero: CustomDebugStringConvertible where Value: CustomDebugStringConvertible {
    public var debugDescription: String {
        value.debugDescription
    }
}

// MARK: - CustomReflectable

extension NonZero: CustomReflectable where Value: CustomReflectable {
    public var customMirror: Mirror {
        value.customMirror
    }
}

// MARK: - Encodable

extension NonZero: Encodable where Value: Encodable {}

// MARK: - Decodable

extension NonZero: Decodable where Value: Decodable {}

// MARK: - Sendable

extension NonZero: Sendable where Value: Sendable {}

// MARK: - Hashable

extension NonZero: Hashable where Value: Hashable {}

