//
//  DefaultTickerDetailsViewModel.swift
//  GBM-Challenge
//
//  Created by Ana Victoria Frias on 20/10/23.
//

import Foundation
protocol TickerDetailsViewModelInput {
    func updatePosterImage(width: Int)
}

protocol TickerDetailsViewModelOutput {
    var title: String { get }
    var isPosterImageHidden: Bool { get }
    var overview: String { get }
}

typealias TickerDetailsViewModel = TickerDetailsViewModelInput & TickerDetailsViewModelOutput

final class DefaultTickerDetailsViewModel: TickerDetailsViewModel {
    
    private var TickerDetailLoadTask: Cancellable? { willSet { TickerDetailLoadTask?.cancel() } }
    private let mainQueue: DispatchQueueType
    
    func updatePosterImage(width: Int) {
        
    }
    
    var title: String
    
    var isPosterImageHidden: Bool
    
    var overview: String
    
    init(symbol: String,
         mainQueue: DispatchQueueType = DispatchQueue.main) {
        self.mainQueue = mainQueue
        self.title = ""
        self.isPosterImageHidden = true
        self.overview = ""
    }
}
