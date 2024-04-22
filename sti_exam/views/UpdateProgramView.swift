//
//  UpdateProgramView.swift
//  sti_exam
//
//  Created by Andreas Antonsson on 2024-03-14.
//

import SwiftUI

struct UpdateProgramView: View {
    @ObservedObject var authViewAdapter: AuthViewAdapter
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("Update Program!")
            HStack {
                Text("Save")
                    .padding()
                Text("Dismiss")
                    .bold()
                    .padding(.vertical, GridPoints.x1)
                    .padding(.horizontal, GridPoints.x3)
                    .background(.yellow)
                    .border(.white, width: 3)
                    .cornerRadius(8)
                    .padding(.bottom, GridPoints.x2)
                    .onTapGesture {
                        presentationMode.wrappedValue.dismiss()
                    }
                Text("Add Exercise")
                    .onTapGesture {
                        authViewAdapter.coordinator.push(.CreateExerciseView)
                    }
            }
        }
    }
}

#Preview {
    UpdateProgramView(authViewAdapter: AuthViewAdapter(coordinator: Coordinator(), emailInput: "", passwordInput: ""))
}
