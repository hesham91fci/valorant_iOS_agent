//
//  AppCoordinator.swift
//  iOS_valorant_agent
//
//  Created by Hesham Ali on 2/10/21.
//

import Foundation
import SwiftUI
import Combine
class AppCoordinator: Coordinator, CoordinatorProtocol {
    let window: UIWindow
    var subscriptions: [AnyCancellable] = []
    init(window: UIWindow) {
        self.window = window
        super.init()
    }

    var navigationController: UINavigationController! {
        window.rootViewController as? UINavigationController
    }

    func start() {
        DispatchQueue.main.async { [weak self] in
            self?.showListScreen()
        }
    }

    func showListScreen() {
        let agentListViewModel = AgentListViewModel()
        agentListViewModel.didSelectAgentDetails.sink {[weak self] (agentUUID, backgroundColor) in
            self?.showAgentDetailsScreen(agentUUID: agentUUID, backgroundColor: backgroundColor)
        }.store(in: &subscriptions)

        // Use a UIHostingController as window root view controller
        let homeScreen = HomeScreenView(agentListViewModel: agentListViewModel).preferredColorScheme(.dark)
        let controller = UIHostingController(rootView: homeScreen)
        let nav = UINavigationController(rootViewController: controller)
        window.rootViewController = nav
    }

    func showAgentDetailsScreen(agentUUID: String, backgroundColor: Color) {
        let agentDetailsView = AgentDetailsView(agentUUID: agentUUID, backgroundColor: backgroundColor)
        let controller = UIHostingController(rootView: agentDetailsView)
        navigationController.pushViewController(controller, animated: true)
    }
}
