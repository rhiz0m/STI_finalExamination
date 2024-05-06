//
//  CreateProgramView.swift
//  sti_exam
//
//  Created by Andreas Antonsson on 2024-03-14.
//

import SwiftUI

struct CreateProgramView: View {
    
    @EnvironmentObject var homeViewAdapter: HomeViewAdapter
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
        if let viewModel = homeViewAdapter.createProgramViewModel {
            content(viewModel: viewModel)
            
        } else {
            ProgressView()
                .onAppear(perform: {
                    homeViewAdapter.generateCreateProgramViewModel()
                })
        }
    }
    
    @ViewBuilder func content(viewModel: ViewModel) -> some View {
        VStack {
            ExerciseFormCell(
                viewModel: viewModel.exerciceFormCell,
                exerciseName: $exerciseName,
                date: $date,
                type: $type,
                muscleGroups: $muscleGroups)
            
            TrainingRecordFormCell(
                viewModel: viewModel.trainingRecordFormCell,
                weight: $weight,
                reps: $reps,
                sets: $sets)
            
            HStack {
                Button(viewModel.saveTitle, action: {
                    
                    if !exerciseName.isEmpty {
                        
                        let weightValue = Double(weight) ?? 0.0
                        
                        let usersTrainingRecord = UsersTrainingRecord(weight: weight, reps: reps, sets: sets, totalReps: reps * sets, totalWeight: reps * sets * Int(weightValue))
                        
                        let trainingRecordsId = usersTrainingRecord.id
                        
                        let newExercise = UsersExcercise(
                            id: UUID(),
                            category: viewModel.categoryTitle,
                            exerciseName: exerciseName,
                            date: Date(),
                            type: type,
                            muscleGroups: [muscleGroups],
                            trainingRecordIds: [trainingRecordsId],
                            usersTrainingRecords: [usersTrainingRecord]
                        )
//                        print("new exercise \(newExercise)")
                        homeViewAdapter.authDbViewAdapter.addProgramToDb(userExercise: newExercise)
           
                    }
                    navigateToListView = true
                })
            }
            .padding(.vertical, GridPoints.x1)
            .padding(.horizontal, GridPoints.x4)
            
        }
        .onAppear {
            homeViewAdapter.authDbViewAdapter.clearFeilds()
        }
    }
    
    
    struct ViewModel {
        let saveTitle: String
        let categoryTitle: String
        let exerciceFormCell: ExerciseFormCell.ViewModel
        let trainingRecordFormCell: TrainingRecordFormCell.ViewModel
        let saveExercise: (@escaping (Bool) -> Void) -> Void
    }
}
#Preview {
    CreateProgramView()
        .environmentObject(HomeViewAdapter(authDbViewAdapter: AuthDbViewAdapter()))
}

//                        homeViewAdapter.authDbViewAdapter.saveExercise { success in
//                            if success {
//                            } else {
//                            }
//                        }

//                NavigationLink(
//                    destination: CreateExerciseView(authViewAdapter: authViewAdapter, exerciseViewAdapter: exerciseViewAdapter, exerciseName: exerciseName, date: date, type: type, muscleGroups: muscleGroups, weight: weight, reps: reps, sets: sets, selectedExercise: usersExercise),
//                    label: {
//                        PrimaryBtnStyle(title: "Add Exercise",
//                                        icon: "plus.circle.fill")
//                    }
//                )


//                        homeViewAdapter.authDbViewAdapter.addProgramToDb(userExercise: newExercise)
