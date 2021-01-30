//
//  GenericMultiSelectorVC.swift
//  iTunesSearch
//
//  Created by Mohamed Nassar on 28/01/2021.
//  Copyright © 2021 Nagarro. All rights reserved.
//

import UIKit

typealias SelectableOption = Hashable & Equatable & CustomStringConvertible

final class GenericMultiSelectorVC<T: SelectableOption>: UITableViewController {
    private let cellReuseIdentifier: String = "OptionCell"
    struct Option<T> {
        let id: T
        var isSelected: Bool
    }

    private var options: [Option<T>]
    private var didUpdateSelectionBlock: (GenericMultiSelectorVC, [Option<T>]) -> Void

    init(options: [Option<T>], _ didUpdateSelection: @escaping (GenericMultiSelectorVC, [Option<T>]) -> Void) {
        self.options = options
        self.didUpdateSelectionBlock = didUpdateSelection
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)

        self.clearsSelectionOnViewWillAppear = false

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDoneButton))
    }

    @objc private func didTapDoneButton() {
        didUpdateSelectionBlock(self, options)
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        let option = options[indexPath.row]
        cell.textLabel?.text = option.id.description
        cell.accessoryType = option.isSelected ? .checkmark : .none
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        options[indexPath.row].isSelected.toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }

}
