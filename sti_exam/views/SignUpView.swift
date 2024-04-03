//
//  SignUpView.swift
//  sti_exam
//
//  Created by Andreas Antonsson on 2024-03-14.
//

import SwiftUI

struct SignUpView: View {
    var viewAdapter: HomeViewAdapter
    
    var body: some View {
        Text("SignUp View!")
        Text("Cancel")
            .onTapGesture {
                viewAdapter.coordinator.push(.LoginView)
            }
    }
}

#Preview {
    SignUpView(viewAdapter: HomeViewAdapter(coordinator: Coordinator()))
}
