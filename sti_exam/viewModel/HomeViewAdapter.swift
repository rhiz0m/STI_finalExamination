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
    
    @Published var topBarView: TopBar.ViewModel?
    
    var authDbViewAdapter: AuthDbViewAdapter
    
    init(authDbViewAdapter: AuthDbViewAdapter) {
        self.authDbViewAdapter = authDbViewAdapter
    }
    
    func generateTopBarViewModel() {
        let topBarViewModel = TopBar.ViewModel(
            logoutAction: {
                self.authDbViewAdapter.logout()
            }
        )
    }
}
