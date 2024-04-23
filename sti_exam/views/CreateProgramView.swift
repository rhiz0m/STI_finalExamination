//
//  CreateProgramView.swift
//  sti_exam
//
//  Created by Andreas Antonsson on 2024-03-14.
//

import SwiftUI

import SwiftUI

struct CreateProgramView: View {
    
    @ObservedObject var authViewAdapter: AuthViewAdapter
    
    @Environment(\.dismiss) private var dismiss
    
    @State var exerciseName = ""
    @State var date = ""
    @State var type = ""
    @State var muscleGroups = ""
    
    @State var weight = ""
    @State var reps = 0
    @State var sets = 0
    
    @State var selectedProgram: UsersExcercise?
    @State var selectedExercise: UsersTrainingRecord?
    
    var body: some View {
        
        
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
                NavigationLink(
                    destination: CreateExerciseView(authViewAdapter: authViewAdapter, exerciseName: exerciseName, date: date, type: type, muscleGroups: muscleGroups, weight: weight, reps: reps, sets: sets, selectedExercise: selectedProgram),
                    label: {
                        PrimaryBtnStyle(title: "Add Exercise",
                                       icon: "plus.circle.fill")
                    }
                )
                
                Button("save", action: {
                    
                    if !exerciseName.isEmpty {
                        
                        let weightValue = Double(weight) ?? 0.0
                        
                        let usersTrainingRecord = UsersTrainingRecord(weight: weight, reps: reps, sets: sets, totalReps: reps * sets, totalWeight: reps * sets * Int(weightValue))
                        
                        let trainingRecordsId = selectedExercise?.id ?? UUID()
                        
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
                        
                        dismiss()
                    }
                })
            }
            .padding(.vertical, GridPoints.x1)
            .padding(.horizontal, GridPoints.x4)
            
        }.onAppear { authViewAdapter.clearFeilds() }
    }
}
struct CreateProgramView_Previews: PreviewProvider {
    static var previews: some View {
        CreateProgramView(authViewAdapter: AuthViewAdapter())
    }
}
