//
//  SearchViewModel.swift
//  sti_exam
//
//  Created by Andreas Antonsson on 2024-04-23.
//

import Foundation

class SearchViewModel: ObservableObject {
    @Published var searchViewModel: SearchView.ViewModel?
    @Published var apiResponse: [ExerciseAPI] = []
    
    func generateSearchViewModel() {
        let searchViewModel = SearchView.ViewModel(
            title: "")
    }
    
    func API(muscle: String) {
        guard let muscleEncoded = muscle.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "https://api.api-ninjas.com/v1/exercises?muscle=\(muscleEncoded)") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue(auth().API_KEY, forHTTPHeaderField: "X-Api-Key")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode([ExerciseAPI].self, from: data)
                
                let exerciseDetails = result.map { exercise in
                    return ExerciseAPI(
                        id: UUID(),
                        name: exercise.name,
                        type: exercise.type,
                        muscle: exercise.muscle,
                        equipment: exercise.equipment,
                        difficulty: exercise.difficulty,
                        instructions: exercise.instructions
                    )
                }
                
                DispatchQueue.main.async {
                    self.apiResponse = exerciseDetails
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        task.resume()
    }
}
