//
//  ExerciseFormView.swift
//  sti_exam
//
//  Created by Andreas Antonsson on 2024-04-23.
//

import SwiftUI

struct ExerciseFormView: View {
    
    @ObservedObject var db: AuthViewAdapter
    
    @Binding var exerciseName: String
    @Binding var date: String
    @Binding var type: String
    @Binding var muscleGroups: String
    
    var selectedProgram: UsersExcercise?
    
    var body: some View {
        
        TextField("Name", text: $exerciseName)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.vertical, GridPoints.x1)
            .padding(.horizontal, GridPoints.x4)
            .onAppear {
                print("ExerciseFormView - exerciseName: \(exerciseName)")
            }
        
        TextField("Type", text: $type)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.vertical, GridPoints.x1)
            .padding(.horizontal, GridPoints.x4)
        
        TextField("Muscle Groups: \(muscleGroups)",
                  text: $muscleGroups)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding(.vertical, GridPoints.x1)
        .padding(.horizontal, GridPoints.x4).onAppear {
        }
    }

}

struct ProgramFormView_Previews: PreviewProvider {
    static var previews: some View {
        let db = AuthViewAdapter()
        let selectedProgram = UsersExcercise(id: UUID(),
                                             exerciseName: "Test",
                                             date: Date(),
                                             type: "strength",
                                             trainingRecordIds: [],
                                             usersTrainingRecords: [])
        
        let date = Binding.constant("2023-11-02")
        
        return ExerciseFormView(db: db,
                                exerciseName: .constant("my exercise"),
                                date: date,
                                type: Binding.constant("strength"),
                                muscleGroups:
                                    Binding.constant("core,back,legs"),
                                selectedProgram: selectedProgram)
    }
}
