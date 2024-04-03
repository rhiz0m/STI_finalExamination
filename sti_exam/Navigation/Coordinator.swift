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
    case CreateExerciseView
    case SearchView
    case MapsView
    
    var id: String {
        self.rawValue
    }

}

enum Sheet: String, Identifiable {
    case CreateProgramView
    case UpdateProgramView
    case UpdateExerciseView
    
    var id: String {
        self.rawValue
    }
}

enum FullScreenCover: String, Identifiable {
    case SignUpView
    
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
    
    @MainActor @ViewBuilder
    func build(screen: Screens, viewAdapter: HomeViewAdapter) -> some View {
        switch screen {
        case .LoginView:
            LoginView(viewAdapter: viewAdapter)
        case .SplashScreen:
            SplashScreen()
        case .HomeView:
            HomeView(viewAdapter: viewAdapter)
        case .CreateExerciseView:
            CreateExerciseView(viewAdapter: viewAdapter)
        case .SearchView:
            SearchView()
        case .MapsView:
            MapsView()
        }
    }
    
    @MainActor @ViewBuilder
    func build(sheet: Sheet, viewAdapter: HomeViewAdapter) -> some View {
        switch sheet {
        case .CreateProgramView:
            CreateProgramView(viewAdapter: viewAdapter)
        case .UpdateProgramView:
            UpdateProgramView(viewAdapter: viewAdapter)
        case .UpdateExerciseView:
            UpdateExerciseView(viewAdapter: viewAdapter)
        }
    }
    
    @MainActor @ViewBuilder
    func build(fullScreenCover: FullScreenCover, viewAdapter: HomeViewAdapter) -> some View {
        switch fullScreenCover {
        case .SignUpView:
            SignUpView(viewAdapter: viewAdapter)
        }
    }
}
