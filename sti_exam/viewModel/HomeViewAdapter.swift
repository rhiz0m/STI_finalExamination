//
//  HomeViewAdapter.swift
//  sti_exam
//
//  Created by Andreas Antonsson on 2024-04-02.
//

import Foundation

class HomeViewAdapter: ObservableObject {
//    @Published var coordinator: Coordinator
//    
//    init(coordinator: Coordinator) {
//        self.coordinator = coordinator
//    }
    
    @Published var topBarViewModel: TopBarView.ViewModel?
    @Published var customBottomBarViewModel: CustomBottomBar.ViewModel?
    @Published var createProgramViewModel: CreateProgramView.ViewModel?
    @Published var updateProgramViewModel: UpdateProgramView.ViewModel?
    
    var authDbViewAdapter: AuthDbViewAdapter
    var exerciseViewModel: ExerciseFormCell.ViewModel
    var trainingRecordViewModel: TrainingRecordFormCell.ViewModel

    init(authDbViewAdapter: AuthDbViewAdapter) {
        self.authDbViewAdapter = authDbViewAdapter
        
        self.exerciseViewModel = ExerciseFormCell.ViewModel(
            name: LocalizedStrings.name,
            type: LocalizedStrings.type,
            muscleGroups: LocalizedStrings.muscleGroups)
        
        self.trainingRecordViewModel = TrainingRecordFormCell.ViewModel(
            weight: LocalizedStrings.weight,
            reps: 0,
            sets: 0)
    }
    
    func generateTopBarViewModel() {
        let topBarViewModel = TopBarView.ViewModel(
            image: "logo",
            welcomeTitle: LocalizedStrings.welcome,
            icon: SelectedSystemImages.shared.power,
            logoutAction: {
                self.authDbViewAdapter.logout()
            }
         
        )
        self.topBarViewModel = topBarViewModel
    }
    
    func generateBottomBarViewModel() {
        let customBottomBarViewModel = CustomBottomBar.ViewModel(
            listTitle: LocalizedStrings.list,
            addTitle: LocalizedStrings.add,
            searchTitle: LocalizedStrings.search,
            mapTitle: LocalizedStrings.map,
            listIcon: SelectedSystemImages.shared.list,
            addIcon: SelectedSystemImages.shared.add,
            searchIcon: SelectedSystemImages.shared.search,
            mapIcon: SelectedSystemImages.shared.map
        )
        self.customBottomBarViewModel = customBottomBarViewModel
    }
    
    func generateCreateProgramViewModel() {
        let ProgramViewModel = CreateProgramView.ViewModel(
            saveTitle: LocalizedStrings.save, 
            categoryTitle: LocalizedStrings.usersExercise,
            exerciceFormCell: self.exerciseViewModel, 
            trainingRecordFormCell: self.trainingRecordViewModel,
            
            saveExercise: { [weak self] completion in
                guard let self = self else { return }
                self.authDbViewAdapter.saveExercise { success in
                    completion(success)
                }
            }
        )
        self.createProgramViewModel = ProgramViewModel
    }
    
    func generateUpdateProgramViewModel() {
        
        let updateViewModel = UpdateProgramView.ViewModel(
            updateExercisesTitle: "Update Exercises", 
            exerciceFormCell: self.exerciseViewModel,
            trainingRecordFormCell: self.trainingRecordViewModel
        )
        self.updateProgramViewModel = updateViewModel
    }

}
