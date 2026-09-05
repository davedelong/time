// swift-tools-version:6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Time",
    platforms: [
        .macOS(.v14),
        .iOS(.v17),
        .tvOS(.v17),
        .watchOS(.v10),
        .macCatalyst(.v17),
    ],
    products: [
        .library(name: "Time", targets: ["Time"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.5.0"),
        .package(url: "https://github.com/SimplyDanny/SwiftLintPlugins", from: "0.65.0")
    ],
    targets: [
        .target(name: "Time",
                dependencies: [],
                plugins: [.plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLintPlugins")]),
        
        .target(name: "TestSupport", dependencies: ["Time"], path: "Tests/TestSupport"),
        .testTarget(name: "TimeTests", dependencies: ["Time", "TestSupport"]),
        .testTarget(name: "FlakyTests", dependencies: ["Time", "TestSupport"])
    ]
)
