//
//  UpdateProgramView.swift
//  sti_exam
//
//  Created by Andreas Antonsson on 2024-03-14.
//

import SwiftUI

struct UpdateProgramView: View {
    var viewAdapter: HomeViewAdapter
    
    var body: some View {
        VStack {
            Text("Update Program!")
            HStack {
                Text("Save")
                    .padding()
                Text("Dismiss X")
                    .onTapGesture {
                        viewAdapter.coordinator.dismissSheet()
                    }
            }
        }
    }
}

#Preview {
    UpdateProgramView(viewAdapter: HomeViewAdapter(coordinator: Coordinator()))
}
