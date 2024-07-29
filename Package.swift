// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "IOSUX",
    platforms: [
        .iOS(.v13), // iOS 15 and later
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "IOSUX",
            targets: ["IOSUX"]),
    ],
    dependencies: [
        .package(url:"https://github.com/murali-elite/IOSUIToolKit.git", branch: "main"),
        .package(url: "https://github.com/SimplyDanny/SwiftLintPlugins.git", branch: "main"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "IOSUX",
            dependencies: [
                .product(
                    name: "IOSUIToolKit",
                    package: "IOSUIToolKit")
            ],
            resources: [
                .process("Resources")
            ],
            plugins: [
                .plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLintPlugins")
            ]
        ),
        .testTarget(
            name: "IOSUXTests",
            dependencies: ["IOSUX"],
            plugins: [
                .plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLintPlugins")
            ]
        ),
    ]
)
