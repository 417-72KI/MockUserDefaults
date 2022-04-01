//
//  MixInUseCase.swift
//  MockUserDefaultsDemo
//
//  Created by 417.72KI on 2019/08/11.
//  Copyright © 2019 417.72KI. All rights reserved.
//

import Foundation

public final class MixInUseCase: UseCase {
    public let userDefaults: UserDefaults

    public init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
}
