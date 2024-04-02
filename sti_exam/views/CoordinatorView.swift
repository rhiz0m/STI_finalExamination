//
//  CoordinatorView.swift
//  sti_exam
//
//  Created by Andreas Antonsson on 2024-03-14.
//

import SwiftUI

struct CoordinatorView: View {
    @ObservedObject var viewAdapter: HomeViewAdapter
    
    var body: some View {
        NavigationStack(path: $viewAdapter.coordinator.path, root: {
            viewAdapter.coordinator.build(screen: .LoginView, viewAdapter: viewAdapter)
                .navigationDestination(for: Screens.self) { screen in
                    viewAdapter.coordinator.build(screen: screen, viewAdapter: viewAdapter)
                }
        })
        .environmentObject(viewAdapter.coordinator)
    }
}

#Preview {
    CoordinatorView(viewAdapter: HomeViewAdapter(coordinator: Coordinator()))
}
