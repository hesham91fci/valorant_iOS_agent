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
        mainRepo.getAgents().sink { (error) in
            switch error {
            case .failure(let appError):
                print("\(appError)")
            default:
                print("finished")
            }
        } receiveValue: { [weak self] (agents) in
            self?.agents = agents
        }.store(in: &subscriptions)

    }
}
