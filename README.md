# MockUserDefaults
[![Build Status](https://travis-ci.com/417-72KI/MockUserDefaults.svg?branch=master)](https://travis-ci.com/417-72KI/MockUserDefaults)
[![Version](http://img.shields.io/cocoapods/v/MockUserDefaults.svg?style=flat)](http://cocoapods.org/pods/MockUserDefaults)
[![Platform](http://img.shields.io/cocoapods/p/MockUserDefaults.svg?style=flat)](http://cocoapods.org/pods/MockUserDefaults)
[![GitHub release](https://img.shields.io/github/release/417-72KI/MockUserDefaults/all.svg)](https://github.com/417-72KI/MockUserDefaults/releases)
![Swift](https://img.shields.io/badge/Swift-4.2-orange.svg)
[![GitHub license](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://raw.githubusercontent.com/417-72KI/MockUserDefaults/master/LICENSE)

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
