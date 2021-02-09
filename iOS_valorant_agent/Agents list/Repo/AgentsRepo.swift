//
//  AgentsRepo.swift
//  iOS_valorant_agent
//
//  Created by Hesham Ali on 2/4/21.
//

import Foundation
import Combine
import Alamofire
class AgentsRepo: BaseRepo {
    func getAgents() -> AnyPublisher<Agents, AppError> {
        return networkHandler.performRequest(url: Constants.APIs.agents, method: .get, params: nil, encoding: URLEncoding.queryString, headers: nil)
    }

    func storeAgents(agents: [AgentsData]) {
        agents.forEach({
            var modifiableAgent = $0
            if let agent = getAgentByUUID(agentUUID: $0.uuid) {
                modifiableAgent.isFavorite = agent.isFavorite
            }
            localDataHandler.agents.insertOrUpdate(modifiableAgent.toRealmObject())
        })
    }

    func getAgentByUUID(agentUUID: String) -> AgentsData? {
        return localDataHandler.agents.getById(primaryKeyParamater: "uuid", value: agentUUID)?.toDtoObject()
    }

    func updateAgent(agent: AgentsData) {
        localDataHandler.agents.insertOrUpdate(agent.toRealmObject())
    }

    func getLocalAgents() -> PassthroughSubject<[RealmAgentData], Never> {
        localDataHandler.agents.resultSubject
    }
}
