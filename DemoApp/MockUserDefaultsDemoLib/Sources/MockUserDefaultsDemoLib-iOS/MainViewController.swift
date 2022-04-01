//
//  MainViewController.swift
//  MockUserDefaultsDemo
//
//  Created by 417.72KI on 2019/07/07.
//  Copyright © 2019 417.72KI. All rights reserved.
//

import Combine
import UIKit
import MockUserDefaultsDemoLib

public var mainView: some UIViewController {
    UIStoryboard(name: "Main", bundle: Bundle.module)
        .instantiateInitialViewController()!
}

final class MainViewController: UIViewController {
    private let viewModel: MainViewModel
    private var cancellables: Set<AnyCancellable> = []
    private var notificationObserver: NSObjectProtocol?

    init?(coder: NSCoder, viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        self.viewModel = MainViewModel()
        super.init(coder: coder)
    }

    // MARK: Outlets
    @IBOutlet private weak var tableView: UITableView! {
        didSet { tableView.dataSource = self }
    }

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.modelPublisher
            .sink { [weak tableView] _ in tableView?.reloadData() }
            .store(in: &cancellables)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetch()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        notificationObserver = NotificationCenter.default
            .addObserver(forName: UIApplication.didBecomeActiveNotification,
                         object: nil,
                         queue: nil) { [viewModel] _ in
            viewModel.fetch()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        if let notificationObserver = notificationObserver {
            NotificationCenter.default.removeObserver(notificationObserver)
        }
        notificationObserver = nil
        super.viewWillDisappear(animated)
    }

    @IBSegueAction
    func add(_ coder: NSCoder) -> DetailViewController? {
        return DetailViewController(coder: coder,
                                    viewModel: .init(model: .init()))

    }

    @IBSegueAction
    private func edit(_ coder: NSCoder) -> DetailViewController? {
        guard let indexPath = tableView.indexPathForSelectedRow else { return nil }
        return DetailViewController(coder: coder,
                                    viewModel: .init(model: viewModel.models[indexPath.row]))
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = item.key
        cell.detailTextLabel?.text = item.value
        return cell
    }
}
