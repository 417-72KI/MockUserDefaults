//
//  MainViewModel.swift
//  MockUserDefaultsDemo
//
//  Created by 417.72KI on 2019/08/10.
//  Copyright © 2019 417.72KI. All rights reserved.
//

import Combine
import Foundation
import MockUserDefaultsDemoLib

@MainActor
final class MainViewModel: UsesUseCase {
    let useCase: UseCase = MixInUseCase()

    private let _model = CurrentValueSubject<[Model], Never>([])

    public init() {
    }
}

extension MainViewModel {
    var models: [Model] { _model.value }
    var modelPublisher: AnyPublisher<[Model], Never> { _model.eraseToAnyPublisher() }
}

extension MainViewModel {
    func fetch() {
        Task {
            let models = await useCase.fetchAll()
            _model.send(models)
        }
    }
}
