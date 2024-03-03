// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "SafeTypes",
    products: [
        .library(
            name: "SafeTypes",
            targets: ["SafeTypes"]
        ),
    ],
    targets: [
        .target(name: "SafeTypes"),
        .testTarget(name: "SafeTypesTests", dependencies: ["SafeTypes"])
    ]
)
