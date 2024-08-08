// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "IOSUX",
    platforms: [
        .iOS(.v13), // Adjust if needed
    ],
    products: [
        .library(
            name: "IOSUX",
            targets: ["IOSUX"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/murali-elite/IOSUIToolKit.git", branch: "main"),
        .package(url: "https://github.com/murali-elite/IOSServices.git", branch: "main"),
        .package(url: "https://github.com/SimplyDanny/SwiftLintPlugins.git", branch: "main"),
    ],
    targets: [
        .target(
            name: "IOSUX",
            dependencies: [
                .product(name: "IOSUIToolKit", package: "IOSUIToolKit"),
                .product(name: "IOSServices", package: "IOSServices"),
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
