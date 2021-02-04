//
//  AgentListViewModel.swift
//  iOS_valorant_agent
//
//  Created by Hesham Ali on 2/2/21.
//

import Foundation
import Alamofire
import Combine
class AgentListViewModel: BaseViewModel<Agents, EmptyError>, ObservableObject {
    func getAgents() {
        super.performRequest(url: Constants.APIs.agents, method: .get, params: nil, encoding: URLEncoding.queryString, headers: nil)
    }
}
