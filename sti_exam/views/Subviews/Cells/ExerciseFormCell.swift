//
//  ExerciseFormView.swift
//  sti_exam
//
//  Created by Andreas Antonsson on 2024-04-23.
//

import SwiftUI

struct ExerciseFormCell: View {
    let viewModel: ViewModel
    
    @Binding var exerciseName: String
    @Binding var date: String
    @Binding var type: String
    @Binding var muscleGroups: String
    
    var selectedProgram: UsersExcercise?
    
    var body: some View {
        
        TextField(viewModel.name, text: $exerciseName)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.vertical, GridPoints.x1)
            .padding(.horizontal, GridPoints.x4)
            .onAppear {
                print("ExerciseFormView - exerciseName: \(exerciseName)")
            }
        
        TextField(viewModel.type, text: $type)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.vertical, GridPoints.x1)
            .padding(.horizontal, GridPoints.x4)
        
        TextField("\(viewModel.muscleGroups) \(muscleGroups)",
                  text: $muscleGroups)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding(.vertical, GridPoints.x1)
        .padding(.horizontal, GridPoints.x4).onAppear {
        }
    }
    struct ViewModel {
        let name: String
        let type: String
        let muscleGroups: String
    }
}

//struct ProgramFormView_Previews: PreviewProvider {
//    static var previews: some View {
//        let db = AuthDbViewAdapter()
//        let selectedProgram = UsersExcercise(id: UUID(),
//                                             exerciseName: "Test",
//                                             date: Date(),
//                                             type: "strength",
//                                             trainingRecordIds: [],
//                                             usersTrainingRecords: [])
//        
//        let date = Binding.constant("2023-11-02")
//        
//        return ExerciseFormView(authDbViewAdapter: db, viewModel: <#ExerciseFormView.ViewModel#>,
//                                exerciseName: .constant("my exercise"),
//                                date: date,
//                                type: Binding.constant("strength"),
//                                muscleGroups:
//                                    Binding.constant("core,back,legs"),
//                                selectedProgram: selectedProgram)
//    }
//}
