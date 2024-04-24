//
//  BottomBar.swift
//  sti_exam
//
//  Created by Andreas Antonsson on 2024-04-06.
//

import SwiftUI

struct BottomBar: View {
    @ObservedObject var authViewAdapter: AuthDatabaseViewAdapter
    @ObservedObject var exerciseViewAdapter: ExerciseViewAdapter
    @ObservedObject var homeViewAdapter: HomeViewAdapter
    
    @State private var tabSelection = 1
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $tabSelection) {
                ProgramList(
                    authDatabaseViewAdapter: authViewAdapter,
                    exerciseViewAdapter: exerciseViewAdapter,
                    homeViewAdapter: homeViewAdapter)
                .tabItem {
                }.tag(1)
                
                CreateProgramView(authViewAdapter: authViewAdapter)
                    .tabItem {
                    }.tag(2)
                
                SearchView()
                    .tabItem {
                    }.tag(3)
                
                
                MapsView().tabItem {
                }.tag(4)
            }
            CustomBottomBar(tabSelection: $tabSelection)
        }
    }
}
#Preview {
    BottomBar(
        authViewAdapter: AuthDatabaseViewAdapter(),
        exerciseViewAdapter: ExerciseViewAdapter(),
        homeViewAdapter: HomeViewAdapter())
}
