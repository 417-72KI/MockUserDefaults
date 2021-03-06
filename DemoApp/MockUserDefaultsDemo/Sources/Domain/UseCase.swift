//
//  UseCase.swift
//  MockUserDefaultsDemo
//
//  Created by 417.72KI on 2019/08/11.
//  Copyright © 2019 417.72KI. All rights reserved.
//

import Foundation
import RxSwift

protocol UsesUseCase {
    var useCase: UseCase { get }
}

protocol UseCase: UsesUserDefaults {
    func fetchAll() -> Single<[Model]>
    func save(_ model: Model)
}

extension UseCase {
    func fetchAll() -> Single<[Model]> {
        return Single.create { [userDefaults] event in
            let dictionary = userDefaults.dictionaryRepresentation()
                // Exclude System keys
                .filter { !$0.key.starts(with: "NS") && !$0.key.starts(with: "Apple") }
                .filter { !["AddingEmojiKeybordHandled",
                            "PKKeychainVersionKey",
                            "AKLastIDMSEnvironment"].contains($0.key) }
            event(.success(dictionary.mapValues { "\($0)" }.map(Model.init).sorted()))
            return Disposables.create()
        }
    }

    func save(_ model: Model) {
        userDefaults.set(model.value, forKey: model.key)
    }
}
