//
//  Agents.swift
//  iOS_valorant_agent
//
//  Created by Hesham Ali on 2/2/21.
//

import Foundation

// MARK: - Agents
struct Agents: Codable {
    let status: Int
    var data: [AgentsData]
}

// MARK: - Datum
struct AgentsData: Codable {
    let uuid, displayName, datumDescription, developerName: String
    let characterTags: [String]?
    let displayIcon, displayIconSmall: String
    let bustPortrait, fullPortrait: String?
    let assetPath: String
    let isFullPortraitRightFacing, isPlayableCharacter, isAvailableForTest: Bool
    let role: Role?
    let abilities: [Ability]
    var isFavorite: Bool = false

    enum CodingKeys: String, CodingKey {
        case uuid, displayName
        case datumDescription = "description"
        case developerName, characterTags, displayIcon, displayIconSmall, bustPortrait, fullPortrait, assetPath, isFullPortraitRightFacing, isPlayableCharacter, isAvailableForTest, role, abilities
    }
}

// MARK: - Ability
struct Ability: Codable {
    let slot: Slot
    let displayName, abilityDescription: String?
    let displayIcon: String?

    enum CodingKeys: String, CodingKey {
        case slot, displayName
        case abilityDescription = "description"
        case displayIcon
    }
}

enum Slot: String, Codable {
    case ability1 = "Ability1"
    case ability2 = "Ability2"
    case grenade = "Grenade"
    case passive = "Passive"
    case ultimate = "Ultimate"
}

// MARK: - Role
struct Role: Codable {
    var uuid: String
    var displayName: String
    var roleDescription: String
    var displayIcon: String
    var assetPath: String

    init() {
        self.init(uuid: "", displayName: "", roleDescription: "", displayIcon: "", assetPath: "")
    }

    init(uuid: String, displayName: String, roleDescription: String, displayIcon: String, assetPath: String) {
        self.uuid = uuid
        self.displayName = displayName
        self.roleDescription = roleDescription
        self.displayIcon = displayIcon
        self.assetPath = assetPath
    }

    enum CodingKeys: String, CodingKey {
        case uuid, displayName
        case roleDescription = "description"
        case displayIcon, assetPath
    }
}
