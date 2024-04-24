//
//  ExerciseViewModel.swift
//  sti_exam
//
//  Created by Andreas Antonsson on 2024-04-23.
//

import Foundation

class ExerciseViewAdapter: ObservableObject {
    @Published var createProgramViewModel: CreateProgramView.ViewModel?
    @Published var selectedExerciseID: UUID?
    @Published var selectedExercise: UsersExcercise?
    @Published var usersExercises: [UsersExcercise] = []
    @Published var usersTrainingRecord: [UsersTrainingRecord] = []
    @Published var exerciseName = ""
    @Published var date = ""
    @Published var type = ""
    @Published var muscleGroups = ""
    @Published var weight = ""
    @Published var reps = 0
    @Published var sets = 0
    @Published var title = ""
    @Published var dateString: String = ""
    @Published var description = ""
    @Published var name = ""

    
    func generateCreateProgramViewModel() {
        let createProgramViewModel = CreateProgramView.ViewModel(
            saveTitle: LocalizedStrings.save,
            saveExercise: saveExercise
        )
        self.createProgramViewModel = createProgramViewModel
    }
    
    func saveExercise(completion: @escaping (Bool) -> Void) {
        
        if !exerciseName.isEmpty {
            
            let weightValue = Double(weight) ?? 0.0
            
            let usersTrainingRecord = UsersTrainingRecord(weight: weight, reps: reps, sets: sets, totalReps: reps * sets, totalWeight: reps * sets * Int(weightValue))
            
            let trainingRecordsId = usersTrainingRecord.id
            
            let newExercise = UsersExcercise(
                id: UUID(),
                category: "users_exercise",
                exerciseName: exerciseName,
                date: Date(),
                type: type,
                muscleGroups: [muscleGroups],
                trainingRecordIds: [trainingRecordsId],
                usersTrainingRecords: [usersTrainingRecord]
            )
            print("new exercise \(newExercise)")
            //authDatabaseViewAdapter.addProgramToDb(userExercise: newExercise)
            completion(true)
            
        } else {
            completion(false)
        }
    }
    
    func clearFeilds() {
        exerciseName = ""
        date = ""
        muscleGroups = ""
        weight = ""
        reps = 0
        sets = 0
        title = ""
        dateString = ""
        description = ""
        name = ""
        usersExercises = []
    }
    
}
