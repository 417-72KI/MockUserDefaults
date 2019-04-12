# MockUserDefaults
[![Build Status](https://travis-ci.com/417-72KI/MockUserDefaults.svg?token=Psmbc5tqUwP8KEKGUZaz&branch=master)](https://travis-ci.com/417-72KI/MockUserDefaults)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Swift 4.2](https://img.shields.io/badge/Swift-4.2-orange.svg?style=flat)](https://swift.org/)

`MockUserDefaults` is a simple replacement for `NSUserDefaults`/`UserDefaults` to make test easier.

## Installation
### CocoaPods
```ruby:Podfile
pod 'MockUserDefaults', '~> 1.0'
```

### Carthage
```ruby:Cartfile
github "417-72KI/MockUserDefaults" ~> 1.0
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
let userDefaults: UserDefaults = .mocked
userDefaults.set("string", forKey: "key")

XCTAssertEqual(userDefaults.string(forKey: "key"), "string")
```
