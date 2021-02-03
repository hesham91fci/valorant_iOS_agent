//
//  RealmExtensions.swift
//  iOS_valorant_agent
//
//  Created by Yahia Ewida on 2/3/21.
//

import Foundation

extension Array  where Element == RealmAbility {
    func toAbilityArray() -> [Ability] {
        var abilitiesArray = [Ability]()

        self.forEach { realmAbility in
            abilitiesArray.append(realmAbility.toAbilityObject)
        }
        return abilitiesArray
    }
}
