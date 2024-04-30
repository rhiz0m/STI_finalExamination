//
//  CoordinatorView.swift
//  sti_exam
//
//  Created by Andreas Antonsson on 2024-03-14.
//

import SwiftUI

struct CoordinatorView: View {
    
    @StateObject var authDbViewAdapter: AuthDbViewAdapter
    @StateObject var homeViewAdapter = HomeViewAdapter(authDbViewAdapter: AuthDbViewAdapter())
    
    init(authDbViewAdapter: AuthDbViewAdapter) {
        self._authDbViewAdapter = StateObject(wrappedValue: authDbViewAdapter)

    }
    
    var body: some View {
        if let _ = authDbViewAdapter.currentUser {
            NavigationStack {
                HomeView()
            }
            .environmentObject(homeViewAdapter)
            
        } else {
            NavigationStack {
                LoginView(loginViewAdapter: UserAuthAdapter(authDbViewAdapter: authDbViewAdapter))
            }
        }
    }
}

#Preview {
    CoordinatorView(authDbViewAdapter: AuthDbViewAdapter())
}
