//
//  MainRepo.swift
//  iOS_valorant_agent
//
//  Created by Hesham Ali on 2/4/21.
//

import Foundation
import Combine
class MainRepo {
    let agentsRepo: AgentsRepo = AgentsRepo()
    func getAgents() -> AnyPublisher<Agents, AppError> {
        return agentsRepo.getAgents()
    }
}
