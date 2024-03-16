// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "home-observer",
    platforms: [.macOS(.v14)],
    dependencies: [
        .package(url: "https://github.com/lemo-nade-room/cli-kit.git", from: "0.2.0"),
        .package(url: "https://github.com/vapor/fluent-sqlite-driver.git", from: "4.0.0"),
    ],
    targets: [
        .executableTarget(
            name: "HomeObserver",
            dependencies: [
                .product(name: "CLIKit", package: "cli-kit"),
                .product(name: "FluentSQLiteDriver", package: "fluent-sqlite-driver"),
            ]),
        .testTarget(name: "HomeObserverTests", dependencies: ["HomeObserver"]),
    ]
)
