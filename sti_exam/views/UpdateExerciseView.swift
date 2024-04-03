//
//  UpdateExerciseView.swift
//  sti_exam
//
//  Created by Andreas Antonsson on 2024-03-14.
//

import SwiftUI

struct UpdateExerciseView: View {
    var viewAdapter: HomeViewAdapter
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Update Exercise!")
            Text("Dismiss X")
                .onTapGesture {
                    viewAdapter.coordinator.dismissSheet()
                }
        }
    }
}

#Preview {
    UpdateExerciseView(viewAdapter: HomeViewAdapter(coordinator: Coordinator()))
}
