//
//  DefaultTickerDetailsViewModel.swift
//  GBM-Challenge
//
//  Created by Ana Victoria Frias on 20/10/23.
//

import Foundation
protocol TickerDetailsViewModelInput {
    func viewDidLoad()
    func didGetTickerDetail()
    func didSelectMetrics(dataSetSelected: DataSet)
}

enum DataSet: String {
    case open = "Open"
    case close = "Close"
    case high = "High"
    case low = "Low"
    case volume = "Volume"
}

protocol TickerDetailsViewModelOutput {
    var itemDetail: Observable<[TickerDetailsItemViewModel]> { get}
    var graphicDataSet: Observable<[String: [Double]]> { get }
    var error: Observable<String> { get }
    var tickerName: String { get }
    var tickerSymbol: String { get }
    var tickerStockName: String { get }
    var tickerStockAcronym: String { get }
    var tickerStockCountry: String { get }
    var errorTitle: String { get }
}

typealias TickerDetailsViewModel = TickerDetailsViewModelInput & TickerDetailsViewModelOutput

final class DefaultTickerDetailsViewModel: TickerDetailsViewModel {
    
    private let tickerDetailUseCase: TickerDetailUseCase
    
    private var tickerDetailLoadTask: Cancellable? { willSet { tickerDetailLoadTask?.cancel() } }
    private let mainQueue: DispatchQueueType
    
    var itemDetail: Observable<[TickerDetailsItemViewModel]> = Observable([])
    var graphicDataSet: Observable<[String: [Double]]> = Observable([:])
    var error: Observable<String> = Observable("")
    var tickerName: String
    var tickerSymbol: String
    var tickerStockName: String
    var tickerStockAcronym: String
    var tickerStockCountry: String
    var errorTitle: String = "Error: Can't retrieve EOD details"

    init(ticker: TickersListItemViewModel,
         tickerDetailUseCase: TickerDetailUseCase,
         mainQueue: DispatchQueueType = DispatchQueue.main) {
        self.tickerName = ticker.name ?? ""
        self.tickerSymbol = ticker.symbol ?? ""
        self.tickerStockName = ticker.stockName ?? ""
        self.tickerStockAcronym = ticker.acronym ?? ""
        self.tickerStockCountry = ticker.country ?? ""
        self.mainQueue = mainQueue
        self.tickerDetailUseCase = tickerDetailUseCase
    }
    
    func viewDidLoad() { }
    
    func didGetTickerDetail() {
        loadItemDetail()
    }
    
    func didSelectMetrics(dataSetSelected: DataSet) {
        switch dataSetSelected {
        case .open:
            graphicDataSet.value[dataSetSelected.rawValue] = itemDetail.value.compactMap { $0.open }
        case .close:
            graphicDataSet.value[dataSetSelected.rawValue] = itemDetail.value.compactMap { $0.close }
        case .high:
            graphicDataSet.value[dataSetSelected.rawValue] = itemDetail.value.compactMap { $0.high }
        case .low:
            graphicDataSet.value[dataSetSelected.rawValue] = itemDetail.value.compactMap { $0.low }
        case .volume:
            graphicDataSet.value[dataSetSelected.rawValue] = itemDetail.value.compactMap { $0.volume }
        }
    }
    
    private func loadItemDetail() {
        tickerDetailLoadTask = tickerDetailUseCase.execute(symbol: tickerSymbol, completion: { [weak self] result in
            self?.mainQueue.async {
                switch result {
                case .success(let tickerDetail):
                    self?.itemDetail.value = tickerDetail.tickerDetail.eodItem.map(TickerDetailsItemViewModel.init)
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
