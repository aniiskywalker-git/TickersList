//
//  TickerListUseCaseTests.swift
//  GBM-ChallengeTests
//
//  Created by Ana Victoria Frias on 23/10/23.
//

import XCTest
@testable import GBM_Challenge

final class TickerListUseCaseTests: XCTestCase {
    
    static let tickersList: Tickers = {
        let ticker = Tickers(tickers: [Ticker.stub(name: "Microsoft Corporation",
                                                   symbol: "MSFT",
                                                   stock: Stock.stub(name: "NASDAQ Stock Exchange",
                                                                     acronym: "NASDAQ",
                                                                     country: "USA")),
                                       Ticker.stub(name: "Apple Inc",
                                                   symbol: "AAPL",
                                                   stock: Stock.stub(name: "NASDAQ Stock Exchange",
                                                                     acronym: "NASDAQ",
                                                                     country: "USA")),
                                       Ticker.stub(name: "Amazon.com Inc",
                                                   symbol: "AMZN",
                                                   stock: Stock.stub(name: "NASDAQ Stock Exchange",
                                                                     acronym: "NASDAQ",
                                                                     country: "USA")),
                                       Ticker.stub(name: "Alphabet Inc - Class C",
                                                   symbol: "GOOG",
                                                   stock: Stock.stub(name: "NASDAQ Stock Exchange",
                                                                     acronym: "NASDAQ",
                                                                     country: "USA"))])
        return tickersList
    }()

    enum TickersRepositorySuccessError: Error {
        case failedFetching
    }
    
    class TickersRepositoryMock: TickersRepository {
        var result: Result<Tickers, Error>
        var fetchCompletionCallsCount = 0
        
        init(result: Result<Tickers, Error>) {
            self.result = result
        }
        
        func fetchTickers(completion: @escaping (Result<Tickers, Error>) -> Void) -> Cancellable? {
            completion(result)
            fetchCompletionCallsCount += 1
            return nil
        }
    }
        
    func testTickersListUseCase_whenSuccessfullyFetchesTickers() {
        // given
        var useCaseCompletionCallsCount = 0
        let tickersRepository = TickersRepositoryMock(
            result: .success(TickerListUseCaseTests.tickersList)
        )
        let useCase = DefaultTickersListUseCase(tickersRepository: tickersRepository)
        // when
        _ = useCase.execute(completion: { _ in
            useCaseCompletionCallsCount += 1
        })
            
        // then
        XCTAssertEqual(useCaseCompletionCallsCount, 1)
        XCTAssertEqual(tickersRepository.fetchCompletionCallsCount, 1)
    }
    
    func testTickersUseCase_whenFailedFetchingTickers() {
        // given
        var useCaseCompletionCallsCountCount = 0
        let useCase = DefaultTickersListUseCase(tickersRepository: TickersRepositoryMock(result: .failure(TickersRepositorySuccessError.failedFetching)))
            
        // when
        _ = useCase.execute(completion: { _ in
            useCaseCompletionCallsCountCount += 1
        })
            
        // then
        XCTAssertEqual(useCaseCompletionCallsCountCount, 1)
    }
}

