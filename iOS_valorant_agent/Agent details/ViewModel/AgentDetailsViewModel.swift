//
//  AgentDetailsViewModel.swift
//  iOS_valorant_agent
//
//  Created by Hesham Ali on 2/10/21.
//

import Foundation
import Combine
class AgentDetailsViewModel: ObservableObject {
    private let agentUUID: String!
    private let agentsRepo = AgentsRepo()
    @Published private(set) var agent: AgentsData?
    let agentErrorSubject: PassthroughSubject<String, Never> = PassthroughSubject()

    init(agentUUID: String) {
        self.agentUUID = agentUUID
    }

    func getAgentById() {
        guard let agent = agentsRepo.getAgentByUUID(agentUUID: agentUUID) else {
            agentErrorSubject.send("AgentUUID not found")
            return
        }
        self.agent = agent
    }

    func toggleFavoriteAgent() {
        agent?.isFavorite = !(agent?.isFavorite ?? true)
        guard let agent = agent else {
            agentErrorSubject.send("AgentUUID not found")
            return
        }

        agentsRepo.updateAgent(agent: agent)
    }

}
