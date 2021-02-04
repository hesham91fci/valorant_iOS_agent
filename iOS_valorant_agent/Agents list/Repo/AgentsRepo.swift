//
//  AgentsRepo.swift
//  iOS_valorant_agent
//
//  Created by Hesham Ali on 2/4/21.
//

import Foundation
import Combine
import Alamofire
class AgentsRepo {
    func getAgents() -> AnyPublisher<Agents, AppError> {
        return NetworkHandler().performRequest(url: Constants.APIs.agents, method: .get, params: nil, encoding: URLEncoding.queryString, headers: nil)
    }
}
