//
//  DetailViewModel.swift
//  MockUserDefaultsDemo
//
//  Created by 417.72KI on 2019/08/12.
//  Copyright © 2019 417.72KI. All rights reserved.
//

import Combine
import Foundation
import MockUserDefaultsDemoLib

@MainActor
final class DetailViewModel: UsesUseCase {
    let useCase: UseCase = MixInUseCase()

    private let _model: CurrentValueSubject<Model, Never>
    private let _completed = PassthroughSubject<Void, Never>()

    init(model: Model = .init(key: "", value: nil)) {
        self._model = .init(model)
    }
}

extension DetailViewModel {
    var model: Model {
        get { _model.value }
        set { _model.send(newValue) }
    }

    var modelPublisher: AnyPublisher<Model, Never> { _model.eraseToAnyPublisher() }
    var completed: AnyPublisher<Void, Never> { _completed.eraseToAnyPublisher() }
}

extension DetailViewModel {
    func save() {
        useCase.save(model)
        _completed.send()
    }
}
