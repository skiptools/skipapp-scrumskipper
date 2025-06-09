// swift-tools-version: 5.9
// This is a Skip (https://skip.tools) package,
// containing a Swift Package Manager project
// that will use the Skip build plugin to transpile the
// Swift Package, Sources, and Tests into an
// Android Gradle Project with Kotlin sources and JUnit tests.
import PackageDescription

let package = Package(
    name: "scrum-skipper",
    defaultLocalization: "en",
    platforms: [.iOS(.v16), .macOS(.v13), .tvOS(.v16), .watchOS(.v9), .macCatalyst(.v16)],
    products: [
        .library(name: "ScrumskipperApp", type: .dynamic, targets: ["Scrumskipper"]),
    ],
    dependencies: [
        .package(url: "https://source.skip.tools/skip.git", from: "1.5.23"),
        .package(url: "https://source.skip.tools/skip-ui.git", from: "1.29.3")
    ],
    targets: [
        .target(name: "Scrumskipper", dependencies: [.product(name: "SkipUI", package: "skip-ui")], resources: [.process("Resources")], plugins: [.plugin(name: "skipstone", package: "skip")]),
        .testTarget(name: "ScrumskipperTests", dependencies: ["Scrumskipper", .product(name: "SkipTest", package: "skip")], resources: [.process("Resources")], plugins: [.plugin(name: "skipstone", package: "skip")]),
    ]
)
