public struct Positive<Value: Number> {
    public let value: Value

    public init?(_ value: Value) {
        guard value > .zero else {
            return nil
        }
        self.value = value
    }
}

// MARK: - Multiplication

extension Positive {
    public static func *(lhs: Positive, rhs: Positive) -> NonNegative<Value> {
        NonNegative(lhs.value * rhs.value)!
    }

    public static func *(lhs: Positive<Value>, rhs: Negative<Value>) -> NonPositive<Value> {
        NonPositive(lhs.value * rhs.value)!
    }
}

extension Positive<Int> {
    public static func *(lhs: Positive, rhs: Positive) -> Positive {
        Positive(lhs.value * rhs.value)!
    }

    public static func *(lhs: Positive, rhs: Negative<Int>) -> Negative<Int> {
        Negative(lhs.value * rhs.value)!
    }

    public static func *=(lhs: inout Positive, rhs: Positive) {
        lhs = Positive(lhs.value * rhs.value)!
    }
}

// MARK: - Addition

extension Positive {
    public static func +(lhs: Positive, rhs: Positive) -> Positive {
        Positive(lhs.value + rhs.value)!
    }

    static public func +=(lhs: inout Positive, rhs: Positive) {
        lhs = Positive(lhs.value + rhs.value)!
    }
}

// MARK: - Division

extension Positive where Value: BinaryInteger {
    public static func /(lhs: Positive, rhs: Positive) -> NonNegative<Value> {
        NonNegative(lhs.value / rhs.value)!
    }

    public static func /(lhs: Positive, rhs: Negative<Value>) -> NonPositive<Value> {
        NonPositive(lhs.value / rhs.value)!
    }

    public static func /(lhs: Negative<Value>, rhs: Positive) -> NonPositive<Value> {
        NonPositive(lhs.value / rhs.value)!
    }
}

extension Positive where Value: FloatingPoint {
    public static func /(lhs: Positive, rhs: Positive) -> NonNegative<Value> {
        NonNegative(lhs.value / rhs.value)!
    }

    public static func /(lhs: Positive, rhs: Negative<Value>) -> NonPositive<Value> {
        NonPositive(lhs.value / rhs.value)!
    }

    public static func /(lhs: Negative<Value>, rhs: Positive) -> NonPositive<Value> {
        NonPositive(lhs.value / rhs.value)!
    }
}

// MARK: - Modulo

extension Positive where Value: BinaryInteger {
    public static func %(lhs: Positive, rhs: Positive) -> NonNegative<Value> {
        NonNegative(lhs.value % rhs.value)!
    }
}

// MARK: - isMultiple

extension Positive where Value: BinaryInteger {
    public func isMultiple(of number: Value) -> Bool {
        value.isMultiple(of: number)
    }
}

// MARK: - Equatable

extension Positive: Equatable where Value: Equatable {
    public static func ==(lhs: Positive, rhs: Value) -> Bool {
        lhs.value == rhs
    }

    public static func ==(lhs: Value, rhs: Positive) -> Bool {
        lhs == rhs.value
    }
}

// MARK: - Comparable

extension Positive: Comparable {
    public static func < (lhs: Positive<Value>, rhs: Positive<Value>) -> Bool {
        lhs.value < rhs.value
    }
}

// MARK: - CustomStringConvertible

extension Positive: CustomStringConvertible where Value: CustomStringConvertible {
    public var description: String {
        value.description
    }
}

// MARK: - CustomDebugStringConvertible

extension Positive: CustomDebugStringConvertible where Value: CustomDebugStringConvertible {
    public var debugDescription: String {
        value.debugDescription
    }
}

// MARK: - CustomReflectable

extension Positive: CustomReflectable where Value: CustomReflectable {
    public var customMirror: Mirror {
        value.customMirror
    }
}

// MARK: - Encodable

extension Positive: Encodable where Value: Encodable {}

// MARK: - Decodable

extension Positive: Decodable where Value: Decodable {}

// MARK: - Sendable

extension Positive: Sendable where Value: Sendable {}

// MARK: - Hashable

extension Positive: Hashable where Value: Hashable {}
