//
//  CreateProgramView.swift
//  sti_exam
//
//  Created by Andreas Antonsson on 2024-03-14.
//

import SwiftUI

struct CreateProgramView: View {
    var viewAdapter: HomeViewAdapter
    
    var body: some View {
        VStack {
            Text("Create program")
            HStack {
                Text("Save program")
                    .padding()
                Text("Add Exercises")
                    .onTapGesture {
                        viewAdapter.coordinator.push(.CreateExerciseView)
                    }
            }
        }
    }
}

#Preview {
    CreateProgramView(viewAdapter: HomeViewAdapter(coordinator: Coordinator()))
}
