// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

#if os(macOS)
let dependencies: [Dependency] = [.alamofire, .swiftLint]
let plugins: [Plugin] = [.swiftLint]
#else
let dependencies: [Dependency] = [.alamofire]
let plugins: [Plugin] = []
#endif

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
    dependencies: dependencies,
    targets: [
        .target(
            name: name,
            dependencies: ["Alamofire"],
            path: "Sources",
            plugins: plugins
        ),
        .testTarget(
            name: "\(name)Tests",
            dependencies: [.byName(name: name)],
            path: "Tests",
            plugins: plugins
        )
    ]
)

// MARK: - Dependency

typealias Dependency = Package.Dependency
extension Dependency {
    static var alamofire: Dependency {
        .package(
            url: "https://github.com/Alamofire/Alamofire.git",
            .upToNextMajor(from: "5.8.0")
        )
    }

    static var swiftLint: Dependency {
        .package(
            url: "https://github.com/SimplyDanny/SwiftLintPlugins",
            .upToNextMajor(from: "0.0.0")
        )
    }
}

// MARK: - Plugin

typealias Plugin = PackageDescription.Target.PluginUsage
extension Plugin {
    static var swiftLint: Plugin {
        .plugin(
            name: "SwiftLintBuildToolPlugin",
            package: "SwiftLintPlugins"
        )
    }
}
