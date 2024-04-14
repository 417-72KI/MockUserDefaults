// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "MockUserDefaults",
    platforms: [
        .macOS(.v10_14),
        .iOS(.v11),
        .tvOS(.v11),
        .watchOS(.v4)
    ],
    products: [
        .library(
            name: "MockUserDefaults",
            targets: ["MockUserDefaults"]
        )
    ],
    targets: [
        .target(name: "MockUserDefaults"),
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
