//
//  HomeView.swift
//  sti_exam
//
//  Created by Andreas Antonsson on 2024-03-14.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var homeViewAdapter = HomeViewAdapter()
    @StateObject private var exerciseViewAdapter = ExerciseViewAdapter()
    @ObservedObject var authViewAdapter: AuthDatabaseViewAdapter
    
    var body: some View {
            VStack {
                BottomBar(
                    authViewAdapter: authViewAdapter,
                    exerciseViewAdapter: exerciseViewAdapter, 
                    homeViewAdapter: homeViewAdapter)
            }
        .navigationBarBackButtonHidden(true)
        }
    }

#Preview {
    HomeView(authViewAdapter: AuthDatabaseViewAdapter())
}
