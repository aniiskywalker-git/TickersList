//
//  NetworkConfigurableMock.swift
//  GBM-ChallengeTests
//
//  Created by Ana Victoria Frias on 25/10/23.
//

import Foundation
@testable import GBM_Challenge

class NetworkConfigurableMock: NetworkConfigurable {
    var baseURL: URL = URL(string: "https://mock.test.com")!
    var headers: [String: String] = [:]
    var queryParameters: [String: String] = [:]
}
