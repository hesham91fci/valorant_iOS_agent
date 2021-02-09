//
//  LocalDataHandler.swift
//  iOS_valorant_agent
//
//  Created by Yahia Ewida on 2/3/21.
//

import Foundation
import RealmSwift
import Combine

protocol LocalDataHandlerProtocol {
     var agents: Dao<RealmAgentData> {get}
}

class LocalDataHandler: LocalDataHandlerProtocol {
    private let realm = LocalConfiguration.realm
    var agents = Dao<RealmAgentData>()
}
