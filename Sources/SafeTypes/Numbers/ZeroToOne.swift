public struct ZeroToOne<Value: Number> {
    public let value: Value

    public init?(_ value: Value) {
        guard value >= .zero && value <= 1 else {
            return nil
        }
        self.value = value
    }
}

extension ZeroToOne {
    public static var max: ZeroToOne {
        ZeroToOne(1)!
    }

    public static var min: ZeroToOne {
        ZeroToOne(0)!
    }
}

// MARK: - Multiplication

extension ZeroToOne {
    public static func *(lhs: ZeroToOne, rhs: ZeroToOne) -> ZeroToOne {
        ZeroToOne(lhs.value * rhs.value)!
    }

    public static func *=(lhs: inout ZeroToOne, rhs: ZeroToOne) {
        lhs = ZeroToOne(lhs.value * rhs.value)!
    }
}

// MARK: - Equatable

extension ZeroToOne: Equatable where Value: Equatable {
    public static func ==(lhs: ZeroToOne, rhs: Value) -> Bool {
        lhs.value == rhs
    }

    public static func ==(lhs: Value, rhs: ZeroToOne) -> Bool {
        lhs == rhs.value
    }
}

// MARK: - Comparable

extension ZeroToOne: Comparable {
    public static func < (lhs: ZeroToOne, rhs: ZeroToOne) -> Bool {
        lhs.value < rhs.value
    }
}

// MARK: - CustomStringConvertible

extension ZeroToOne: CustomStringConvertible where Value: CustomStringConvertible {
    public var description: String {
        value.description
    }
}

// MARK: - CustomDebugStringConvertible

extension ZeroToOne: CustomDebugStringConvertible where Value: CustomDebugStringConvertible {
    public var debugDescription: String {
        value.debugDescription
    }
}

// MARK: - CustomReflectable

extension ZeroToOne: CustomReflectable where Value: CustomReflectable {
    public var customMirror: Mirror {
        value.customMirror
    }
}

// MARK: - Encodable

extension ZeroToOne: Encodable where Value: Encodable {}

// MARK: - Decodable

extension ZeroToOne: Decodable where Value: Decodable {}

// MARK: - Sendable

extension ZeroToOne: Sendable where Value: Sendable {}

// MARK: - Hashable

extension ZeroToOne: Hashable where Value: Hashable {}

