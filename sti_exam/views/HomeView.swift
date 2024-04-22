//
//  HomeView.swift
//  sti_exam
//
//  Created by Andreas Antonsson on 2024-03-14.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var authViewAdapter: AuthViewAdapter
    @ObservedObject var homeViewAdapter: HomeViewAdapter
    
    var body: some View {
            VStack {
                Button(action: {
                    authViewAdapter.logout()
                }, label: {
                    Text("Logout")
                })
                BottomBar(authViewAdapter: AuthViewAdapter(coordinator: Coordinator(), emailInput: "", passwordInput: ""), homeViewAdapter: homeViewAdapter)
            }
        .navigationBarBackButtonHidden(true)
        }
    }

#Preview {
    HomeView(authViewAdapter: AuthViewAdapter(coordinator: Coordinator(), emailInput: "", passwordInput: ""), homeViewAdapter: HomeViewAdapter())
}
