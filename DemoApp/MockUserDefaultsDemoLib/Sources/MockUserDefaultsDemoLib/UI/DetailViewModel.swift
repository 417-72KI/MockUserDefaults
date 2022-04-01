//
//  DetailViewModel.swift
//  MockUserDefaultsDemo
//
//  Created by 417.72KI on 2019/08/12.
//  Copyright © 2019 417.72KI. All rights reserved.
//

import Combine
import Foundation

public final class DetailViewModel: UsesUseCase {
    let useCase: UseCase = MixInUseCase()

    private let _model = CurrentValueSubject<Model, Never>(.init(key: "", value: nil))
    private let _completed = PassthroughSubject<Void, Never>()

    public init() {
    }
}

public extension DetailViewModel {
    var model: Model {
        get { _model.value }
        set { _model.send(newValue) }
    }

    var modelPublisher: AnyPublisher<Model, Never> { _model.eraseToAnyPublisher() }
    var completed: AnyPublisher<Void, Never> { _completed.eraseToAnyPublisher() }
}

public extension DetailViewModel {
    func save() {
        useCase.save(model)
        _completed.send()
    }
}
