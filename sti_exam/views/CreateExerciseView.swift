//
//  CreateExerciseView.swift
//  sti_exam
//
//  Created by Andreas Antonsson on 2024-03-14.
//

import SwiftUI

struct CreateExerciseView: View {
    var authViewAdapter: AuthViewAdapter
    
    var body: some View {
                VStack() {
                    Text("Create Exercise")
                        .padding()
                    HStack {
                        Text("Save program")
                        Text("Update Exercise")
                            .onTapGesture {
                                authViewAdapter.coordinator.present(sheet: .UpdateExerciseView)
                            }
                    }
                    .padding()
                    Text("Cancel").onTapGesture {
                        authViewAdapter.coordinator.pop()
                    }
                }
    }
}

#Preview {
    CreateExerciseView(authViewAdapter: AuthViewAdapter(coordinator: Coordinator(), emailInput: "", passwordInput: ""))
}
