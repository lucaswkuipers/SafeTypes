public struct NonPositive<Value: Number> {
    public let value: Value

    public init?(_ value: Value) {
        guard value <= .zero else {
            return nil
        }
        self.value = value
    }

    public init(_ negative: Negative<Value>) {
        self.init(negative.value)!
    }
}

// MARK: - Multiplication

extension NonPositive {
    public static func *(lhs: NonPositive, rhs: NonPositive) -> NonNegative<Value> {
        NonNegative(lhs.value * rhs.value)!
    }

    public static func *(lhs: NonPositive, rhs: NonNegative<Value>) -> NonPositive {
        NonPositive(lhs.value * rhs.value)!
    }

    public static func *(lhs: NonNegative<Value>, rhs: NonPositive) -> NonPositive {
        NonPositive(lhs.value * rhs.value)!
    }

    public static func *(lhs: NonPositive, rhs: Negative<Value>) -> NonNegative<Value> {
        NonNegative(lhs.value * rhs.value)!
    }

    public static func *(lhs: NonPositive, rhs: Positive<Value>) -> NonPositive {
        NonPositive(lhs.value * rhs.value)!
    }
}

// MARK: - Addition

extension NonPositive {
    public static func +(lhs: NonPositive, rhs: NonPositive) -> NonPositive {
        NonPositive(lhs.value + rhs.value)!
    }

    static public func +=(lhs: inout NonPositive, rhs: NonPositive) {
        lhs = NonPositive(lhs.value + rhs.value)!
    }
}

// MARK: - Equatable

extension NonPositive: Equatable where Value: Equatable {
    public static func ==(lhs: NonPositive, rhs: Value) -> Bool {
        lhs.value == rhs
    }

    public static func ==(lhs: Value, rhs: NonPositive) -> Bool {
        lhs == rhs.value
    }
}

// MARK: - Comparable

extension NonPositive: Comparable {
    public static func < (lhs: NonPositive<Value>, rhs: NonPositive<Value>) -> Bool {
        lhs.value < rhs.value
    }
}

// MARK: - CustomStringConvertible

extension NonPositive: CustomStringConvertible where Value: CustomStringConvertible {
    public var description: String {
        value.description
    }
}

// MARK: - CustomDebugStringConvertible

extension NonPositive: CustomDebugStringConvertible where Value: CustomDebugStringConvertible {
    public var debugDescription: String {
        value.debugDescription
    }
}

// MARK: - CustomReflectable

extension NonPositive: CustomReflectable where Value: CustomReflectable {
    public var customMirror: Mirror {
        value.customMirror
    }
}

// MARK: - Encodable

extension NonPositive: Encodable where Value: Encodable {}

// MARK: - Decodable

extension NonPositive: Decodable where Value: Decodable {}

// MARK: - Sendable

extension NonPositive: Sendable where Value: Sendable {}

// MARK: - Hashable

extension NonPositive: Hashable where Value: Hashable {}
