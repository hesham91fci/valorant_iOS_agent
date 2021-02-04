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

    func write(_ object: T) -> Bool {
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

    deinit {
        observationToken?.invalidate()
    }
}
