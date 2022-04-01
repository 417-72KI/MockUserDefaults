//
//  UserDefaults+Util.swift
//  MockUserDefaultsDemo
//
//  Created by 417.72KI on 2019/07/07.
//  Copyright © 2019 417.72KI. All rights reserved.
//

import Foundation

public protocol UsesUserDefaults {
    var userDefaults: UserDefaults { get }
}

// MARK: - KeyNamespaceable
protocol KeyNamespaceable {
    func namespaced<T: RawRepresentable>(_ key: T) -> String
}

extension KeyNamespaceable {
    func namespaced<T: RawRepresentable>(_ key: T) -> String {
        return "\(Self.self).\(key.rawValue)"
    }
}

// MARK: - String
protocol StringDefaultSettable: KeyNamespaceable {
    associatedtype StringKey: RawRepresentable
}

extension StringDefaultSettable where StringKey.RawValue == String {
    func set(_ value: String?, forKey key: StringKey, toUserDefaults ud: UserDefaults = .standard) {
        let key = namespaced(key)
        ud.set(value, forKey: key)
    }

    func remove(forKey key: StringKey, fromUserDefaults ud: UserDefaults = .standard) {
        let key = namespaced(key)
        ud.removeObject(forKey: key)
    }

    @discardableResult
    func string(forKey key: StringKey, fromUserDefaults ud: UserDefaults = .standard) -> String? {
        let key = namespaced(key)
        return ud.string(forKey: key)
    }
}

// MARK: - Int
protocol IntegerDefaultSettable: KeyNamespaceable {
    associatedtype IntegerKey: RawRepresentable
}

extension IntegerDefaultSettable where IntegerKey.RawValue == String {
    func set(_ value: Int, forKey key: IntegerKey, toUserDefaults ud: UserDefaults = .standard) {
        let key = namespaced(key)
        ud.set(value, forKey: key)
    }

    func remove(forKey key: IntegerKey, fromUserDefaults ud: UserDefaults = .standard) {
        let key = namespaced(key)
        ud.removeObject(forKey: key)
    }

    @discardableResult
    func integer(forKey key: IntegerKey, fromUserDefaults ud: UserDefaults = .standard) -> Int {
        let key = namespaced(key)
        return ud.integer(forKey: key)
    }
}

// MARK: - Double
protocol DoubleDefaultSettable: KeyNamespaceable {
    associatedtype DoubleKey: RawRepresentable
}

extension DoubleDefaultSettable where DoubleKey.RawValue == String {
    func set(_ value: Double, forKey key: DoubleKey, toUserDefaults ud: UserDefaults = .standard) {
        let key = namespaced(key)
        ud.set(value, forKey: key)
    }

    func remove(forKey key: DoubleKey, fromUserDefaults ud: UserDefaults = .standard) {
        let key = namespaced(key)
        ud.removeObject(forKey: key)
    }

    @discardableResult
    func double(forKey key: DoubleKey, fromUserDefaults ud: UserDefaults = .standard) -> Double {
        let key = namespaced(key)
        return ud.double(forKey: key)
    }
}

// MARK: - Float
protocol FloatDefaultSettable: KeyNamespaceable {
    associatedtype FloatKey: RawRepresentable
}

extension FloatDefaultSettable where FloatKey.RawValue == String {
    func set(_ value: Float, forKey key: FloatKey, toUserDefaults ud: UserDefaults = .standard) {
        let key = namespaced(key)
        ud.set(value, forKey: key)
    }

    func remove(forKey key: FloatKey, fromUserDefaults ud: UserDefaults = .standard) {
        let key = namespaced(key)
        ud.removeObject(forKey: key)
    }

    @discardableResult
    func float(forKey key: FloatKey, fromUserDefaults ud: UserDefaults = .standard) -> Float {
        let key = namespaced(key)
        return ud.float(forKey: key)
    }
}

// MARK: - Bool
protocol BoolDefaultSettable: KeyNamespaceable {
    associatedtype BoolKey: RawRepresentable
}

extension BoolDefaultSettable where BoolKey.RawValue == String {
    func set(_ value: Bool, forKey key: BoolKey, toUserDefaults ud: UserDefaults = .standard) {
        let key = namespaced(key)
        ud.set(value, forKey: key)
    }

    func remove(forKey key: BoolKey, fromUserDefaults ud: UserDefaults = .standard) {
        let key = namespaced(key)
        ud.removeObject(forKey: key)
    }

    @discardableResult
    func bool(forKey key: BoolKey, fromUserDefaults ud: UserDefaults = .standard) -> Bool {
        let key = namespaced(key)
        return ud.bool(forKey: key)
    }
}

// MARK: - URL
protocol URLDefaultSettable: KeyNamespaceable {
    associatedtype URLKey: RawRepresentable
}

extension URLDefaultSettable where URLKey.RawValue == String {
    func set(_ value: URL?, forKey key: URLKey, toUserDefaults ud: UserDefaults = .standard) {
        let key = namespaced(key)
        ud.set(value, forKey: key)
    }

    func remove(forKey key: URLKey, fromUserDefaults ud: UserDefaults = .standard) {
        let key = namespaced(key)
        ud.removeObject(forKey: key)
    }

    @discardableResult
    func url(forKey key: URLKey, fromUserDefaults ud: UserDefaults = .standard) -> URL? {
        let key = namespaced(key)
        return ud.url(forKey: key)
    }
}
