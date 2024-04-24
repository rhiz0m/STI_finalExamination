//
//  CreateProgramView.swift
//  sti_exam
//
//  Created by Andreas Antonsson on 2024-03-14.
//

import SwiftUI

struct CreateProgramView: View {
    
    @ObservedObject var authViewAdapter: AuthDatabaseViewAdapter
    @StateObject private var exerciseViewAdapter = ExerciseViewAdapter()
    @State var usersExercise: UsersExcercise?
    @State var usersTrainingRecord: UsersTrainingRecord?
    @State var exerciseName = ""
    @State var date = ""
    @State var type = ""
    @State var muscleGroups = ""
    @State var weight = ""
    @State var reps = 0
    @State var sets = 0
    @State private var navigateToListView = false
    
    var body: some View {
        if let viewModel = exerciseViewAdapter.createProgramViewModel {
            content(viewModel: viewModel)
            
        } else {
            ProgressView()
                .onAppear(perform: {
                    exerciseViewAdapter.generateCreateProgramViewModel()
                })
        }
    }
        
        @ViewBuilder func content(viewModel: ViewModel) -> some View {
            VStack {
                ExerciseFormView(
                    db: authViewAdapter,
                    exerciseName: $exerciseName,
                    date: $date,
                    type: $type,
                    muscleGroups: $muscleGroups)
                
                TrainingRecordFormView(
                    db: authViewAdapter,
                    weight: $weight,
                    reps: $reps,
                    sets: $sets)
                
                HStack {
                    //                NavigationLink(
                    //                    destination: CreateExerciseView(authViewAdapter: authViewAdapter, exerciseViewAdapter: exerciseViewAdapter, exerciseName: exerciseName, date: date, type: type, muscleGroups: muscleGroups, weight: weight, reps: reps, sets: sets, selectedExercise: usersExercise),
                    //                    label: {
                    //                        PrimaryBtnStyle(title: "Add Exercise",
                    //                                        icon: "plus.circle.fill")
                    //                    }
                    //                )
                    
                    Button(viewModel.saveTitle, action: {
                        
                        viewModel.saveExercise { success in
                            if success {
                            } else {
                            }
                        }
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
                            authViewAdapter.addProgramToDb(userExercise: newExercise)
                            
                            navigateToListView = true
                        }
                        navigateToListView = true
                    })
                    .background(NavigationLink("", destination: HomeView(authViewAdapter: authViewAdapter), isActive: $navigateToListView))
                }
                .padding(.vertical, GridPoints.x1)
                .padding(.horizontal, GridPoints.x4)
                
            }
            .onAppear {
                exerciseViewAdapter.clearFeilds()
            }
        }

    
    struct ViewModel {
        let saveTitle: String
        let saveExercise: (@escaping (Bool) -> Void) -> Void
    }
}
struct CreateProgramView_Previews: PreviewProvider {
    static var previews: some View {
        CreateProgramView(authViewAdapter: AuthDatabaseViewAdapter())
    }
}
