// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Time",
    products: [
        .library(name: "Time", targets: ["Time"])
    ],
    dependencies: [
        
    ],
    targets: [
        .target(name: "Time", dependencies: []),
        
        .testTarget(name: "TimeTests", dependencies: ["Time"]),
    ]
)
