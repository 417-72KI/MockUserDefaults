// swift-tools-version:4.2
import PackageDescription

let package = Package(
    name: "MockUserDefaults",
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
        // FIXME: `Type 'UserDefaults' has no member 'mocked'` in test code via Package.swift
        // .testTarget(
        //     name: "MockUserDefaultsSwift4_2Tests",
        //     dependencies: ["MockUserDefaults"]
        // ),
    ]
)
