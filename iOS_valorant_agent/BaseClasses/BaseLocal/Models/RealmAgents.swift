//
//  RealmAgents.swift
//  iOS_valorant_agent
//
//  Created by Yahia Ewida on 2/3/21.
//

import Foundation
import RealmSwift

// MARK: - Datum
class RealmAgentData: Object {
    @objc dynamic var uuid: String = ""
    @objc dynamic var displayName: String = ""
    @objc dynamic var datumDescription: String = ""
    @objc dynamic var developerName: String = ""
    var characterTags: List<String> = List<String>()
    @objc dynamic var displayIcon: String = ""
    @objc dynamic var displayIconSmall: String = ""
    @objc dynamic var bustPortrait: String = ""
    @objc dynamic var fullPortrait: String = ""
    @objc dynamic var assetPath: String = ""
    @objc dynamic var isFullPortraitRightFacing: Bool = false
    @objc dynamic var isPlayableCharacter: Bool = false
    @objc dynamic var isAvailableForTest: Bool = false
    @objc dynamic var role: RealmRole? = RealmRole()
    var abilities: List<RealmAbility> = List()

    override init() { }
}

// MARK: - Ability
class RealmAbility: Object {
    @objc dynamic var slot: String = ""
    @objc dynamic var displayName: String = ""
    @objc dynamic var abilityDescription: String = ""
    @objc dynamic var displayIcon: String = ""

    override init() { }
}

// MARK: - Role
class RealmRole: Object {
    @objc dynamic var uuid: String = ""
    @objc dynamic var displayName: String = ""
    @objc dynamic var roleDescription: String = ""
    @objc dynamic var displayIcon: String = ""
    @objc dynamic var assetPath: String = ""

    override init () { }
}
