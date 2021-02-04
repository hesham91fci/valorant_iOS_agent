//
//  BaseProtocols.swift
//  iOS_valorant_agent
//
//  Created by Yahia Ewida on 2/4/21.
//

import Foundation
import RealmSwift

protocol RealmMapper {
   associatedtype RealmObject: Object

   func toRealmObject() -> RealmObject
}

protocol DtoObjectMapper {
  associatedtype DtoObject: Codable

  func toDtoObject() -> DtoObject
}
