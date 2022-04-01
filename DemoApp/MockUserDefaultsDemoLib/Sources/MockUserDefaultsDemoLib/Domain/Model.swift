//
//  Model.swift
//  MockUserDefaultsDemo
//
//  Created by 417.72KI on 2019/08/10.
//  Copyright © 2019 417.72KI. All rights reserved.
//

import Foundation

public struct Model {
    public var key: String
    public var value: String?
}

extension Model: Equatable {
}

extension Model: Comparable {
    public static func < (lhs: Model, rhs: Model) -> Bool {
        return lhs.key < rhs.key
    }
}

public protocol HasModel {
    var model: Model { get set }
}
