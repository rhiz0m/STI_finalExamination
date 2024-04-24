//
//  ProgramList.swift
//  sti_exam
//
//  Created by Andreas Antonsson on 2024-04-03.
//

import SwiftUI

struct ProgramList: View {
    @ObservedObject var authDatabaseViewAdapter: AuthDatabaseViewAdapter
    @ObservedObject var exerciseViewAdapter: ExerciseViewAdapter
    @ObservedObject var homeViewAdapter: HomeViewAdapter
    
    var body: some View {
        content
    }
    
    @ViewBuilder private var content: some View {
        ZStack{
            VStack() {
                ExerciseList(exerciseViewAdapter: exerciseViewAdapter,
                             authDatabaseViewAdapter: authDatabaseViewAdapter,
                             homeViewAdapter: homeViewAdapter)
            }
        }
    }
}

#Preview {
    ProgramList(
        authDatabaseViewAdapter: AuthDatabaseViewAdapter(),
        exerciseViewAdapter: ExerciseViewAdapter(),
        homeViewAdapter: HomeViewAdapter())
}
