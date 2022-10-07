//
//  WorkoutModel.swift
//  FitnessLife
//
//  Created by Sergio on 7.10.22.
//

import Foundation
import RealmSwift

class WorkoutModel: Object {
    @Persisted var workoutDate: Date
    @Persisted var workoutName: String = "Unknow"
    @Persisted var workoutNumberOfDay: Int = 0
    @Persisted var workoutRepeat: Bool = true
    @Persisted var workoutSets: Int = 0
    @Persisted var workoutTimer: Int = 0
    @Persisted var workoutReps: Int = 0
    @Persisted var workoutImage: Data?
}
