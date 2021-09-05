// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "MockUserDefaults",
    platforms: [
        .macOS(.v10_14),
        .iOS(.v11),
        .tvOS(.v11),
        .watchOS(.v2)
    ],
    products: [
        .library(
            name: "MockUserDefaults",
            targets: ["MockUserDefaults"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "MockUserDefaults",
            dependencies: []),
        .testTarget(
            name: "MockUserDefaultsTests",
            dependencies: ["MockUserDefaults"]
        ),
        .testTarget(
            name: "MockUserDefaultsSwiftTests",
            dependencies: ["MockUserDefaults"]
        ),
    ]
)
