// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MockUserDefaultsDemoLib",
    defaultLocalization: "ja",
    platforms: [.macOS(.v11), .iOS(.v15)],
    products: [
        .library(
            name: "MockUserDefaultsDemoLib",
            targets: ["MockUserDefaultsDemoLib"]),
        .library(
            name: "MockUserDefaultsDemoLib-iOS",
            targets: ["MockUserDefaultsDemoLib-iOS"])
    ],
    dependencies: [
        .package(name: "MockUserDefaults", path: "../../")
    ],
    targets: [
        .target(
            name: "MockUserDefaultsDemoLib",
            dependencies: []),
        .target(
            name: "MockUserDefaultsDemoLib-iOS",
            dependencies: [
                .target(name: "MockUserDefaultsDemoLib",
                        condition: .when(platforms: [.iOS]))
            ]),
        .testTarget(
            name: "MockUserDefaultsDemoLibTests",
            dependencies: [
                "MockUserDefaultsDemoLib",
                "MockUserDefaults"
            ]),
    ]
)
