//
//  MainViewController.swift
//  MockUserDefaultsDemo
//
//  Created by 417.72KI on 2019/07/07.
//  Copyright © 2019 417.72KI. All rights reserved.
//

import RxCocoa
import RxDataSources
import RxSwift
import UIKit

class MainViewController: UIViewController {

    private let viewModel = MainViewModel()
    private let bag = DisposeBag()

    private let dataSource = RxTableViewSectionedReloadDataSource<SectionModel>(configureCell: { _, tableView, indexPath, item -> UITableViewCell in
        guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.cell, for: indexPath) else { fatalError("No cell") }
        cell.textLabel?.text = item.key
        cell.detailTextLabel?.text = item.value
        return cell
    })

    private var notificationObserver: NSObjectProtocol?

    // MARK: Outlets
    @IBOutlet private weak var tableView: UITableView!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bag.insert(
            viewModel.rx.model
                .map { [SectionModel(header: nil, items: $0)] }
                .bind(to: tableView.rx.items(dataSource: dataSource))
        )
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
}
