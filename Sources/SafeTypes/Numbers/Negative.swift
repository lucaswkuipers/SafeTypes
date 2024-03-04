public struct Negative<Value: Number> {
    public let value: Value

    public init?(_ value: Value) {
        guard value < .zero else {
            return nil
        }
        self.value = value
    }
}

// MARK: - Product

extension Negative {
    public static func *(lhs: Negative, rhs: Negative) -> NonNegative<Value> {
        NonNegative(lhs.value * rhs.value)!
    }

    public static func *(lhs: Negative<Value>, rhs: Positive<Value>) -> NonPositive<Value> {
        NonPositive(lhs.value * rhs.value)!
    }

    public static func *(lhs: Negative<Value>, rhs: NonPositive<Value>) -> NonNegative<Value> {
        NonNegative(lhs.value * rhs.value)!
    }

    public static func *(lhs: Negative<Value>, rhs: NonNegative<Value>) -> NonPositive<Value> {
        NonPositive(lhs.value * rhs.value)!
    }
}

extension Negative<Int> {
    public static func *(lhs: Negative, rhs: Negative) -> Positive<Value> {
        Positive(lhs.value * rhs.value)!
    }

    public static func *(lhs: Negative, rhs: Positive<Value>) -> Negative {
        Negative(lhs.value * rhs.value)!
    }
}

// MARK: - Addition

extension Negative {
    public static func +(lhs: Negative, rhs: Negative) -> Negative {
        Negative(lhs.value + rhs.value)!
    }

    static public func +=(lhs: inout Negative, rhs: Negative) {
        lhs = Negative(lhs.value + rhs.value)!
    }
}

// MARK: - Division

extension Negative where Value: BinaryInteger {
    public static func /(lhs: Negative, rhs: Negative) -> NonNegative<Value> {
        NonNegative(lhs.value / rhs.value)!
    }
}

// MARK: - isMultiple

extension Negative where Value: FloatingPoint {
    public static func /(lhs: Negative, rhs: Negative) -> NonNegative<Value> {
        NonNegative(lhs.value / rhs.value)!
    }
}

// MARK: - Int

extension Negative where Value: BinaryInteger & Comparable {
    public func isMultiple(of number: Value) -> Bool {
        value.isMultiple(of: number)
    }
}

// MARK: - Equatable

extension Negative: Equatable where Value: Equatable {
    public static func ==(lhs: Negative, rhs: Value) -> Bool {
        lhs.value == rhs
    }

    public static func ==(lhs: Value, rhs: Negative) -> Bool {
        lhs == rhs.value
    }
}

// MARK: - Comparable

extension Negative: Comparable {
    public static func < (lhs: Negative, rhs: Negative) -> Bool {
        lhs.value < rhs.value
    }
}

// MARK: - CustomStringConvertible

extension Negative: CustomStringConvertible where Value: CustomStringConvertible {
    public var description: String {
        value.description
    }
}

// MARK: - CustomDebugStringConvertible

extension Negative: CustomDebugStringConvertible where Value: CustomDebugStringConvertible {
    public var debugDescription: String {
        value.debugDescription
    }
}

// MARK: - CustomReflectable

extension Negative: CustomReflectable where Value: CustomReflectable {
    public var customMirror: Mirror {
        value.customMirror
    }
}

// MARK: - Encodable

extension Negative: Encodable where Value: Encodable {}

// MARK: - Decodable

extension Negative: Decodable where Value: Decodable {}

// MARK: - Sendable

extension Negative: Sendable where Value: Sendable {}

// MARK: - Hashable

extension Negative: Hashable where Value: Hashable {}
