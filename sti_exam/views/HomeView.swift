//
//  HomeView.swift
//  sti_exam
//
//  Created by Andreas Antonsson on 2024-03-14.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var userAuthAdapter: UserAuthAdapter
    
    var body: some View {
        VStack {
            TopBar(
                authDbViewAdapter: userAuthAdapter.authDbViewAdapter)
            BottomBar(
                authDbViewAdapter: userAuthAdapter.authDbViewAdapter)
        }
        .navigationBarBackButtonHidden(true)
    }

}

#Preview {
    HomeView(userAuthAdapter: UserAuthAdapter(authDbViewAdapter: AuthDbViewAdapter()))
}
