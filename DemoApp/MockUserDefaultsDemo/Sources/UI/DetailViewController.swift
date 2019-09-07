//
//  DetailViewController.swift
//  MockUserDefaultsDemo
//
//  Created by 417.72KI on 2019/08/12.
//  Copyright © 2019 417.72KI. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class DetailViewController: UIViewController, HasModel {

    var model: Model {
        get { return viewModel.model }
        set { viewModel.model = newValue }
    }

    private let viewModel = DetailViewModel()
    private let bag = DisposeBag()

    // MARK: Outlets
    @IBOutlet private weak var keyLabel: UILabel!
    @IBOutlet private weak var keyTextField: UITextField!
    @IBOutlet private weak var valueTextField: UITextField!
    @IBOutlet private weak var saveButton: UIButton!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        bag.insert(
            viewModel.rx.model.map { $0.key }
                .bind(to: keyLabel.rx.text),
            viewModel.rx.model.map { $0.key }
                .bind(to: keyTextField.rx.text),
            viewModel.rx.model.map { $0.value }
                .bind(to: valueTextField.rx.text),
            viewModel.rx.completed
                .subscribe(onNext: { [unowned self] in self.back() }),
            keyTextField.rx.text.map { $0 ?? "" }
                .subscribe(onNext: { [viewModel] in
                    viewModel.model.key = $0
                }),
            keyTextField.rx.text.map { !($0 ?? "").isEmpty }
                .bind(to: saveButton.rx.isEnabled),
            valueTextField.rx.text
                .subscribe(onNext: { [viewModel] in
                    viewModel.model.value = $0
                }),
            saveButton.rx.tap
                .subscribe(onNext: { [viewModel] in viewModel.save() })
        )

        keyLabel.isHidden = model.key.isEmpty
        keyTextField.isHidden = !keyLabel.isHidden
    }
}
