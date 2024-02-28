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
        .library(name: "KippleDiagnostics", targets: ["KippleDiagnostics"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-log", from: "1.5.4"),
        .package(url: "https://github.com/swift-kipple/Tools", .upToNextMinor(from: "0.5.0")),
    ],
    targets: [
        // Product Targets
        .target(
            name: "KippleDiagnostics",
            dependencies: [
                .product(name: "Logging", package: "swift-log"),
            ]
        ),
        // Tests Targets
        .testTarget(
            name: "KippleDiagnosticsTests",
            dependencies: [
                .target(name: "KippleDiagnostics"),
            ]
        ),
    ]
)
