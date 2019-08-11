//
//  MainViewModel.swift
//  MockUserDefaultsDemo
//
//  Created by 417.72KI on 2019/08/10.
//  Copyright © 2019 417.72KI. All rights reserved.
//

import Foundation
import RxRelay
import RxSwift

final class MainViewModel: UsesUseCase {
    let useCase: UseCase = MixInUseCase()

    private let bag = DisposeBag()
    fileprivate let modelRelay = BehaviorRelay<[Model]>(value: [])
    fileprivate let errorRelay = PublishRelay<Error>()
}

extension MainViewModel {
    func fetch() {
        useCase.fetchAllSettings()
            .subscribe(
                onSuccess: { [modelRelay] in modelRelay.accept($0) },
                onError: { [errorRelay] in errorRelay.accept($0) }
            )
            .disposed(by: bag)
    }
}

// MARK: Rx extensions
extension MainViewModel: ReactiveCompatible {
}

extension Reactive where Base == MainViewModel {
    var model: Observable<[Model]> {
        return base.modelRelay.asObservable()
    }

    var error: Observable<Error> {
        return base.errorRelay.asObservable()
    }
}
