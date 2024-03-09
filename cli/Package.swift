// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "home-observer",
    platforms: [.macOS(.v14)],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.92.4"),
    ],
    targets: [
        .executableTarget(name: "HomeObserver"),
        .testTarget(name: "HomeObserverTests", dependencies: ["HomeObserver"]),
    ]
)
