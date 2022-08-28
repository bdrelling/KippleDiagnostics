// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "KippleDiagnostics",
    products: [
        .library(name: "KippleDiagnostics", targets: ["KippleDiagnostics"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-log", from: "1.4.4"),
    ],
    targets: [
        // Product Targets
        .target(
            name: "KippleDiagnostics",
            dependencies: [
                .product(name: "Logging", package: "swift-log"),
            ],
            swiftSettings: [
                .define("DEBUG", .when(configuration: .debug)),
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

#if swift(>=5.5)
// Add Kipple Tools if possible.
package.dependencies.append(
    .package(url: "https://github.com/swift-kipple/Tools", from: "0.3.0")
)
#endif
