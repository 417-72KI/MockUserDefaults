//
//  SectionModel.swift
//  MockUserDefaultsDemo
//
//  Created by 417.72KI on 2019/07/07.
//  Copyright © 2019 417.72KI. All rights reserved.
//

import Foundation
import RxDataSources

struct SectionModel {
    var header: String?
    var items: [Model]
}

extension SectionModel: SectionModelType {
    init(original: SectionModel, items: [Model]) {
        self = original
        self.items = items
    }
}
