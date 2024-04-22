//
//  BottomBar.swift
//  sti_exam
//
//  Created by Andreas Antonsson on 2024-04-06.
//

import SwiftUI

struct BottomBar: View {
    @ObservedObject var authViewAdapter: AuthViewAdapter
    @ObservedObject var homeViewAdapter: HomeViewAdapter
    
    @State private var tabSelection = 1
    var body: some View {
        ZStack(alignment: .bottom) {
                TabView(selection: $tabSelection) {
                    ProgramList(authViewAdapter: authViewAdapter)
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
    BottomBar(authViewAdapter: AuthViewAdapter(coordinator: Coordinator(), emailInput: "", passwordInput: ""), homeViewAdapter: HomeViewAdapter())
}
