//
//  UpdateProgramView.swift
//  sti_exam
//
//  Created by Andreas Antonsson on 2024-03-14.
//

import SwiftUI

struct UpdateProgramView: View {
    @ObservedObject var authDbViewAdapter: AuthDbViewAdapter
    @Environment(\.dismiss) private var dismiss
    var selectedExerciseID: UUID?
    
    var body: some View {
        
        VStack {
            
            Text("Update Exercises").font(.title).bold()
            
            ExerciseFormView(authDbViewAdapter: authDbViewAdapter,
                             exerciseName: $authDbViewAdapter.exerciseName,
                             date: $authDbViewAdapter.date,
                             type: $authDbViewAdapter.type,
                             muscleGroups: $authDbViewAdapter.muscleGroups)
            
            TrainingRecordFormView(authDbViewAdapter: authDbViewAdapter,
                                   weight: $authDbViewAdapter.weight,
                                   reps: $authDbViewAdapter.reps,
                                   sets: $authDbViewAdapter.sets
                              /*     usersTrainingRecord: authDbViewAdapter.usersTrainingRecord*/)
            
//            HStack {
//                Button("update") {
//                    print("Button Pressed!")
//                    
//                    print("Before Update - Exercise Name: \(authDbViewAdapter.exerciseName)")
//
//                    if let currentUserData = authDbViewAdapter.currentUserData,
//                       let selectedExerciseID = authDbViewAdapter.selectedExerciseID,
//                       let selectedExercise = currentUserData.usersExercises.first(where: { $0.id == selectedExerciseID }) {
//
//                        authDbViewAdapter.selectedExercise = selectedExercise
//
//                        if let selectedExercise = authDbViewAdapter.selectedExercise {
//                            print("Selected Exercise: \(selectedExercise)")
//                            
//                            authDbViewAdapter.updateProgram(usersExercise: [selectedExercise]) { error in
//                                if let error = error {
//                                    print("Update failed with error: \(error.localizedDescription)")
//                                } else {
//                                    print("Update successful!")
//                                    print("After Update - Exercise Name: \(authDbViewAdapter.exerciseName)")
//                                }
//                            }
//                        } else {
//                            print("Selected Exercise is nil!")
//                        }
//                    }
//                }
//                .padding(.vertical, GridPoints.x1)
//                .padding(.horizontal, GridPoints.x4)
//            }
            .onAppear {
                print("UpdateProgramView appeared")
                print("Selected Exercise ID: \(String(describing: authDbViewAdapter.selectedExerciseID))")
                
                if let currentUserData = authDbViewAdapter.currentUserData,
                   let selectedExerciseID = authDbViewAdapter.selectedExerciseID,
                   let selectedExercise = currentUserData.usersExercises.first(where: { $0.id == selectedExerciseID }) {
                    
                    authDbViewAdapter.selectedExercise = selectedExercise
                    
                    if let selectedExercise = authDbViewAdapter.selectedExercise {
                        print("Selected Exercise: \(selectedExercise)")
                        
                        authDbViewAdapter.exerciseName = selectedExercise.exerciseName
                        authDbViewAdapter.date = selectedExercise.date.formatted()
                        authDbViewAdapter.type = selectedExercise.type
                        authDbViewAdapter.muscleGroups = selectedExercise.muscleGroups.joined(separator: ", ")
                        
                        if let firstTrainingRecord = selectedExercise.usersTrainingRecords.first {
                            authDbViewAdapter.weight = firstTrainingRecord.weight
                            authDbViewAdapter.sets = firstTrainingRecord.sets
                            authDbViewAdapter.reps = firstTrainingRecord.reps
                        }
                    } else {
                        print("Selected Exercise is nil!")
                    }
                }
            }
        }
    }
}

//#Preview {
//    UpdateProgramView(authViewAdapter: AuthDatabaseViewAdapter(), 
//                      viewModel: ExerciseViewAdapter())
//}
