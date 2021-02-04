//
//  AgentListViewModel.swift
//  iOS_valorant_agent
//
//  Created by Hesham Ali on 2/2/21.
//

import Foundation
import Combine
class AgentListViewModel: BaseViewModel, ObservableObject {
    @Published var agents: Agents!
    func getAgents() {
        AgentsRepo().getAgents().sink {[weak self] (error) in
            self?.handleAppError(error: error)
        } receiveValue: { [weak self] (agents) in
            self?.agents = agents
        }.store(in: &subscriptions)

    }
}
