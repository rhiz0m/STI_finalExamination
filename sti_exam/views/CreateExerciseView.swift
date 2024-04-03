//
//  CreateExerciseView.swift
//  sti_exam
//
//  Created by Andreas Antonsson on 2024-03-14.
//

import SwiftUI

struct CreateExerciseView: View {
    var viewAdapter: HomeViewAdapter
    
    var body: some View {
            List() {
                VStack(alignment: .leading) {
                    Text("Create Exercise")
                    Text("Update Exercise")
                        .onTapGesture {
                            viewAdapter.coordinator.present(sheet: .UpdateExerciseView)
                        }
                    Text("Save program")
                }
        }
    }
}

#Preview {
    CreateExerciseView(viewAdapter: HomeViewAdapter(coordinator: Coordinator()))
}
