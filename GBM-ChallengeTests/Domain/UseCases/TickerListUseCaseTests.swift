//
//  TickerListUseCaseTests.swift
//  GBM-ChallengeTests
//
//  Created by Ana Victoria Frias on 23/10/23.
//

import XCTest
@testable import GBM_Challenge

final class TickerListUseCaseTests: XCTestCase {
    
    static let tickersList: [Ticker] = {
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
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
