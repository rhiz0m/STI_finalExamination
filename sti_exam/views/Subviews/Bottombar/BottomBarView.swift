//
//  BottomBar.swift
//  sti_exam
//
//  Created by Andreas Antonsson on 2024-04-06.
//

import SwiftUI

struct BottomBarView: View {
    @EnvironmentObject var homeViewAdapter: HomeViewAdapter
    @State private var tabSelection = 1
    
    var body: some View {
        if let viewModel = homeViewAdapter.customBottomBarViewModel {
            content(viewModel: viewModel)
        } else {
            ProgressView()
                .onAppear(perform: {
                    homeViewAdapter.generateBottomBarViewModel()
                })
        }
    }
    
    @ViewBuilder func content(viewModel: CustomBottomBar.ViewModel) -> some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $tabSelection) {
                ExerciseListView(authDBViewAdapter: AuthDbViewAdapter())
                .tabItem {
                }.tag(1)
                
                CreateProgramView()
                    .tabItem {
                    }.tag(2)
                
                SearchView()
                    .tabItem {
                    }.tag(3)
                
                
                MapsView().tabItem {
                }.tag(4)
            }
            CustomBottomBar(tabSelection: $tabSelection, viewModel: viewModel)
        }
    }
    struct ViewModel {
        
    }
}

#Preview {
    BottomBarView()
        .environmentObject(HomeViewAdapter(authDbViewAdapter: AuthDbViewAdapter()))
}
