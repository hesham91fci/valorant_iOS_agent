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
        let localAgents = localDataHandler.agents.getAll()
        if localDataHandler.agents.getAll().isEmpty {
            return networkHandler.performRequest(url: Constants.APIs.agents, method: .get, params: nil, encoding: URLEncoding.queryString, headers: nil)
        } else {
            var agents: [AgentsData] = []
            for localAgent in localAgents {
                agents.append(localAgent.toDtoObject())
            }
            return Just(Agents(status: 200, data: agents)).mapError({ (_) -> AppError in
                return AppError(message: "Unknown Error", errorCode: nil)
            }).eraseToAnyPublisher()
        }

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

    func syncAgents() {
        getLocalAgents().send(localDataHandler.agents.getAll())
    }
}
