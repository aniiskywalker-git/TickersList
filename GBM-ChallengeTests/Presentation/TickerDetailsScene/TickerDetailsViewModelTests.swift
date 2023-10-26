//
//  TickerDetailsViewModelTests.swift
//  GBM-ChallengeTests
//
//  Created by Ana Victoria Frias on 25/10/23.
//

import XCTest
@testable import GBM_Challenge

final class TickerDetailsViewModelTests: XCTestCase {

    private enum TickerDetailsUseCaseError: Error {
        case someError
    }
    
    let tickerDetails: TickerDetailsData = {
        let tickerDetails = TickerDetailsData(
            tickerDetail: TickerDetail.stub(name: "Microsoft Corporation",
                                            symbol: "MSFT",
                                            eodItem: [EodItem(open: 230.0,
                                                              close: 123.4,
                                                              high: 488.0,
                                                              low: 293.93,
                                                              volume: 2880393,
                                                              date: "2023-10-25T00:00:00+0000"),
                                                      EodItem(open: 293.45,
                                                              close: 289.83,
                                                              high: 848.93,
                                                              low: 289.04,
                                                              volume: 1928383,
                                                              date: "2023-10-24T00:00:00+0000"),
                                                      EodItem(open: 242.3,
                                                              close: 438.49,
                                                              high: 895.94,
                                                              low: 647.59,
                                                              volume: 3848393,
                                                              date: "2023-10-23T00:00:00+0000"),
                                                      EodItem(open: 294.94,
                                                              close: 373.43,
                                                              high: 859.84,
                                                              low: 367.9,
                                                              volume: 4938394,
                                                              date: "2023-10-22T00:00:00+0000"),
                                                      EodItem(open: 100.0,
                                                              close: 200.0,
                                                              high: 300.0,
                                                              low: 99.0,
                                                              volume: 1928383,
                                                              date: "2023-10-21T00:00:00+0000")
                                            ]))
        return tickerDetails
    }()
    
    class TickerDetailsUseCaseMock: TickerDetailsUseCase {
        var executeCallCount: Int = 0

        typealias ExecuteBlock = (
            (Result<TickerDetailsData, Error>) -> Void
        ) -> Void

        lazy var _execute: ExecuteBlock = { _ in
            XCTFail("not implemented")
        }
        func execute(symbol: String, completion: @escaping (Result<TickerDetailsData, Error>) -> Void) -> Cancellable? {
            executeCallCount += 1
            _execute(completion)
            return nil
        }
    }
    
    func test_whenGetTickerDetailsUseCaseRetrievesEmptyData_thenViewModelIsEmpty() {
        // given
        let tickerDetailsUseCaseMock = TickerDetailsUseCaseMock()
        let ticker = Ticker(name: "", symbol: "", stock: nil)
        
        tickerDetailsUseCaseMock._execute = { completion in
            completion(.success(TickerDetailsData(tickerDetail: TickerDetail(name: "",
                                                                             symbol: "",
                                                                             eodItem: []))))
        }
        let viewModel = DefaultTickerDetailsViewModel(ticker: TickersListItemViewModel(ticker: ticker),
                                                      tickerDetailUseCase: tickerDetailsUseCaseMock,
                                                      mainQueue: DispatchQueueTypeMock())

        // when
        viewModel.didGetTickerDetail()
        
        // then
        XCTAssertTrue(viewModel.itemDetail.value.isEmpty)
        XCTAssertEqual(tickerDetailsUseCaseMock.executeCallCount, 1)
        addTeardownBlock { [weak viewModel] in XCTAssertNil(viewModel) }
    }
    
    func test_whenGetTickerDetailUseCaseRetrievesTickerDetails_thenViewModelContainsTickerDetail() {
        // given
        let tickerDetailsUseCaseMock = TickerDetailsUseCaseMock()
        let ticker = Ticker(name: "Microsoft Corporation", symbol: "MSFT", stock: Stock(name: "NASDAQ Stock Exchange", acronym: "NASDAQ", country: "USA"))
        
        tickerDetailsUseCaseMock._execute = { [self] completion in
            completion(.success(self.tickerDetails))
        }
        
        let viewModel = DefaultTickerDetailsViewModel(ticker: TickersListItemViewModel(ticker: ticker),
                                                      tickerDetailUseCase: tickerDetailsUseCaseMock,
                                                      mainQueue: DispatchQueueTypeMock())
      
        // when
        viewModel.didGetTickerDetail()
        
        // then
        let expectedItems = tickerDetails.tickerDetail.eodItem.map { TickerDetailsItemViewModel(eod: $0) }
        XCTAssertEqual(viewModel.itemDetail.value, expectedItems)
        XCTAssertEqual(tickerDetailsUseCaseMock.executeCallCount, 1)
        addTeardownBlock { [weak viewModel] in XCTAssertNil(viewModel) }
    }

    func test_whenSearchMoviesUseCaseReturnsError_thenViewModelContainsError() {
        // given
        let tickerDetailsUseCaseMock = TickerDetailsUseCaseMock()
        let ticker = TickersListItemViewModel(
            ticker: Ticker(
                name: "Microsoft Corporation",
                symbol: "MSFT",
                stock: Stock(
                    name: "NASDAQ Stock Exchange",
                    acronym: "NASDAQ",
                    country: "USA")))
        
        tickerDetailsUseCaseMock._execute = { completion in
            completion(.failure(TickerDetailsUseCaseError.someError))
        }
        
        let viewModel = DefaultTickerDetailsViewModel(
            ticker: ticker,
            tickerDetailUseCase: tickerDetailsUseCaseMock
        )

        // when
        viewModel.didGetTickerDetail()

        // then
        XCTAssertNotNil(viewModel.error)
        XCTAssertTrue(viewModel.itemDetail.value.isEmpty)
        XCTAssertEqual(tickerDetailsUseCaseMock.executeCallCount, 1)
        addTeardownBlock { [weak viewModel] in XCTAssertNil(viewModel) }
    }
}

extension DefaultTickerDetailsViewModel {
    static func make(
        tickerDetailsUseCase: TickerDetailsUseCase
    ) -> DefaultTickerDetailsViewModel {
        DefaultTickerDetailsViewModel(
            ticker: TickersListItemViewModel(
                ticker: Ticker(
                    name: "Microsoft Corporation",
                    symbol: "MSFT",
                    stock: Stock(
                        name: "NASDAQ Stock Exchange",
                        acronym: "NASDAQ",
                        country: "USA"))),
            tickerDetailUseCase: tickerDetailsUseCase)
    }
}
