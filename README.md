# MockUserDefaults
[![Test](https://github.com/417-72KI/MockUserDefaults/actions/workflows/test.yml/badge.svg)](https://github.com/417-72KI/MockUserDefaults/actions/workflows/test.yml)
[![GitHub release](https://img.shields.io/github/release/417-72KI/MockUserDefaults/all.svg)](https://github.com/417-72KI/MockUserDefaults/releases)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2F417-72KI%2FMockUserDefaults%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/417-72KI/MockUserDefaults)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2F417-72KI%2FMockUserDefaults%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/417-72KI/MockUserDefaults)
[![Platform](http://img.shields.io/cocoapods/p/MockUserDefaults.svg?style=flat)](http://cocoapods.org/pods/MockUserDefaults)
[![Version](http://img.shields.io/cocoapods/v/MockUserDefaults.svg?style=flat)](http://cocoapods.org/pods/MockUserDefaults)
[![GitHub license](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://raw.githubusercontent.com/417-72KI/MockUserDefaults/master/LICENSE)

`MockUserDefaults` is a simple replacement for `NSUserDefaults`/`UserDefaults` to make test easier.

## Installation
### SwiftPM (recommended)
```swift:Package.swift
.package(url: "https://github.com/417-72KI/MockUserDefaults.git", from: "2.4.0"),
```

### CocoaPods
```ruby:Podfile
pod 'MockUserDefaults'
```

## Usage
### Objective-C
```objc
NSUserDefaults *userDefaults = [NSUserDefaults mockedUserDefaults];
[userDefaults setObject:@"string" forKey:@"key"];

XCTAssertEqualObjects([userDefaults objectForKey:@"key"], @"string");
```
### Swift
```swift
let userDefaults: UserDefaults = .mock
userDefaults.set("string", forKey: "key")

XCTAssertEqual(userDefaults.string(forKey: "key"), "string")
```

## Demo
### Create project
#### First time

```
make init_demo_app
```

#### After the first time

```
make demo_app
```

### Usage

1. open `MockUserDefaultsDemo.xcworkspace`
1. Build and run app (⌘+R) in iPhone / iPad Simulator
1. Add any keys and values
1. Run test (⌘+U) in same simulator
1. Re-run app (⌘+R) in same simulator
1. You can see that the app isn't affected by the test.
