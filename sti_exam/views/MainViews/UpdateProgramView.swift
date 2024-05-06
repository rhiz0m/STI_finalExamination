//
//  UpdateProgramView.swift
//  sti_exam
//
//  Created by Andreas Antonsson on 2024-03-14.
//

import SwiftUI

struct UpdateProgramView: View {
    @EnvironmentObject var homeViewAdapter: HomeViewAdapter
    @Environment(\.dismiss) private var dismiss
    @State private var exerciseName: String = ""
    @State private var date: String = ""
    @State private var type: String = ""
    @State private var weight: String = ""
    @State private var reps: Int = 0
    @State private var sets: Int = 0
    @State private var muscleGroups: String = ""
    var selectedExerciseID: UUID?
    
    var body: some View {
        
        if let viewModel = homeViewAdapter.updateProgramViewModel {
            content(viewModel: viewModel)
        } else {
            ProgressView()
                .onAppear(perform: {
                    homeViewAdapter.generateUpdateProgramViewModel()
                })
        }
    }
        
        @ViewBuilder func content(viewModel: ViewModel) -> some View {
            VStack {
                Text(viewModel.updateExercisesTitle)
                    .font(.title)
                    .bold()
                
                ExerciseFormCell(viewModel: viewModel.exerciceFormCell,
                                 exerciseName: $exerciseName,
                                 date: $date,
                                 type: $type,
                                 muscleGroups: $muscleGroups)
                
                TrainingRecordFormCell(viewModel: viewModel.trainingRecordFormCell,
                                       weight: $weight,
                                       reps: $reps,
                                       sets: $sets)
                                       /*     usersTrainingRecord: authDbViewAdapter.usersTrainingRecord*/
                
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
                    print("Selected Exercise ID: \(String(describing: homeViewAdapter.authDbViewAdapter.selectedExerciseID))")
                    
                    if let currentUserData = homeViewAdapter.authDbViewAdapter.currentUserData,
                       let selectedExerciseID = homeViewAdapter.authDbViewAdapter.selectedExerciseID,
                       let selectedExercise = currentUserData.usersExercises.first(where: { $0.id == selectedExerciseID }) {
                        
                        homeViewAdapter.authDbViewAdapter.selectedExercise = selectedExercise
                        
                        if let selectedExercise = homeViewAdapter.authDbViewAdapter.selectedExercise {
                            print("Selected Exercise: \(selectedExercise)")
                            
                            homeViewAdapter.authDbViewAdapter.exerciseName = selectedExercise.exerciseName
                            homeViewAdapter.authDbViewAdapter.date = selectedExercise.date.formatted()
                            homeViewAdapter.authDbViewAdapter.type = selectedExercise.type
                            homeViewAdapter.authDbViewAdapter.muscleGroups = selectedExercise.muscleGroups.joined(separator: ", ")
                            
                            if let firstTrainingRecord = selectedExercise.usersTrainingRecords.first {
                                homeViewAdapter.authDbViewAdapter.weight = firstTrainingRecord.weight
                                homeViewAdapter.authDbViewAdapter.sets = firstTrainingRecord.sets
                                homeViewAdapter.authDbViewAdapter.reps = firstTrainingRecord.reps
                            }
                        } else {
                            print("Selected Exercise is nil!")
                        }
                    }
                }
            }
        }
    struct ViewModel {
        let updateExercisesTitle: String
        let exerciceFormCell: ExerciseFormCell.ViewModel
        let trainingRecordFormCell: TrainingRecordFormCell.ViewModel
    }
}
