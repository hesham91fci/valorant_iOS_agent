//
//  LocalConfiguration.swift
//  iOS_valorant_agent
//
//  Created by Yahia Ewida on 2/3/21.
//

import Foundation
import RealmSwift

class LocalConfiguration {
    static var realm: Realm {
       do {
           let realm = try Realm()
           return realm

       } catch {
           print("Error in getting Realm object")
       }
        return self.realm
   }
}
