//
//  ExerciseList.swift
//  sti_exam
//
//  Created by Andreas Antonsson on 2024-04-23.
//

import SwiftUI

struct ExerciseListView: View {
    @EnvironmentObject var homeViewAdapter: HomeViewAdapter
    private let viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        content(viewModel: viewModel)
    }
    
    @ViewBuilder func content(viewModel: ViewModel) -> some View {
        VStack() {
            if let userData = homeViewAdapter.authDbViewAdapter.currentUserData {
                if userData.usersExercises.isEmpty {
                    Text(LocalizedStrings.noExercises)
                        .foregroundStyle(CustomColors.dark)
                        .italic()
                        .padding(.top)
                    Spacer()
                } else {
                    List(userData.usersExercises) { exercise in
                        NavigationLink(
                            destination: UpdateProgramView(),
                            tag: exercise.id,
                            selection: $homeViewAdapter.authDbViewAdapter.selectedExerciseID
                        ) {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text(exercise.exerciseName)
                                        .font(.headline)
                                        .bold()
                                        .foregroundStyle(.white)
                                        .padding(.vertical, GridPoints.x1)
                                    Spacer()
                                    Image(systemName: "" /*homeViewAdapter.authDbViewAdapter.systemImages.arrowRightCircle*/)
                                        .foregroundColor(CustomColors.cyan)
                                        .font(.system(size: 30))
                                }
                                Text("\(LocalizedStrings.type) \(exercise.type)")
                                    .foregroundStyle(.white)
                                    .font(.caption)
                                Text("\(LocalizedStrings.muscleGroups) \(exercise.muscleGroups.joined(separator: " "))")
                                    .foregroundStyle(.white)
                                    .font(.caption)
                                
                                ForEach(exercise.usersTrainingRecords) { records in
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Text("\(LocalizedStrings.weight) \(records.weight)")
                                                .foregroundStyle(.white).font(.caption)
                                            Text("\(LocalizedStrings.sets) \(records.sets)")
                                                .foregroundStyle(.white).font(.caption)
                                            Text("\(LocalizedStrings.reps) \(records.reps)")
                                                .foregroundStyle(.white).font(.caption)
                                                .font(.caption)
                                        }
                                        HStack {
                                            Text("\(LocalizedStrings.totalReps) \(records.totalReps)")
                                                .foregroundStyle(.white)
                                                .font(.caption)
                                            Text("\(LocalizedStrings.totalWeight) \(records.totalWeight)")
                                                .foregroundStyle(.white)
                                                .font(.caption)
                                        }
                                    }
                                    
                                }
                            }
                        }
                        .listRowBackground(LinearGradient(gradient: Gradient(colors: [Color.black, Color(red: 33/255, green: 49/255, blue: 61/255)]), startPoint: .bottom, endPoint: .top)
                            .cornerRadius(GridPoints.half))
                        
                        VStack {
                            Button(action: {
                                homeViewAdapter.authDbViewAdapter.deleteProgram(exercise: exercise)
                                
                                
                                //                                authDBViewAdapter.deleteProgram(exercise: exercise)
                            }, label: {
                                HStack(alignment: .center) {
                                    RoundedBtn(icon: "" /*homeViewAdapter.authDbViewAdapter.systemImages.trash*/)
                                    Spacer()
                                    VStack(alignment: .leading) {
                                        Text(LocalizedStrings.created).font(.caption)
                                        Text("\(homeViewAdapter.customDateFormatter.formatDate(exercise.date))")
                                    }
                                    
                                }
                                .padding(.horizontal, GridPoints.x2)
                                .padding(.vertical, GridPoints.x1)
                                .overlay(
                                    RoundedRectangle(cornerRadius: GridPoints.x4)
                                        .stroke(LinearGradient(gradient: Gradient(colors: [CustomColors.dark, Color.black]),
                                                               startPoint: .bottom,
                                                               endPoint: .top),
                                                lineWidth: 2))
                            })
                        }
                        .listRowBackground(Color.black).cornerRadius(GridPoints.x1)
                    }
                }
            }
        }
    }
    
    struct ViewModel {
        let icon: String
    }
}

//#Preview {
//    ExerciseListView(exerciceListViewModel: ExerciseListView.ViewModel(icon: ""))
//        .environmentObject(HomeViewAdapter(authDbViewAdapter: AuthDbViewAdapter()))
//}
