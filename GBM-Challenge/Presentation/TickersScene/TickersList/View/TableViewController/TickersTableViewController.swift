//
//  TableViewController.swift
//  GBM-Challenge
//
//  Created by Ana Victoria Frias on 17/10/23.
//

import UIKit

final class TickersTableViewController: UITableViewController {

    var viewModel: TickersListViewModel!
    static let reuseIdentifier = String(describing: TickersListItemCell.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    func reload() {
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.value.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TickersTableViewController.reuseIdentifier, for: indexPath) as? TickersListItemCell else {
            assertionFailure("Cannot dequeue reusable cell \(TickersListItemCell.self) with reuseIdentifier: \(TickersTableViewController.reuseIdentifier)")
            return UITableViewCell() }
        cell.configure(with: viewModel.items.value[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectItem(with: viewModel.items.value[indexPath.row].symbol ?? "")
    }
}
