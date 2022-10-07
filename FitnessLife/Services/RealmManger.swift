//
//  RealmManger.swift
//  FitnessLife
//
//  Created by Sergio on 7.10.22.
//

import Foundation
import RealmSwift

class RealmManager {

    static let shared = RealmManager()

    private init() {}

    let localRealm = try! Realm()

    func saveWorkoutModel(model: WorkoutModel) {
        try! localRealm.write {
            localRealm.add(model)
        }
    }

}
