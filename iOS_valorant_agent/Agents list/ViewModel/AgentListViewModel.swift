//
//  AgentListViewModel.swift
//  iOS_valorant_agent
//
//  Created by Hesham Ali on 2/2/21.
//

import Foundation
import Combine
class AgentListViewModel: BaseViewModel {

    @Published var agents: Agents = Agents(status: 200, data: [AgentsData]())
    @Published private(set) var favoriteAgents: [AgentsData] = [AgentsData]()
    private var agentIndex = 0
    private let agentsRepo = AgentsRepo()

    func getAgents() {
        agentsRepo.getAgents().sink {[weak self] (error) in
            self?.handleAppError(error: error)
        } receiveValue: { [weak self] (agents) in
            guard let self = self else { return }
            self.agents = agents
            self.agents.data = agents.data.filter { value in !(value.bustPortrait ?? "").isEmpty }
            self.agentsRepo.storeAgents(agents: self.agents.data)
        }.store(in: &subscriptions)
    }

    func getFavoriteAgents() {
        self.favoriteAgents = agentsRepo.getFavoriteAgents()
    }

    func getAgentsData(isFavorite: Bool) {

        if isFavorite {
            if agents.data.count == 0 {
                getFavoriteAgents()
                agentIndex = 0
            }
        } else {
            if favoriteAgents.count == 0 {
                getAgents()
                agentIndex = 0
            }
        }
    }

    func getCurrentAgentIndex(agent viewAgentData: AgentsData) -> Int {
        for index in 0..<agents.data.count where agents.data[index].uuid == viewAgentData.uuid {
            agentIndex = index
        }
        return agentIndex
    }
}
