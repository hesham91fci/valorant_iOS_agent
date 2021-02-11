//
//  AgentListViewModel.swift
//  iOS_valorant_agent
//
//  Created by Hesham Ali on 2/2/21.
//

import Foundation
import Combine
import SwiftUI

class AgentListViewModel: BaseViewModel, ObservableObject {

    private var agents: Agents = Agents(status: 200, data: [AgentsData]())
    private var favoriteAgents: [AgentsData] = [AgentsData]()
    @Published var agentsToDisplay: [AgentsData] = []
    let didSelectAgentDetails = PassthroughSubject<(String, Color), Never>()
    private var agentIndex = 0
    private let agentsRepo = AgentsRepo()

    private func getAgents() {
        agentsRepo.getAgents().sink {[weak self] (error) in
            self?.handleAppError(error: error)
        } receiveValue: { [weak self] (agents) in
            guard let self = self else { return }
            self.agents = agents
            self.agents.data = agents.data.filter { value in !(value.bustPortrait ?? "").isEmpty }
            self.agentsToDisplay = self.agents.data
            self.agentsRepo.storeAgents(agents: self.agents.data)
        }.store(in: &subscriptions)
    }

    func navigateToAgentDetails(agentUUID: String, backgroundColor: Color) {
        didSelectAgentDetails.send((agentUUID, backgroundColor))
    }

    func getFavoriteAgents() {
        self.favoriteAgents = agentsRepo.getFavoriteAgents()
        self.agentsToDisplay = self.favoriteAgents
    }

    func getAgentsData(isFavorite: Bool) {

        if isFavorite {
            getFavoriteAgents()
            agentIndex = 0
        } else {
            getAgents()
            agentIndex = 0
        }
    }

    func getCurrentAgentIndex(agent viewAgentData: AgentsData) -> Int {
        for index in 0..<agents.data.count where agents.data[index].uuid == viewAgentData.uuid {
            agentIndex = index
        }
        return agentIndex
    }
}
