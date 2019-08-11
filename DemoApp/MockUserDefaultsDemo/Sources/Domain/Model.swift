//
//  Model.swift
//  MockUserDefaultsDemo
//
//  Created by 417.72KI on 2019/08/10.
//  Copyright © 2019 417.72KI. All rights reserved.
//

import Foundation

struct Model {
    var key: String
    var value: String?
}

extension Model: Comparable {
    static func < (lhs: Model, rhs: Model) -> Bool {
        return lhs.key < rhs.key
    }
}

protocol HasModel {
    var model: Model { get set }
}
