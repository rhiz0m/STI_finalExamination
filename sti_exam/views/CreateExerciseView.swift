//
//  CreateExerciseView.swift
//  sti_exam
//
//  Created by Andreas Antonsson on 2024-03-14.
//

import SwiftUI

struct CreateExerciseView: View {
    @ObservedObject var authViewAdapter: AuthViewAdapter
    @State private var navigateToListView = false
    
    @State var exerciseName = ""
    @State var date = ""
    @State var type = ""
    @State var muscleGroups = ""
    @State var weight = ""
    @State var reps = 0
    @State var sets = 0
    
    @State var selectedExercise: UsersExcercise?
    
    
    var body: some View {
        VStack {
            ExerciseFormView(db: authViewAdapter, exerciseName: $exerciseName, date: $date, type: $type, muscleGroups: $muscleGroups)
            
            TrainingRecordFormView(db: authViewAdapter, weight: $weight, reps: $reps, sets: $sets)
            
            HStack {
                Button("Save", action: {
                    navigateToListView = true
                    
                    let weightValue = Double(weight) ?? 0.0
                    
                    if !exerciseName.isEmpty {
                        let newTrainingRecord = UsersTrainingRecord(
                            weight: weight,
                            reps: reps,
                            sets: sets,
                            totalReps: reps * sets,
                            totalWeight: reps * sets * Int(weightValue))
                        
                        let exerciseId = selectedExercise?.id ?? UUID()
                        
                        let newExercise = UsersExcercise(
                            id: UUID(),
                            category: "users_programs",
                            exerciseName: exerciseName,
                            date: Date(),
                            type: type,
                            muscleGroups: [muscleGroups],
                            trainingRecordIds: [exerciseId],
                            usersTrainingRecords: [newTrainingRecord])
                        
                        authViewAdapter.addProgramToDb(userExercise: newExercise)
                        
                      
                    }
                }).background(NavigationLink("", destination: HomeView(authViewAdapter: authViewAdapter), isActive: $navigateToListView))
                
                Button("Cancel", action: {
                    navigateToListView = true
                }).background(NavigationLink("", destination: HomeView(authViewAdapter: authViewAdapter), isActive: $navigateToListView))
            }
            .padding(.vertical, GridPoints.x1)
            .padding(.horizontal, GridPoints.x4)
            
        }
        .navigationTitle(authViewAdapter.name)
    }
}

struct CreateExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        let db = AuthViewAdapter()
        let selectedExercise = Binding<UsersExcercise?>(
            get: { nil },
            set: { _ in }
        )
        
        return CreateExerciseView(
            authViewAdapter: db,
            exerciseName: "Squats",
            date: "2023",
            type: "strength",
            muscleGroups: "Legs",
            weight: "100",
            reps: 10,
            sets: 3
        )
    }
}
