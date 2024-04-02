//
//  Coordinator.swift
//  sti_exam
//
//  Created by Andreas Antonsson on 2024-03-14.
//

import Foundation
import SwiftUI

enum Screens: String, Identifiable {

    case LoginView
    case SignUpview
    case SplashScreen
    case HomeView
    case CreateProgramView
    case CreateExerciseView
    case UpdateProgramView
    case UpdateExerciseView
    case SearchView
    case MapsView
    
    var id: String {
        self.rawValue
    }

}

class Coordinator : ObservableObject {
    
    @Published var path = NavigationPath()
    
    func push(_ screen: Screens) {
        path.append(screen)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    @MainActor @ViewBuilder
    func build(screen: Screens, viewAdapter: HomeViewAdapter) -> some View {
        switch screen {
        case .LoginView:
            LoginView(viewAdapter: viewAdapter)
        case .SignUpview:
            SignUpView()
        case .SplashScreen:
            SplashScreen()
        case .HomeView:
            HomeView()
        case .CreateProgramView:
            CreateProgramView()
        case .CreateExerciseView:
            CreateExerciseView()
        case .UpdateProgramView:
            UpdateProgramView()
        case .UpdateExerciseView:
            UpdateExerciseView()
        case .SearchView:
            SearchView()
        case .MapsView:
            MapsView()
        }
    }
}
