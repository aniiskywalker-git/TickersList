//
//  TickerDetailsUseCaseTests.swift
//  GBM-ChallengeTests
//
//  Created by Ana Victoria Frias on 25/10/23.
//

import XCTest
@testable import GBM_Challenge

final class TickerDetailsUseCaseTests: XCTestCase {
    
    static let tickerDetailData: TickerDetailsData = {
        let tickerDetailsData = TickerDetailsData(
            tickerDetail: TickerDetail(name: "Microsoft Corporation",
                                       symbol: "MSFT",
                                       eodItem: [
                                        EodItem(open: 230.0, 
                                                close: 123.4,
                                                high: 488.0,
                                                low: 293.93,
                                                volume: 2880393.0,
                                                date: "2023-10-25T00:00:00+0000"),
                                        EodItem(open: 293.45,
                                                close: 289.83,
                                                high: 848.93,
                                                low: 289.04,
                                                volume: 1928383.5,
                                                date: "2023-10-24T00:00:00+0000"),
                                        EodItem(open: 242.3,
                                                close: 438.49,
                                                high: 895.94,
                                                low: 647.59,
                                                volume: 3848393.49,
                                                date: "2023-10-23T00:00:00+0000"),
                                        EodItem(open: 294.94,
                                                close: 373.43,
                                                high: 859.84,
                                                low: 367.9,
                                                volume: 4938394.39,
                                                date: "2023-10-22T00:00:00+0000"),
                                        EodItem(open: 100.0,
                                                close: 200.0,
                                                high: 300.0,
                                                low: 99.0,
                                                volume: 1928383.45,
                                                date: "2023-10-21T00:00:00+0000")]))
        return tickerDetailData
    }()

    enum TickerDetailsRepositorySuccessError: Error {
        case failedFetching
    }
    
    class TickerDetailRepositoryMock: TickerDetailsRepository {
        
        var result: Result<TickerDetailsData, Error>
        var fetchCompletionCallsCount = 0
        
        init(result: Result<TickerDetailsData, Error>) {
            self.result = result
        }
        
        func fetchTickerDetail(symbol: String, completion: @escaping (Result<TickerDetailsData, Error>) -> Void) -> Cancellable? {
            completion(result)
            fetchCompletionCallsCount += 1
            return nil
        }
    }
        
    func testTickerDetailsUseCase_whenSuccessfullyFetchesTickerDetails() {
        // given
        var useCaseCompletionCallsCount = 0
        let tickerDetailsRepository = TickerDetailRepositoryMock(
            result: .success(TickerDetailsUseCaseTests.tickerDetailData)
        )
        
        let useCase = DefaultTickerDetailsUseCase(tickerDetailRepository: tickerDetailsRepository)
        // when
        _ = useCase.execute(symbol: "MSFT", completion: { _ in
            useCaseCompletionCallsCount += 1
        })
            
        // then
        XCTAssertEqual(useCaseCompletionCallsCount, 1)
        XCTAssertEqual(tickerDetailsRepository.fetchCompletionCallsCount, 1)
    }
    
    func testTickersUseCase_whenFailedFetchingTickers() {
        // given
        var useCaseCompletionCallsCountCount = 0
        
        let useCase = DefaultTickerDetailsUseCase(tickerDetailRepository: TickerDetailRepositoryMock(result: .failure(TickerDetailsRepositorySuccessError.failedFetching)))
            
        // when
        _ = useCase.execute(symbol: "", completion: { _ in
            useCaseCompletionCallsCountCount += 1
        })
            
        // then
        XCTAssertEqual(useCaseCompletionCallsCountCount, 1)
    }

}
