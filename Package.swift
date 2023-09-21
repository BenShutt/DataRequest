// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DataRequest",
    platforms: [
        .macOS(.v13),
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "DataRequest",
            targets: ["DataRequest"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/Alamofire/Alamofire.git",
            .upToNextMajor(from: "5.8.0")
        )
    ],
    targets: [
        .target(
            name: "DataRequest",
            dependencies: ["Alamofire"],
            path: "Sources"
        ),
        .testTarget(
            name: "DataRequestTests",
            dependencies: ["DataRequest"],
            path: "Tests"
        )
    ]
)
