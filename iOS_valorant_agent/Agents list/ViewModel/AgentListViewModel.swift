//
//  AgentListViewModel.swift
//  iOS_valorant_agent
//
//  Created by Hesham Ali on 2/2/21.
//

import Foundation
import Combine
class AgentListViewModel: BaseViewModel, ObservableObject {
    @Published var agents: Agents = Agents(status: 200, data: [AgentsData]())
    private var agentsRepo = AgentsRepo()

    override init() {
        super.init()
        self.getAgents()
    }

    func getAgents() {
        agentsRepo.getAgents().sink { [weak self] (error) in
            self?.handleAppError(error: error)
        } receiveValue: { [weak self] (agents) in
            self?.agents = agents
            self?.agents.data = agents.data.filter { value in !(value.bustPortrait ?? "").isEmpty }.shuffled()
        }.store(in: &subscriptions)
    }
}
