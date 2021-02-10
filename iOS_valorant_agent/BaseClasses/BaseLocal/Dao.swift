//
//  Dao.swift
//  iOS_valorant_agent
//
//  Created by Yahia Ewida on 2/3/21.
//

import Foundation
import RealmSwift
import Combine

class Dao<T: Object> {
    private var observationToken: NotificationToken?
    private(set) var resultSubject = PassthroughSubject<[T], Never>()

    let realm = LocalConfiguration.realm

    init() {
        getData()
    }
     private func getData() {
        let data = realm.objects(T.self)
        observationToken = data.observe { [weak self] _ in
            self?.resultSubject.send(Array(data))
        }
    }

    @discardableResult
    func insertOrUpdate(_ object: T) -> Bool {
        var result = false
        do {
            try realm.write {
                realm.add(object, update: .modified)
                result = true
            }
        } catch {
            result = false
        }
        return result
    }

    func getAll() -> [T] {
        return Array(realm.objects(T.self))
    }

    func getById(primaryKeyParamater: String, value: Any) -> T? {
        return realm.objects(T.self).filter("\(primaryKeyParamater) = %@", value).first
    }

    func delete(primaryKeyParamater: String, value: Any) -> Bool {
        let realmObject = realm.objects(T.self).filter("\(primaryKeyParamater) = %@", value).first
        var result = false
        if let realmObject = realmObject {
            do {
                try realm.write {
                    realm.delete(realmObject)
                    result = true
                }
            } catch {
                result = false
            }
        }
        return result
    }

    deinit {
        observationToken?.invalidate()
    }
}
