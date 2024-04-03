//
//  ProgramList.swift
//  sti_exam
//
//  Created by Andreas Antonsson on 2024-04-03.
//

import SwiftUI

struct ProgramList: View {
    var viewAdapter: HomeViewAdapter
    
    var body: some View {
        List {
            Text("Create program")
                .onTapGesture {
                    viewAdapter.coordinator.present(sheet: .UpdateProgramView)
                }
        }
    }
}

#Preview {
    ProgramList(viewAdapter: HomeViewAdapter(coordinator: Coordinator()))
}
