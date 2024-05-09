//
//  CoordinatorView.swift
//  sti_exam
//
//  Created by Andreas Antonsson on 2024-03-14.
//

import SwiftUI

struct CoordinatorView: View {
    @EnvironmentObject var userAuthAdapter: UserAuthAdapter
    @EnvironmentObject var homeViewAdapter: HomeViewAdapter

    var body: some View {
        if let _ = userAuthAdapter.authDbViewAdapter.currentUser {
            NavigationStack {
                HomeView()
                    .environmentObject(homeViewAdapter)
            }
            .environmentObject(userAuthAdapter)
          
            
        } else {
            NavigationStack {
                LoginView(userAuthAdapter: userAuthAdapter)
            }
            .environmentObject(userAuthAdapter)
        }
    }
}

#Preview {
    CoordinatorView()
}
