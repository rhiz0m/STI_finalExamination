//
//  HomeView.swift
//  sti_exam
//
//  Created by Andreas Antonsson on 2024-03-14.
//

import SwiftUI

struct HomeView: View {
    let viewAdapter: HomeViewAdapter
    
    var body: some View {
        VStack {
            bottomBar(viewAdapter: viewAdapter)
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct bottomBar: View {
    var viewAdapter: HomeViewAdapter
    
    @State private var tabSelection = 1
    var body: some View {
        ZStack(alignment: .bottom) {
                TabView(selection: $tabSelection) {
                    ProgramList(viewAdapter: viewAdapter)
                        .tabItem {
                    }.tag(1)
                    
                    CreateProgramView(viewAdapter: viewAdapter)
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
    HomeView(viewAdapter: HomeViewAdapter(coordinator: Coordinator()))
}
