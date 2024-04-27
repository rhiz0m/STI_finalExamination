//
//  HomeView.swift
//  sti_exam
//
//  Created by Andreas Antonsson on 2024-03-14.
//

import SwiftUI

struct HomeView: View {
//    @StateObject private var homeViewAdapter = HomeViewAdapter()
    @ObservedObject var authDbViewAdapter: AuthDbViewAdapter
   
    var body: some View {
            VStack {
                TopBar(authDbViewAdapter: authDbViewAdapter)
                BottomBar(
                    authDbViewAdapter: authDbViewAdapter)
            }
        .navigationBarBackButtonHidden(true)
        }
    }

#Preview {
    HomeView(authDbViewAdapter: AuthDbViewAdapter())
}
