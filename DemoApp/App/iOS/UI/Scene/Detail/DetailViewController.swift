//
//  DetailViewController.swift
//  MockUserDefaultsDemo
//
//  Created by 417.72KI on 2019/08/12.
//  Copyright © 2019 417.72KI. All rights reserved.
//

import Combine
import UIKit

final class DetailViewController: UIViewController {

    private let viewModel: DetailViewModel
    private var cancellables: Set<AnyCancellable> = []

    init?(coder: NSCoder, viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: Outlets
    @IBOutlet private weak var keyLabel: UILabel!
    @IBOutlet private weak var keyTextField: UITextField! {
        didSet {
            keyTextField.textPublisher
                .sink { [weak viewModel] in viewModel?.model.key = $0 }
                .store(in: &cancellables)
        }
    }
    @IBOutlet private weak var valueTextField: UITextField! {
        didSet {
            valueTextField.textPublisher
                .sink { [weak viewModel] in viewModel?.model.value = $0 }
                .store(in: &cancellables)
        }
    }
    @IBOutlet private weak var saveButton: UIButton! {
        didSet {
            saveButton.publisher(for: .touchUpInside)
                .sink(receiveValue: { [weak viewModel] in viewModel?.save() })
                .store(in: &cancellables)
        }
    }

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        let model = viewModel.modelPublisher
        let key = model.map(\.key)
            .map(Optional.some)
        key.assign(to: \.text, on: keyLabel)
            .store(in: &cancellables)
        key.assign(to: \.text, on: keyTextField)
            .store(in: &cancellables)

        model.map(\.value)
            .assign(to: \.text, on: valueTextField)
            .store(in: &cancellables)

        keyTextField.textPublisher
            .map(\.isEmpty)
            .map(!)
            .assign(to: \.isEnabled, on: saveButton)
            .store(in: &cancellables)

        viewModel.completed
            .sink(receiveValue: { [weak self] in self?.back() })
            .store(in: &cancellables)

        keyLabel.isHidden = viewModel.model.key.isEmpty
        keyTextField.isHidden = !keyLabel.isHidden
    }
}
