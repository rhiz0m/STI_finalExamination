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
        
        NavigationLink(destination: viewAdapter.coordinator.build(screen: .HomeView, viewAdapter: viewAdapter), label: {
             Text("Login")
         })
    }
}

#Preview {
    LoginView(viewAdapter: HomeViewAdapter(coordinator: Coordinator()))
}
