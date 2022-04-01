//
//  UseCase.swift
//  MockUserDefaultsDemo
//
//  Created by 417.72KI on 2019/08/11.
//  Copyright © 2019 417.72KI. All rights reserved.
//

import Foundation

public protocol UsesUseCase {
    var useCase: UseCase { get }
}

public protocol UseCase: UsesUserDefaults {
    func fetchAll() async -> [Model]
    func save(_ model: Model)
}

public extension UseCase {
    func fetchAll() async -> [Model] {
        userDefaults.dictionaryRepresentation()
            .filter { !$0.key.starts(with: "NS") && !$0.key.starts(with: "Apple") } // Exclude System keys
            .filter { !["AddingEmojiKeybordHandled",
                        "PKKeychainVersionKey",
                        "AKLastIDMSEnvironment"].contains($0.key) }
            .mapValues { "\($0)" }
            .map(Model.init)
            .sorted()
    }

    func save(_ model: Model) {
        userDefaults.set(model.value, forKey: model.key)
    }
}
