//
//  UpdateProgramView.swift
//  sti_exam
//
//  Created by Andreas Antonsson on 2024-03-14.
//

import SwiftUI

struct UpdateProgramView: View {
    @ObservedObject var authViewAdapter: AuthViewAdapter
    @ObservedObject var viewModel: ExerciseViewAdapter
    @Environment(\.dismiss) private var dismiss
    var selectedExerciseID: UUID?
    
    var body: some View {
        
        
        VStack {
            
            Text("Update Exercises").font(.title).bold()
            
            ExerciseFormView(db: authViewAdapter,
                             exerciseName: $viewModel.exerciseName,
                             date: $viewModel.date,
                             type: $viewModel.type,
                             muscleGroups: $viewModel.muscleGroups)
            TrainingRecordFormView(db: authViewAdapter,
                                   weight: $viewModel.weight,
                                   reps: $viewModel.reps,
                                   sets: $viewModel.sets)
            
            HStack {
                Button("update") {
                    print("Button Pressed!")
                    
                    print("Before Update - Exercise Name: \(viewModel.exerciseName)")

                    if let currentUserData = authViewAdapter.currentUserData,
                       let selectedExerciseID = viewModel.selectedExerciseID,
                       let selectedExercise = currentUserData.usersExercises.first(where: { $0.id == selectedExerciseID }) {

                        viewModel.selectedExercise = selectedExercise

                        if let selectedExercise = viewModel.selectedExercise {
                            print("Selected Exercise: \(selectedExercise)")
                            
                            authViewAdapter.updateProgram(usersExercise: [selectedExercise]) { error in
                                if let error = error {
                                    print("Update failed with error: \(error.localizedDescription)")
                                } else {
                                    print("Update successful!")
                                    
                                    // After the update
                                    print("After Update - Exercise Name: \(viewModel.exerciseName)")
                                }
                            }
                        } else {
                            print("Selected Exercise is nil!")
                        }
                    }
                }
                .padding(.vertical, GridPoints.x1)
                .padding(.horizontal, GridPoints.x4)
            }
            .onAppear {
                print("UpdateProgramView appeared")
                print("Selected Exercise ID: \(String(describing: viewModel.selectedExerciseID))")
                
                if let currentUserData = authViewAdapter.currentUserData,
                   let selectedExerciseID = viewModel.selectedExerciseID,
                   let selectedExercise = currentUserData.usersExercises.first(where: { $0.id == selectedExerciseID }) {
                    
                    viewModel.selectedExercise = selectedExercise
                    
                    if let selectedExercise = viewModel.selectedExercise {
                        print("Selected Exercise: \(selectedExercise)")
                        
                        viewModel.exerciseName = selectedExercise.exerciseName
                        viewModel.date = selectedExercise.date.formatted()
                        viewModel.type = selectedExercise.type
                        viewModel.muscleGroups = selectedExercise.muscleGroups.joined(separator: ", ")
                        
                        if let firstTrainingRecord = selectedExercise.usersTrainingRecords.first {
                            viewModel.weight = firstTrainingRecord.weight
                            viewModel.sets = firstTrainingRecord.sets
                            viewModel.reps = firstTrainingRecord.reps
                        }
                    } else {
                        print("Selected Exercise is nil!")
                    }
                }
            }
        }
    }
}

#Preview {
    UpdateProgramView(authViewAdapter: AuthViewAdapter(), viewModel: ExerciseViewAdapter())
}
