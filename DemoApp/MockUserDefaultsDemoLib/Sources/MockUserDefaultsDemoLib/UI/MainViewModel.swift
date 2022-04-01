//
//  MainViewModel.swift
//  MockUserDefaultsDemo
//
//  Created by 417.72KI on 2019/08/10.
//  Copyright © 2019 417.72KI. All rights reserved.
//

import Combine
import Foundation

@MainActor
public final class MainViewModel: UsesUseCase {
    let useCase: UseCase = MixInUseCase()

    private let _model = CurrentValueSubject<[Model], Never>([])

    public init() {
    }
}

public extension MainViewModel {
    var models: [Model] { _model.value }
    var modelPublisher: AnyPublisher<[Model], Never> { _model.eraseToAnyPublisher() }
}

public extension MainViewModel {
    func fetch() {
        Task {
            let models = await useCase.fetchAll()
            _model.send(models)
        }
    }
}
