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

}

class LocalDataHandler: LocalDataHandlerProtocol {
    private var observationToken: NotificationToken?

    private let realm = LocalConfiguration.realm
    var test = Dao<Test>()
    var test2 =  Dao<Test2>()

    func writeToRealm<T: Object>(_ object: T) -> Bool {
        var result = false
        do {
            try realm.write {
                realm.add(object)
                result = true
            }
        } catch {
            result = false
        }
        return result
    }

    func getTestValues() -> PassthroughSubject<[Test], Never> {
         test.resultSubject
    }

    func getTest2Values() -> PassthroughSubject<[Test2], Never> {
         test2.resultSubject
    }

   deinit {
       observationToken?.invalidate()
   }
}

class Test: Object {
    @objc dynamic var value: String = ""
}

class Test2: Object {
    @objc dynamic var value: Int = 0
}
