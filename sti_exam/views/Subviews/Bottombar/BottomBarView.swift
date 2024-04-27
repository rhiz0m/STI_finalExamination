//
//  BottomBar.swift
//  sti_exam
//
//  Created by Andreas Antonsson on 2024-04-06.
//

import SwiftUI

struct BottomBar: View {
    @ObservedObject var authDbViewAdapter: AuthDbViewAdapter
    @State private var tabSelection = 1
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $tabSelection) {
                ExerciseListView( authDbViewAdapter: authDbViewAdapter)
                .tabItem {
                }.tag(1)
                
                CreateProgramView(authDbViewAdapter: authDbViewAdapter)
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
        authDbViewAdapter: AuthDbViewAdapter())
}
