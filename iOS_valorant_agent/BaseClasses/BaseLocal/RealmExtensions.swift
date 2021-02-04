//
//  RealmExtensions.swift
//  iOS_valorant_agent
//
//  Created by Yahia Ewida on 2/3/21.
//

import Foundation
import RealmSwift

// swiftlint:disable force_cast

// MARK: - Collections Extensions

extension List where Element: Object {
    var toArray: [Element] {
        var array = [Element]()
        self.forEach { element in
            array.append(element)
        }
        return array
    }
}

extension Array where Element: RealmCollectionValue {
    var toRealmList: List<Element> {
        let list = List<Element>()
        self.forEach { element in
            list.append(element)
        }
        return list
    }
}

extension Array where Element: RealmMapper {
    func toRealmArray<T: Object>() -> [T] {
        var realmArray: [T] = [T]()

        self.forEach { realmElement in
            realmArray.append(realmElement.toRealmObject() as! T) // return type of the funcon must be same as passed type
        }
        return realmArray
    }
}

extension Array  where Element: DtoObjectMapper {
    func toDtoArray<T: Codable>() -> [T] {
        var realmArray: [T] = [T]()

        self.forEach { realmElement in
            realmArray.append(realmElement.toDtoObject() as! T) // return type of the funcon must be same as passed type
        }
        return realmArray
    }
}

// MARK: - Dto to Realm Mapping Extensions

extension AgentsData: RealmMapper {
    func toRealmObject() -> RealmAgentData {
        let realmAgent = RealmAgentData()
        realmAgent.uuid = uuid
        realmAgent.displayName = displayName
        realmAgent.datumDescription = datumDescription
        realmAgent.developerName = developerName
        realmAgent.characterTags =  characterTags?.toRealmList ?? List<String>()
        realmAgent.displayIcon = displayIcon
        realmAgent.displayIconSmall = displayIconSmall
        realmAgent.bustPortrait = bustPortrait ?? ""
        realmAgent.fullPortrait = fullPortrait ?? ""
        realmAgent.assetPath = assetPath
        realmAgent.isFullPortraitRightFacing = isFullPortraitRightFacing
        realmAgent.isPlayableCharacter = isPlayableCharacter
        realmAgent.isAvailableForTest = isAvailableForTest
        realmAgent.role = role?.toRealmObject()
        realmAgent.abilities = (abilities.toRealmArray()).toRealmList
        return realmAgent
    }
}

extension Ability: RealmMapper {
    func toRealmObject() -> RealmAbility {
        let realmAbility = RealmAbility()
        realmAbility.slot = slot.rawValue
        realmAbility.displayName = displayName ?? ""
        realmAbility.abilityDescription = abilityDescription ?? ""
        realmAbility.displayIcon = displayIcon ?? ""
        return realmAbility
    }
}

extension Role: RealmMapper {
    func toRealmObject() -> RealmRole {
        let realmRole = RealmRole()
        realmRole.uuid = uuid
        realmRole.displayName = displayName
        realmRole.roleDescription = roleDescription
        realmRole.displayIcon = displayIcon
        return realmRole
    }
}

// MARK: - Realm to DTO Mapping Extensions

extension RealmAgentData: DtoObjectMapper {
    func toDtoObject() -> AgentsData {
        AgentsData(
            uuid: uuid, displayName: displayName, datumDescription: datumDescription, developerName: developerName,
            characterTags: Array(characterTags), displayIcon: displayIcon, displayIconSmall: displayIconSmall, bustPortrait: bustPortrait,
            fullPortrait: fullPortrait, assetPath: assetPath, isFullPortraitRightFacing: isFullPortraitRightFacing,
            isPlayableCharacter: isPlayableCharacter, isAvailableForTest: isAvailableForTest, role: role?.toDtoObject() ?? Role(),
            abilities: Array(abilities).toDtoArray()
        )
    }
}

extension RealmAbility: DtoObjectMapper {
    func toDtoObject() -> Ability {
        Ability(slot: Slot(rawValue: slot) ?? Slot.ability1, displayName: displayName, abilityDescription: abilityDescription, displayIcon: displayIcon)
    }
}

extension RealmRole: DtoObjectMapper {
    func toDtoObject() -> Role {
        Role(uuid: uuid, displayName: displayName, roleDescription: roleDescription, displayIcon: displayIcon, assetPath: assetPath)
    }
}
