//
//  LoginView.swift
//  sti_exam
//
//  Created by Andreas Antonsson on 2024-03-14.
//

import SwiftUI

struct LoginView: View {
    let viewAdapter: HomeViewAdapter
    
    var body: some View {
        VStack {
            Text("Login")
                .onTapGesture {
                    viewAdapter.coordinator.push(.HomeView)
                }
            Text("Sign up")
                .onTapGesture {
                    viewAdapter.coordinator.present(fullScreenCover: .SignUpView)
                }
            
        }
    }
}
#Preview {
    LoginView(viewAdapter: HomeViewAdapter(coordinator: Coordinator()))
}
