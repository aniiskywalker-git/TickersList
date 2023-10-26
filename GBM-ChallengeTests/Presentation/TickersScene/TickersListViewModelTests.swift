//
//  TickersListViewModelTests.swift
//  GBM-ChallengeTests
//
//  Created by Ana Victoria Frias on 25/10/23.
//

import XCTest
@testable import GBM_Challenge

final class TickersListViewModelTests: XCTestCase {

    private enum TickersListUseCaseError: Error {
        case someError
    }
    
    let tickersList: Tickers = {
        let tickers = Tickers(
            tickers: [
                Ticker.stub(name: "Microsoft Corporation",
                            symbol: "MSFT",
                            stock: Stock.stub(name: "NASDAQ Stock Exchange",
                                              acronym: "NASDAQ",
                                              country: "USA")
                           ),
                Ticker.stub(name: "Apple Inc",
                            symbol: "AAPL",
                            stock: Stock.stub(name: "NASDAQ Stock Exchange",
                                              acronym: "NASDAQ",
                                              country: "USA")
                           ),
                Ticker.stub(name: "Amazon.com Inc",
                            symbol: "AMZN",
                            stock: Stock.stub(name: "NASDAQ Stock Exchange",
                                              acronym: "NASDAQ",
                                              country: "USA")
                           ),
                Ticker.stub(name: "Alphabet Inc - Class C",
                            symbol: "GOOG",
                            stock: Stock.stub(name: "NASDAQ Stock Exchange",
                                              acronym: "NASDAQ",
                                              country: "USA")
                           ),
                Ticker.stub(name: "Alphabet Inc - Class A",
                            symbol: "GOOGL",
                            stock: Stock.stub(
                                name: "NASDAQ Stock Exchange",
                                acronym: "NASDAQ",
                                country: "USA"))
            ])
        return tickers
    }()
    
    class TickersListUseCaseMock: TickersListUseCase {
        var executeCallCount: Int = 0

        typealias ExecuteBlock = (
            (Result<Tickers, Error>) -> Void
        ) -> Void

        lazy var _execute: ExecuteBlock = { _ in
            XCTFail("not implemented")
        }
        
        func execute(completion: @escaping (Result<Tickers, Error>) -> Void) -> Cancellable? {
            executeCallCount += 1
            _execute(completion)
            return nil
        }
    }
    
    func test_whenGetTickersListUseCaseRetrievesEmptyPage_thenViewModelIsEmpty() {
        // given
        let tickersListUseCaseMock = TickersListUseCaseMock()
        
        tickersListUseCaseMock._execute = { completion in
            completion(.success(Tickers(tickers: [Ticker(name: "", symbol: "", stock: nil)])))
        }
        let viewModel = DefaultTickersListViewModel(
            tickersListUseCase: tickersListUseCaseMock,
            mainQueue: DispatchQueueTypeMock())

        // when
        viewModel.didGetTickers()
        
        // then
        XCTAssertTrue(viewModel.items.value.isEmpty)
        XCTAssertEqual(tickersListUseCaseMock.executeCallCount, 1)
        addTeardownBlock { [weak viewModel] in XCTAssertNil(viewModel) }
    }
    
    func test_whenGetTickersListUseCaseRetrievesTickers_thenViewModelContainsTickers() {
        // given
        let tickersListUseCaseMock = TickersListUseCaseMock()
        
        tickersListUseCaseMock._execute = { completion in
            completion(.success(self.tickersList))
        }
        
        let viewModel = DefaultTickersListViewModel(
            tickersListUseCase: tickersListUseCaseMock,
            mainQueue: DispatchQueueTypeMock()
        )
      
        // when
        viewModel.didGetTickers()
        
        // then
        let expectedItems = tickersList.tickers.map { TickersListItemViewModel(ticker: $0) }
        XCTAssertEqual(viewModel.items.value, expectedItems)
        XCTAssertEqual(tickersListUseCaseMock.executeCallCount, 1)
        addTeardownBlock { [weak viewModel] in XCTAssertNil(viewModel) }
    }

    func test_whenSearchMoviesUseCaseReturnsError_thenViewModelContainsError() {
        // given
        let tickersListUseCaseMock = TickersListUseCaseMock()
        
        tickersListUseCaseMock._execute = { completion in
            completion(.failure(TickersListUseCaseError.someError))
        }
        
        let viewModel = DefaultTickersListViewModel.make(
            tickersListUseCase: tickersListUseCaseMock
        )

        // when
        viewModel.didGetTickers()

        // then
        XCTAssertNotNil(viewModel.error)
        XCTAssertTrue(viewModel.items.value.isEmpty)
        XCTAssertEqual(tickersListUseCaseMock.executeCallCount, 1)
        addTeardownBlock { [weak viewModel] in XCTAssertNil(viewModel) }
    }
}

extension DefaultTickersListViewModel {
    static func make(
        tickersListUseCase: TickersListUseCase
    ) -> DefaultTickersListViewModel {
        DefaultTickersListViewModel(
            tickersListUseCase: tickersListUseCase,
            mainQueue: DispatchQueueTypeMock()
        )
    }

}
