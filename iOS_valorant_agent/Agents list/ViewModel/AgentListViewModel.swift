//
//  AgentListViewModel.swift
//  iOS_valorant_agent
//
//  Created by Hesham Ali on 2/2/21.
//

import Foundation
import Combine
class AgentListViewModel: BaseViewModel, ObservableObject {
    @Published private(set) var agents: Agents!
    @Published private(set) var agent: AgentsData?
    let agentErrorSubject: PassthroughSubject<String, Never> = PassthroughSubject()
    private let agentsRepo: AgentsRepo = AgentsRepo()
    func getAgents() {
        agentsRepo.getAgents().sink {[weak self] (error) in
            self?.handleAppError(error: error)
        } receiveValue: { [weak self] (agents) in
            self?.agents = agents
            self?.agentsRepo.storeAgents(agents: self?.agents.data ?? [])
        }.store(in: &subscriptions)

    }

    func getAgentById(agentUUID: String) {
        guard let agent = agentsRepo.getAgentByUUID(agentUUID: agentUUID) else {
            agentErrorSubject.send("AgentUUID not found")
            return
        }
        self.agent = agent
    }
}
