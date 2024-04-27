//
//  MapsViewModel.swift
//  sti_exam
//
//  Created by Andreas Antonsson on 2024-04-27.
//

import Foundation
class MapsViewModel: ObservableObject {
    @Published var mapsViewModel: MapsView.ViewModel?
    
    func generateMapsViewModel() {
        let mapsViewModel = MapsView.ViewModel(
            title: "")
    }
}
