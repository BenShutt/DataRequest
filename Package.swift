// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let name = "DataRequest"
let package = Package(
    name: name,
    platforms: [
        .macOS(.v13),
        .iOS(.v16)
    ],
    products: [
        .library(
            name: name,
            targets: [name]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/Alamofire/Alamofire.git",
            .upToNextMajor(from: "5.8.0")
        ),
        .package(
            url: "https://github.com/SimplyDanny/SwiftLintPlugins",
            .upToNextMajor(from: "0.0.0")
        ),
        .package(
            url: "https://github.com/MakeAWishFoundation/SwiftyMocky",
            branch: "master" // Should match Mintfile
        )
    ],
    targets: [
        .target(
            name: name,
            dependencies: ["Alamofire"],
            path: "Sources",
            plugins: [.plugin(
                name: "SwiftLintBuildToolPlugin",
                package: "SwiftLintPlugins"
            )]
        ),
        .testTarget(
            name: "\(name)Tests",
            dependencies: [
                .byName(name: name),
                "SwiftyMocky"
            ],
            path: "Tests"
        )
    ]
)
