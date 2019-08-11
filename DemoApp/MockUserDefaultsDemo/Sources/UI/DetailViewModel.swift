//
//  DetailViewModel.swift
//  MockUserDefaultsDemo
//
//  Created by 417.72KI on 2019/08/12.
//  Copyright © 2019 417.72KI. All rights reserved.
//

import Foundation
import RxCocoa
import RxRelay
import RxSwift

final class DetailViewModel: UsesUseCase {
    let useCase: UseCase = MixInUseCase()

    private let bag = DisposeBag()

    fileprivate let modelRelay = BehaviorRelay<Model>(value: Model(key: "", value: nil))
    fileprivate let completedRelay = PublishRelay<Void>()
}

extension DetailViewModel {
    var model: Model {
        get { return modelRelay.value }
        set { modelRelay.accept(newValue) }
    }
}

extension DetailViewModel {
    func save() {
        useCase.save(model)
        completedRelay.accept(())
    }
}

// MARK: Rx extensions
extension DetailViewModel: ReactiveCompatible {}

extension Reactive where Base == DetailViewModel {
    var model: Observable<Model> {
        return base.modelRelay.asObservable()
    }

    var completed: Observable<Void> {
        return base.completedRelay.asObservable()
    }
}
