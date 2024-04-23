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
    case SplashScreen
    case HomeView
    case UpdateProgramView
    case CreateExerciseView
    case SearchView
    case MapsView
    
    var id: String {
        self.rawValue
    }

}

enum Sheet: String, Identifiable {
    case CreateProgramView
    case UpdateExerciseView
    
    var id: String {
        self.rawValue
    }
}

enum FullScreenCover: String, Identifiable {
    case RegisterView
    
    var id: String {
        self.rawValue
    }
}

class Coordinator : ObservableObject {
    
    @Published var path = NavigationPath()
    @Published var sheet: Sheet?
    @Published var fullScreenCover: FullScreenCover?
    
    func push(_ screen: Screens) {
        path.append(screen)
    }
    
    func present(sheet: Sheet) {
        self.sheet = sheet
    }
    
    func present(fullScreenCover: FullScreenCover) {
        self.fullScreenCover = fullScreenCover
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func dismissSheet() {
        self.sheet = nil
    }
    
    func dismissFullScreenCover() {
        self.fullScreenCover = nil
    }
    
    @MainActor @ViewBuilder
    func build(screen: Screens, authViewAdapter: AuthViewAdapter, homeViewAdapter: HomeViewAdapter, exerciceViewAdapter: ExerciseViewAdapter) -> some View {
        switch screen {
        case .LoginView:
            LoginView(authViewAdapter: authViewAdapter)
        case .SplashScreen:
            SplashScreen()
        case .HomeView:
            HomeView(authViewAdapter: authViewAdapter)
        case .UpdateProgramView:
            UpdateProgramView(authViewAdapter: authViewAdapter, viewModel: exerciceViewAdapter)
        case .CreateExerciseView:
            CreateExerciseView(authViewAdapter: authViewAdapter)
        case .SearchView:
            SearchView()
        case .MapsView:
            MapsView()
        }
    }
    
    @MainActor @ViewBuilder
    func build(sheet: Sheet, authViewAdapter: AuthViewAdapter) -> some View {
        switch sheet {
        case .CreateProgramView:
            CreateProgramView(authViewAdapter: authViewAdapter)
        case .UpdateExerciseView:
            UpdateExerciseView(authViewAdapter: authViewAdapter)
        }
    }
    
    @MainActor @ViewBuilder
    func build(fullScreenCover: FullScreenCover, authViewAdapter: AuthViewAdapter) -> some View {
        switch fullScreenCover {
        case .RegisterView:
            RegisterView(authViewAdapter: authViewAdapter)
        }
    }
}
