// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "EventKit",
    platforms: [
      .macOS(.v13),
      .custom("linux", versionString: "5.0")
    ],
    products: [
        .library(
            name: "EventKit",
            targets: ["EventKit"]),
    ],
    targets: [
        .target(
            name: "EventKit",
            path: "Sources/EventKit"
        ),
        .testTarget(
            name: "EventKitTests",
            dependencies: ["EventKit"],
            path: "Tests/EventKitTests"
        ),
    ]
)
