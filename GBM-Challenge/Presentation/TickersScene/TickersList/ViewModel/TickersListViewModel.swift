//
//  TickersListViewModel.swift
//  GBM-Challenge
//
//  Created by Ana Victoria Frias on 18/10/23.
//

import Foundation

struct TickersListViewModelActions {
    let showTickersDetail: (TickersListItemViewModel) -> Void
}

protocol TickersListViewModelInput {
    func viewDidLoad()
    func didGetTickers()
    func didSelectItem(with ticker: TickersListItemViewModel)
}

protocol TickersListViewModelOutput {
    var items: Observable<[TickersListItemViewModel]> { get }
    var error: Observable<String> { get }
    var isEmpty: Bool { get }
    var screenTitle: String { get }
    var errorTitle: String { get }
    var emptyDataTitle: String { get }
}
typealias TickersListViewModel = TickersListViewModelInput & TickersListViewModelOutput
    
final class DefaultTickersListViewModel: TickersListViewModel {
    
    private let tickersListUseCase: TickersListUseCase
    private let actions: TickersListViewModelActions?
    
    private var tickersLoadTask: Cancellable? { willSet { tickersLoadTask?.cancel() } }
    private let mainQueue: DispatchQueueType
    
    var items: Observable<[TickersListItemViewModel]> = Observable([])
    var error: Observable<String> = Observable("")
    var isEmpty: Bool { return items.value.isEmpty }
    var screenTitle: String = "Today's Tickers"
    var errorTitle: String = "Error: Can't retrieve"
    var emptyDataTitle = "No Tickers for today"
    
    init(
        tickersListUseCase: TickersListUseCase,
        actions: TickersListViewModelActions? = nil,
        mainQueue: DispatchQueueType = DispatchQueue.main
    ) {
        self.tickersListUseCase = tickersListUseCase
        self.actions = actions
        self.mainQueue = mainQueue
    }
    
    func didGetTickers() {
        loadItems()
    }
    
    private func loadItems() {
        tickersLoadTask = tickersListUseCase.execute(completion: { [weak self] result in
            self?.mainQueue.async {
                switch result {
                case .success(let tickers):
                    self?.items.value = tickers.tickers.map(TickersListItemViewModel.init)
                case .failure(let error):
                    self?.handle(error: error)
                }
            }
        })
        
        
    }
    private func handle(error: Error) {
        self.error.value = error.isInternetConnectionError ?
        "No internet connection" :
        "Failed loading movies"
    }
    
}

extension DefaultTickersListViewModel {
    
    func viewDidLoad() { }
    
    func didSelectItem(with ticker: TickersListItemViewModel) {
        print("selected item\(ticker)")
        actions?.showTickersDetail(ticker)
    }
}
