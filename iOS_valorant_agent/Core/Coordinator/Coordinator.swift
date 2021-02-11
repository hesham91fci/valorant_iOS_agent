//
//  Coordinator.swift
//  iOS_valorant_agent
//
//  Created by Hesham Ali on 2/10/21.
//

import Foundation
protocol CoordinatorProtocol {
    var child: CoordinatorProtocol? { get }
    func start()
}

class Coordinator {
    var child: CoordinatorProtocol?
}
