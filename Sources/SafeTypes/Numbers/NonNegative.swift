public struct NonNegative<Value: Number> {
    public let value: Value

    public init?(_ value: Value) {
        guard value >= .zero else {
            return nil
        }
        self.value = value
    }

    public init(_ positive: Positive<Value>) {
        self.init(positive.value)!
    }

    public init(_ zeroToOne: ZeroToOne<Value>) {
        self.init(zeroToOne.value)!
    }
}

// MARK: - Equatable

extension NonNegative: Equatable where Value: Equatable {
    public static func ==(lhs: NonNegative, rhs: Value) -> Bool {
        lhs.value == rhs
    }

    public static func ==(lhs: Value, rhs: NonNegative) -> Bool {
        lhs == rhs.value
    }
}

// MARK: - Comparable

extension NonNegative: Comparable {
    public static func < (lhs: NonNegative<Value>, rhs: NonNegative<Value>) -> Bool {
        lhs.value < rhs.value
    }
}

// MARK: - CustomStringConvertible

extension NonNegative: CustomStringConvertible where Value: CustomStringConvertible {
    public var description: String {
        value.description
    }
}

// MARK: - CustomDebugStringConvertible

extension NonNegative: CustomDebugStringConvertible where Value: CustomDebugStringConvertible {
    public var debugDescription: String {
        value.debugDescription
    }
}

// MARK: - CustomReflectable

extension NonNegative: CustomReflectable where Value: CustomReflectable {
    public var customMirror: Mirror {
        value.customMirror
    }
}

// MARK: - Encodable

extension NonNegative: Encodable where Value: Encodable {}

// MARK: - Decodable

extension NonNegative: Decodable where Value: Decodable {}

// MARK: - Sendable

extension NonNegative: Sendable where Value: Sendable {}

// MARK: - Hashable

extension NonNegative: Hashable where Value: Hashable {}
