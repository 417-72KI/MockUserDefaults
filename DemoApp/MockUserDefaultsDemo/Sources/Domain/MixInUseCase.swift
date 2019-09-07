//
//  MixInUseCase.swift
//  MockUserDefaultsDemo
//
//  Created by 417.72KI on 2019/08/11.
//  Copyright © 2019 417.72KI. All rights reserved.
//

import Foundation

final class MixInUseCase: UseCase {
    let userDefaults: UserDefaults = .standard
}
