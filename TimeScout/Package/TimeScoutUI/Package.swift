// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TimeScoutUI",
    platforms: [.iOS(.v16)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "TimeScoutUI",
            targets: ["TimeScoutUI"]),
    ],
    dependencies: [
        .package(path: "TimeScoutCore"),
        .package(path: "TimeScoutData")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "TimeScoutUI",
            dependencies: [
                .product(name: "TimeScoutCore", package: "TimeScoutCore"),
                .product(name: "TimeScoutData", package: "TimeScoutData")
            ]
        ),
        .testTarget(
            name: "TimeScoutUITests",
            dependencies: ["TimeScoutUI"]
        ),
    ]
)
