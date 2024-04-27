////
////  ExerciseViewModel.swift
////  sti_exam
////
////  Created by Andreas Antonsson on 2024-04-23.
////
//
import Foundation
//
class ExerciseViewAdapter: ObservableObject {
    @Published var createProgramViewModel: CreateProgramView.ViewModel?
    
    func generateCreateProgramViewModel() {
        let createProgramViewModel = CreateProgramView.ViewModel(
            saveTitle: LocalizedStrings.save
//            saveExercise: saveExercise
        )
        self.createProgramViewModel = createProgramViewModel
    }
}
