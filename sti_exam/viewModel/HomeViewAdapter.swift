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
    
    var authDbViewAdapter: AuthDbViewAdapter
    var selectedSystemImages = SelectedSystemImages()
    
    init(authDbViewAdapter: AuthDbViewAdapter) {
        self.authDbViewAdapter = authDbViewAdapter
    }
    
    func generateTopBarViewModel() {
        let topBarViewModel = TopBarView.ViewModel(
            image: "logo",
            welcomeTitle: LocalizedStrings.welcome,
            icon: selectedSystemImages.power,
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
            listIcon: selectedSystemImages.list,
            addIcon: selectedSystemImages.add,
            searchIcon: selectedSystemImages.search,
            mapIcon: selectedSystemImages.map
        )
        self.customBottomBarViewModel = customBottomBarViewModel
    }
}
