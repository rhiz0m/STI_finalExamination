//
//  HomeView.swift
//  sti_exam
//
//  Created by Andreas Antonsson on 2024-03-14.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var authViewAdapter: AuthViewAdapter
    
    var body: some View {
            VStack {
                BottomBar(authViewAdapter: authViewAdapter)
            }
        .navigationBarBackButtonHidden(true)
        }
    }



#Preview {
    HomeView(authViewAdapter: AuthViewAdapter())
}
