////
////  ExerciseViewModel.swift
////  sti_exam
////
////  Created by Andreas Antonsson on 2024-04-23.
////
//
//import Foundation
//
//class ExerciseViewAdapter: ObservableObject {
//    @Published var createProgramViewModel: CreateProgramView.ViewModel?
//    
//    var authDbViewAdapter: AuthDbViewAdapter
//    
//    init(authDbViewAdapter: AuthDbViewAdapter) {
//        self.authDbViewAdapter = authDbViewAdapter
//    }
//    
//    func generateCreateProgramViewModel() {
//        let createProgramViewModel = CreateProgramView.ViewModel(
//            saveTitle: LocalizedStrings.save,
//            saveExercise: { [weak self] completion in
//                guard let self = self else { return }
//                self.authDbViewAdapter.saveExercise { success in
//                    completion(success)
//                }
//            }
//        )
//        self.createProgramViewModel = createProgramViewModel
//    }
//}

//registerAction: { [weak self] completion in
//    guard let self = self else { return }
//    self.authDbViewAdapter.registerUser(
//        email: self.authDbViewAdapter.emailInput,
//        password: self.authDbViewAdapter.passwordInput) { success in
//            completion(success)
//        }
