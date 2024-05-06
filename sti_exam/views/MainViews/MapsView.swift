//
//  MapsView.swift
//  sti_exam
//
//  Created by Andreas Antonsson on 2024-03-14.
//

import SwiftUI

struct MapsView: View {
    var body: some View {
        content
    }
    
    @ViewBuilder private var content: some View {
        VStack() {
            Maps()
        }
    }
    
    struct ViewModel {
        let title: String
    }
}




#Preview {
    MapsView()
}
