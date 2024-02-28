// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "KippleDiagnostics",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
        .tvOS(.v16),
        .watchOS(.v9),
    ],
    products: [
        .library(name: "KippleLogging", targets: ["KippleLogging"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-log", from: "1.5.4"),
        .package(url: "https://github.com/swift-kipple/Tools", .upToNextMinor(from: "0.5.0")),
    ],
    targets: [
        // Product Targets
        .target(
            name: "KippleLogging",
            dependencies: [
                .product(name: "Logging", package: "swift-log"),
            ]
        ),
        // Tests Targets
        .testTarget(
            name: "KippleLoggingTests",
            dependencies: [
                .target(name: "KippleLogging"),
            ]
        ),
    ]
)
