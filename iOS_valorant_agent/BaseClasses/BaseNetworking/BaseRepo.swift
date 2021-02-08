//
//  MainRepo.swift
//  iOS_valorant_agent
//
//  Created by Hesham Ali on 2/4/21.
//

import Foundation
import Combine
class BaseRepo {
    let networkHandler: NetworkHandler = NetworkHandler()
    let localDataHandler: LocalDataHandler = LocalDataHandler()
}
