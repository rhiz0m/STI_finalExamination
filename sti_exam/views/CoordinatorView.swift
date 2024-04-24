//
//  CoordinatorView.swift
//  sti_exam
//
//  Created by Andreas Antonsson on 2024-03-14.
//

import SwiftUI

struct CoordinatorView: View {
    
    @ObservedObject var authViewAdapter: AuthDatabaseViewAdapter
    @ObservedObject var homeViewAdapter: HomeViewAdapter
    
    var body: some View {
        VStack {
            
        }
    }
}

#Preview {
    CoordinatorView(authViewAdapter: AuthDatabaseViewAdapter(), homeViewAdapter: HomeViewAdapter())
}
