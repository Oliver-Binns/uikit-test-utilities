// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "TestUtilities",
    platforms: [.iOS(.v13)],
    products: [
        .library(name: "TestUtilities", targets: ["TestUtilities"]),
    ],
    targets: [
        .target(name: "TestUtilities", dependencies: []),
        .testTarget(name: "TestUtilitiesTests", dependencies: ["TestUtilities"]),
    ]
)
