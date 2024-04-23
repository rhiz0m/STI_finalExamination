//
//  ExerciseViewModel.swift
//  sti_exam
//
//  Created by Andreas Antonsson on 2024-04-23.
//

import Foundation

class ExerciseViewAdapter: ObservableObject {
    @Published var selectedExerciseID: UUID?
    @Published var selectedExercise: UsersExcercise?
    @Published var exerciseName: String = ""
    @Published var date: String = ""
    @Published var type: String = ""
    @Published var muscleGroups: String = ""
    @Published var weight: String = ""
    @Published var reps: Int = 0
    @Published var sets: Int = 0
    @Published var exercises: [UsersExcercise] = []
    
}
