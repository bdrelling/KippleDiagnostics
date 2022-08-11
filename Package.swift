// swift-tools-version:5.6

import PackageDescription

let package = Package(
    name: "KippleDiagnostics",
    products: [
        .library(name: "KippleDiagnostics", targets: ["KippleDiagnostics"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-log", from: "1.4.3"),
        // Development
        .package(url: "https://github.com/swift-kipple/Tools", from: "0.2.1"),
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
