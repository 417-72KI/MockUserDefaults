// swift-tools-version:5.1
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
        //     name: "MockUserDefaultsSwift5Tests",
        //     dependencies: ["MockUserDefaults"]
        // ),
    ]
)
