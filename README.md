# SafeTypes
SafeTypes is a _Swift_ package that delivers a suite of strongly-typed wrappers for common data structures and primitives, enforcing specific constraints and providing functionality to operate safely within those bounds.

![SafeTypesBanner](https://github.com/lucaswkuipers/SafeTypes/assets/59176579/498580bd-8a5a-46d6-ac08-d7b957742d46)


By ensuring conditions such as non-emptiness or value range at compile time, SafeTypes allows developers to write more robust and expressive code with reduced boilerplate, increased performance, and improved documentation through types.

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

And then import wherever needed: `import SafeTypes`

## Usage

Below are some of the types provided by SafeTypes and brief examples of their usage:

### `MultiElementsArray`

An array that is guaranteed to have more than one element.

```swift
let multiElements = MultiElementsArray(1, 2, 3)
```

### `NonEmptyArray`

An array that is guaranteed to have at least one element.

```swift
```

### `NonEmptyString`

A string that's guaranteed to contain at least one character (can be empty character).

```swift
```

### Positive

```swift

```

### Negative

```swift

```

### NonPositive

```swift

```

### NonNegative

```swift

```

### NonZero

```swift

```

### `MinusOneToOne`

Represents a value that's within the range of -1 to 1, inclusive.

```swift
let bounded = MinusOneToOne(0.5)
```

### `ZeroToOne`

Represents a value from 0 to 1, inclusive.

```swift
```

Each type guarantees compliance with its stated constraints such as non-zeroness, positivity, or negativity, so that your functions and methods can rely on those qualities.

## Contributing

Contributions are what make the open-source community such a fantastic place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

Distributed under the MIT License. See `LICENSE` for more information.

## Contact

Feel free to reach out to me on [LinkedIn](https://www.linkedin.com/in/lucaswk/)

## Acknowledgements

- [Your attribution here](#)

---

Thank you for considering SafeTypes for your next Swift project – I hope you find it as enjoyable to use as I found it to write.
