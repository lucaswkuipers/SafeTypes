# SafeTypes 🛡️🏰
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Flucaswkuipers%2FSafeTypes%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/lucaswkuipers/SafeTypes)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Flucaswkuipers%2FSafeTypes%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/lucaswkuipers/SafeTypes)

SafeTypes is a _Swift_ package that delivers a suite of strongly-typed wrappers for common data structures and primitives, enforcing specific constraints and providing functionality to operate safely within those bounds.

> If you are targetting Swift 5.9+ I highly suggest you install SafeTypesMacros alongside it. It adds macros for non optional initializers from literals (compilation-time check for literal values. Eg: #Positive(1) evaluates to Postive<Int>(1) instead of Optional<Postive<Int>(1)>, and #Positive(-1) would fail to compile!).>

![1](https://github.com/lucaswkuipers/SafeTypes/assets/59176579/dde8e422-5361-4276-8425-c10ba108974e)

By ensuring conditions at compile time, SafeTypes allows developers to write safer, more robust and expressive code with reduced boilerplate, increased performance, and improved documentation through its constrained types.

ℹ️ Note: Most constructors from these custom types will be optional so any client needs to construct and deal with the unhappy path there.
> For compile time check validation (and non optional initializers) for literals (only literals, not dynamic values) [SafeTypesMacros](https://github.com/lucaswkuipers/SafeTypesMacros) adds special macros for it! I definitely recommend you check it out!

## Features

- [x] Type-safe containers that prevent invalid states
- [x] Enforced runtime constraints at compile time
- [x] Enhanced code readability and maintainability
- [x] Simplified method interfaces and APIs
- [x] Streamlined unit testing by eliminating redundant unhappy-path checks

## Installation

### Swift Package Manager

Add the following to your `Package.swift` file's dependencies:

```swift
.package(url: "https://github.com/lucaswkuipers/SafeTypes.git", from: "1.0.0")
```

Or simply Select `File` > `Add Package Dependencies`, and enter the following URL:

```
https://github.com/lucaswkuipers/SafeTypes.git
```

And then, wherever needed:

```swift
import SafeTypes
```

## Usage

Below are some of the types provided by SafeTypes and brief examples of their usage:

### Collections

#### [MultiElementsArray](Sources/SafeTypes/Collections/MultiElementsArray.swift)

An array that is guaranteed to have more than one element.

```swift
// ✅ Non Optional Initializers

MultiElementsArray(1, 2) // MultiElementsArray<Int>
MultiElementsArray(1.0, 2.0, 3.0) // MultiElementsArray<Double>
MultiElementsArray(false, true, true, false) // MultiElementsArray<Bool>

// ❓ Optional Initializers

MultiElementsArray(["Alice", "Bob"]) // Optional<MultiElementsArray<String>>
MultiElementsArray(repeating: 1, count: 2) // Optional<MultiElementsArray<Int>>

// ❌ Fails to compile

MultiElementsArray(1) // Doesn't compile, missing argument
MultiElementsArray() // Doesn't compile, missing arguments
```

#### [NonEmptyArray](Sources/SafeTypes/Collections/NonEmptyArray.swift)

An array that is guaranteed to have at least one element.

```swift
// ✅ Non Optional Initializers

NonEmptyArray(1) // NonEmptyArray<Int>
NonEmptyArray(1.0, 2.0) // NonEmptyArray<Double>
NonEmptyArray(false, true, true) // NonEmptyArray<Bool>

// ❓ Optional Initializers

NonEmptyArray(["Alice", "Bob"]) // Optional<NonEmptyArray<String>>
NonEmptyArray(repeating: 1, count: 1) // Optional<NonEmptyArray<Int>>

// ❌ Fails to compile

NonEmptyArray() // Doesn't compile, missing arguments
```

#### [NonEmptyString](Sources/SafeTypes/Collections/NonEmptyString.swift)

A string that's guaranteed to contain at least one character (can be empty character).

```swift
// ❓ Optional Initializers

NonEmptyString(["Alice", "Bob"]) // Optional<NonEmptyString>
NonEmptyString(repeating: 1, count: "h") // Optional<NonEmptyString>

// ❌ Fails to compile

NonEmptyString() // Doesn't compile, missing initializer argument
```

> Obs: To use `#NonEmptyString` and other helpful macros, make sure to install the addon macros [SwiftTypesMacros (Swift 5.9+)](https://github.com/lucaswkuipers/SafeTypesMacros)

### Numbers

#### [Positive](Sources/SafeTypes/Numbers/Positive.swift)

A number that is guaranteed to be greater than zero (value > 0)

```swift
// ❓ Optional Initializers

Positive(123) // Optional<Positive<Int>>
Positive(42.69) // Optional<Positive<Double>>

// ❌ Fails to compile

Positive() // Doesn't compile, missing initializer argument
```

> ⚠️ Attention: To use `#Positive` and other helpful macros, make sure to install the addon macros [SwiftTypesMacros (Swift 5.9+)](https://github.com/lucaswkuipers/SafeTypesMacros)

#### [Negative](Sources/SafeTypes/Numbers/Negative.swift)

A number that is guaranteed to be less than zero (value < 0)

```swift
// ❓ Optional Initializers

Negative(-123) // Optional<Negative<Int>>
Negative(-42.69) // Optional<Negative<Double>>

// ❌ Fails to compile

Negative() // Doesn't compile, missing initializer argument
```

> ⚠️ Attention: To use `#Negative` and other helpful macros, make sure to install the addon macros [SwiftTypesMacros (Swift 5.9+)](https://github.com/lucaswkuipers/SafeTypesMacros)

#### [NonPositive](Sources/SafeTypes/Numbers/NonPositive.swift)

A number that is guaranteed to be less than or equal to zero (value <= 0)

```swift
// ❓ Optional Initializers

NonPositive(-123) // Optional<NonPositive<Int>>
NonPositive(-42.69) // Optional<NonPositive<Double>>
NonPositive(0) // Optional<NonPositive<Int>>
NonPositive(0.0) // Optional<NonPositive<Double>>

// ❌ Fails to compile
NonPositive() // Doesn't compile, missing initializer argument
```

> ⚠️ Attention: To use `#NonPositive` and other helpful macros, make sure to install the addon macros [SwiftTypesMacros (Swift 5.9+)](https://github.com/lucaswkuipers/SafeTypesMacros)

#### [NonNegative](Sources/SafeTypes/Numbers/NonNegative.swift)

A number that is guaranteed to be greater than or equal to zero (value >= 0)

```swift
// ❓ Optional Initializers

NonNegative(123) // Optional<NonNegative<Int>>
NonNegative(42.69) // Optional<NonNegative<Double>>
NonNegative(0) // Optional<NonNegative<Int>>
NonNegative(0.0) // Optional<NonNegative<Double>>

// ❌ Fails to compile

NonNegative() // Doesn't compile, missing initializer argument
```

> ⚠️ Attention: To use `#NonNegative` and other helpful macros, make sure to install the addon macros [SwiftTypesMacros (Swift 5.9+)](https://github.com/lucaswkuipers/SafeTypesMacros)

#### [NonZero](Sources/SafeTypes/Numbers/NonZero.swift)

A number that is guaranteed to be different than zero (value != 0)

```swift
// ❓ Optional Initializers

NonZero(123) // Optional<NonZero<Int>>
NonZero(42.69) // Optional<NonZero<Double>>
NonZero(-123) // Optional<NonZero<Int>>
NonZero(-42.69) // Optional<NonZero<Double>>

// ❌ Fails to compile

NonZero() // Doesn't compile, missing initializer argument
```

> ⚠️ Attention: To use `#NonZero` and other helpful macros, make sure to install the addon macros [SwiftTypesMacros (Swift 5.9+)](https://github.com/lucaswkuipers/SafeTypesMacros)

#### [MinusOneToOne](Sources/SafeTypes/Numbers/MinusOneToOne.swift)

Represents a value that's within the range of -1 to 1, inclusive.

```swift
// ❓ Optional Initializers

MinusOneToOne(-1) // Optional<MinusOneToOne<Int>>
MinusOneToOne(-1.0) // Optional<MinusOneToOne<Double>>
MinusOneToOne(-0.314159) // Optional<MinusOneToOne<Double>>
MinusOneToOne(0) // Optional<MinusOneToOne<Int>>
MinusOneToOne(0.0) // Optional<MinusOneToOne<Double>>
MinusOneToOne(0.1234) // Optional<MinusOneToOne<Double>>
MinusOneToOne(1) // Optional<MinusOneToOne<Double>>

// ❌ Fails to compile

#MinusOneToOne(-1.1) // Doesn't compile, macro argument can't be less than -1
#MinusOneToOne(42.1) // Doesn't compile, macro argument can't be greater than 1
#MinusOneToOne() // Doesn't compile, missing macro argument
MinusOneToOne() // Doesn't compile, missing initializer argument
```

> ⚠️ Attention: To use `#MinusOneToOne` and other helpful macros, make sure to install the addon macros [SwiftTypesMacros (Swift 5.9+)](https://github.com/lucaswkuipers/SafeTypesMacros)

#### [ZeroToOne](Sources/SafeTypes/Numbers/ZeroToOne.swift)

Represents a value from 0 to 1, inclusive.

```swift
// ❓ Optional Initializers

ZeroToOne(0) // Optional<ZeroToOne<Int>>
ZeroToOne(0.0) // Optional<ZeroToOne<Double>>
ZeroToOne(0.1234) // Optional<ZeroToOne<Double>>
ZeroToOne(1) // Optional<ZeroToOne<Double>>

// ❌ Fails to compile

ZeroToOne() // Doesn't compile, missing initializer argument
```

> ⚠️ Attention: To use `#ZeroToOne` and other helpful macros, make sure to install the addon macros [SwiftTypesMacros (Swift 5.9+)](https://github.com/lucaswkuipers/SafeTypesMacros)

Each type guarantees compliance with its stated constraints so that your functions and methods can rely on those qualities and pass them on (not losing information).

## Extra (Separate) Functionality: Macros Non Optional Initializers from Literals

SafeTypes is awesome and SafeTypesMacros makes it even more so by enabling you to construct the types from SafeTypes from literals and have them be evaluated (as valid or not) at compile time. [Check it out.](https://github.com/lucaswkuipers/SafeTypesMacros)

## Contributing

Contributions are what make the open-source community such a fantastic place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

## What to contribute?

If you want to start contributing but don't know what to work on, try looking at the open [Issues Tab](https://github.com/lucaswkuipers/SafeTypes/issues)

## Steps to contribute

1. Fork the Project
2. Create your Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

6. Oh and don't forget to add or update tests when applicable! :D

Thank you so much for contributing <3

## License

Distributed under the MIT License. See [LICENSE](LICENSE) for more information.

## Contact

Feel free to reach out to me: 

[![image](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/lucaswk/)

## Swift Package Index

SafeTypes can be found at [Swift Package Index](https://swiftpackageindex.com/lucaswkuipers/SafeTypes)

## Acknowledgements

Some of the relevant sources of inspiration:

- [Point-Free's NonEmpty](https://github.com/pointfreeco/swift-nonempty)
- [Type Driven Design Article Series by Alex Ozun](https://swiftology.io/collections/type-driven-design/))


Thank you so much for considering [SafeTypes](https://github.com/lucaswkuipers/SafeTypes) for your next Swift project – I hope you find it as enjoyable to use as I found it to write!
