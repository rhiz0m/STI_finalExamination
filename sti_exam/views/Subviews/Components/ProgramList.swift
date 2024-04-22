//
//  ProgramList.swift
//  sti_exam
//
//  Created by Andreas Antonsson on 2024-04-03.
//

import SwiftUI

struct ProgramList: View {
    @ObservedObject var authViewAdapter: AuthViewAdapter
    
    var body: some View {
            List {
                NavigationLink(destination: UpdateProgramView(authViewAdapter: authViewAdapter), label: {
                    Text("Update Program")
                })
            }
    }
}

#Preview {
    ProgramList(authViewAdapter: AuthViewAdapter(coordinator: Coordinator(), emailInput: "", passwordInput: ""))
}
