//
//  UpdateExerciseView.swift
//  sti_exam
//
//  Created by Andreas Antonsson on 2024-03-14.
//

import SwiftUI

struct UpdateExerciseView: View {
    var authViewAdapter: AuthViewAdapter
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Update Exercise!")
            Text("Dismiss X")
                .onTapGesture {
                    authViewAdapter.coordinator.dismissSheet()
                }
        }
    }
}

#Preview {
    UpdateExerciseView(authViewAdapter: AuthViewAdapter(coordinator: Coordinator(), emailInput: "", passwordInput: ""))
}
