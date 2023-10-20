//
//  TickersViewController.swift
//  GBM-Challenge
//
//  Created by Ana Victoria Frias on 19/10/23.
//

import UIKit


final class TickersViewController: UIViewController, StoryboardInstantiable, Alertable {

    @IBOutlet weak var emptyDataLabel: UILabel!
    private var viewModel: TickersListViewModel!
    
    private var tickersTableViewController: TickersTableViewController?
    
    static func create(
        with viewModel: TickersListViewModel
    ) -> TickersViewController {
        let view = TickersViewController.instantiateViewController()
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        viewModel.didGetTickers()
        bind(to: viewModel)
    }
    
    private func bind(to viewModel: TickersListViewModel) {
        //To bind updates, reloads, changes
        viewModel.items.observe(on: self) { [weak self] _ in self?.updateItems() }
        viewModel.error.observe(on: self) { [weak self] in self?.showError($0) }
    }
    

    private func setupViews() {
        title = viewModel.screenTitle
        emptyDataLabel.text = viewModel.emptyDataTitle
    }
    
    private func updateItems() {
        tickersTableViewController?.reload()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == String(describing: TickersTableViewController.self),
            let destinationVC = segue.destination as? TickersTableViewController {
            tickersTableViewController = destinationVC
            tickersTableViewController?.viewModel = viewModel
        }
    }
    
    private func showError(_ error: String) {
        guard !error.isEmpty else { return }
        showAlert(title: viewModel.errorTitle, message: error)
    }
    
    
}
