//
//  CreateProgramView.swift
//  sti_exam
//
//  Created by Andreas Antonsson on 2024-03-14.
//

import SwiftUI

struct CreateProgramView: View {
    var authViewAdapter: AuthViewAdapter
    
    var body: some View {
        VStack {
            Text("Create program")
            HStack {
                Text("Save program")
                    .padding()
                Text("Add Exercises")
                    .onTapGesture {
                        authViewAdapter.coordinator.push(.CreateExerciseView)
                    }
            }
        }
    }
}

#Preview {
    CreateProgramView(authViewAdapter: AuthViewAdapter(coordinator: Coordinator(), emailInput: "", passwordInput: ""))
}
