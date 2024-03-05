public struct MinusOneToOne<Value: Number> {
    public let value: Value

    public init?(_ value: Value) {
        guard value >= -1 && value <= 1 else {
            return nil
        }
        self.value = value
    }
}

extension MinusOneToOne {
    public static var max: MinusOneToOne {
        MinusOneToOne(1)!
    }

    public static var min: MinusOneToOne {
        MinusOneToOne(-1)!
    }
}

// MARK: - Multiplication

extension MinusOneToOne {
    public static func *(lhs: MinusOneToOne, rhs: MinusOneToOne) -> MinusOneToOne {
        MinusOneToOne(lhs.value * rhs.value)!
    }

    public static func *=(lhs: inout MinusOneToOne, rhs: MinusOneToOne) {
        lhs = MinusOneToOne(lhs.value * rhs.value)!
    }
}

// MARK: - Equatable

extension MinusOneToOne: Equatable where Value: Equatable {
    public static func ==(lhs: MinusOneToOne, rhs: Value) -> Bool {
        lhs.value == rhs
    }

    public static func ==(lhs: Value, rhs: MinusOneToOne) -> Bool {
        lhs == rhs.value
    }
}

// MARK: - Comparable

extension MinusOneToOne: Comparable {
    public static func < (lhs: MinusOneToOne, rhs: MinusOneToOne) -> Bool {
        lhs.value < rhs.value
    }
}

// MARK: - CustomStringConvertible

extension MinusOneToOne: CustomStringConvertible where Value: CustomStringConvertible {
    public var description: String {
        value.description
    }
}

// MARK: - CustomDebugStringConvertible

extension MinusOneToOne: CustomDebugStringConvertible where Value: CustomDebugStringConvertible {
    public var debugDescription: String {
        value.debugDescription
    }
}

// MARK: - CustomReflectable

extension MinusOneToOne: CustomReflectable where Value: CustomReflectable {
    public var customMirror: Mirror {
        value.customMirror
    }
}

// MARK: - Encodable

extension MinusOneToOne: Encodable where Value: Encodable {}

// MARK: - Decodable

extension MinusOneToOne: Decodable where Value: Decodable {}

// MARK: - Sendable

extension MinusOneToOne: Sendable where Value: Sendable {}

// MARK: - Hashable

extension MinusOneToOne: Hashable where Value: Hashable {}


