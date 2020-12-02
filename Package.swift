// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Parser",
    platforms: [
        .macOS(.v11),
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "Parser",
            targets: ["Parser"])
    ],
    dependencies: [
        .package(url: "https://github.com/neutralradiance/swift-theme.git.", from: "0.8")
    ],
    targets: [
        .target(
            name: "Parser",
            dependencies: ["Theme"]),
        .testTarget(
            name: "ParserTests",
            dependencies: ["Parser"])
    ]
)
