// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "ZLSwipeableViewSwift",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "ZLSwipeableViewSwift",
            targets: ["ZLSwipeableViewSwift"]
        )
    ],
    targets: [
        .target(
            name: "ZLSwipeableViewSwift",
            path: "Sources/ZLSwipeableViewSwift"
        )
    ]
)
