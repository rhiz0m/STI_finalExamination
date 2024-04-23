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
            content
        }

    @ViewBuilder private var content: some View {
        ZStack{
            VStack() {
                list
            }
        }
    }

    @ViewBuilder private var list: some View {
        ExerciseList(db: authViewAdapter)
    }
    
}

#Preview {
    ProgramList(authViewAdapter: AuthViewAdapter())
}
