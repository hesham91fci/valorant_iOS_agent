//
//  AgentDetailsViewModel.swift
//  iOS_valorant_agent
//
//  Created by Hesham Ali on 2/10/21.
//

import Foundation
import Combine
class AgentDetailsViewModel: BaseViewModel, ObservableObject {
    private let agentUUID: String!
    private let agentsRepo = AgentsRepo()
    @Published private(set) var agent: AgentsData?

    init(agentUUID: String) {
        self.agentUUID = agentUUID
    }

    func getAgentById() {
        guard let agent = agentsRepo.getAgentByUUID(agentUUID: agentUUID) else {
            handleAppError(error: AppError(message: "AgentUUID not found", errorCode: -2))
            return
        }
        self.agent = agent
    }

    func toggleFavoriteAgent() {
        agent!.isFavorite = !(agent!.isFavorite)
        guard let agent = agent else {
            handleAppError(error: AppError(message: "AgentUUID not found", errorCode: -2))
            return
        }

        agentsRepo.updateAgent(agent: agent)
    }

}
