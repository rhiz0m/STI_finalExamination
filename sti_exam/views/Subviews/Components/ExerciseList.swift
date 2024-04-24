//
//  ExerciseList.swift
//  sti_exam
//
//  Created by Andreas Antonsson on 2024-04-23.
//

import SwiftUI
import FirebaseAuth


struct ExerciseList: View {
    @ObservedObject var exerciseViewAdapter: ExerciseViewAdapter
    @ObservedObject var authDatabaseViewAdapter: AuthDatabaseViewAdapter
    @ObservedObject var homeViewAdapter: HomeViewAdapter
    
    var body: some View {
        VStack() {
            HStack(alignment: .center) {
                Image("logo")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .scaledToFit()
                    .cornerRadius(50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(Color.gray, lineWidth: 2)
                    )
                Spacer()
                Text(LocalizedStrings.welcome)
                    .font(.title).bold()
                    .foregroundStyle(.black)
                Spacer()
                Button(action: {
                    authDatabaseViewAdapter.logout()
                }, label: {
                    RoundedBtn(icon: homeViewAdapter.systemImages.power)
                }).background(.black).cornerRadius(50)
                
            }.padding(.top).padding(.horizontal, GridPoints.x4)
            
            if let userData = authDatabaseViewAdapter.currentUserData {
                if userData.usersExercises.isEmpty {
                    Text(LocalizedStrings.noExercises)
                        .foregroundStyle(CustomColors.dark)
                        .italic()
                        .padding(.top)
                    
                    Spacer()
                } else {
                    List(userData.usersExercises) { exercise in
                        
                        NavigationLink(
                            destination: UpdateProgramView(
                                authViewAdapter: authDatabaseViewAdapter, viewModel: exerciseViewAdapter),
                            tag: exercise.id,
                            selection: $exerciseViewAdapter.selectedExerciseID
                            
                        ) {
                            VStack(alignment: .leading) {
                                Text(exercise.exerciseName)
                                    .font(.headline)
                                    .bold()
                                    .foregroundStyle(.white)
                                    .padding(.vertical, GridPoints.x1)
                                Text("\(LocalizedStrings.type) \(exercise.type)")
                                    .foregroundStyle(.white)
                                    .font(.caption)
                                Text("\(LocalizedStrings.muscleGroups) \(exercise.muscleGroups.joined(separator: " "))")
                                    .foregroundStyle(.white)
                                    .font(.caption)
                                
                                ForEach(exercise.usersTrainingRecords) { records in
                                    HStack() {
                                        VStack(alignment: .leading) {
                                            HStack {
                                                Text("\(LocalizedStrings.weight) \(records.weight)").foregroundStyle(.white).font(.caption)
                                                Text("\(LocalizedStrings.sets) \(records.sets)").foregroundStyle(.white).font(.caption)
                                                Text("\(LocalizedStrings.reps) \(records.reps)").foregroundStyle(.white).font(.caption)
                                                
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
                                        Spacer()
                                        Image(systemName: homeViewAdapter.systemImages.arrowRightCircle)
                                            .foregroundColor(CustomColors.cyan)
                                            .font(.system(size: 40))
                                    }
                                }
                            }
                        }
                        
                        .listRowBackground(LinearGradient(gradient: Gradient(colors: [Color.black, Color(red: 33/255, green: 49/255, blue: 61/255)]), startPoint: .bottom, endPoint: .top)
                            .cornerRadius(GridPoints.half))
                        
                        
                        VStack {
                            Button(action: {
                                authDatabaseViewAdapter.deleteProgram(exercise: exercise)
                            }, label: {
                                HStack(alignment: .center) {
                                    RoundedBtn(icon: homeViewAdapter.systemImages.trash)
                                    Spacer()
                                    VStack(alignment: .leading) {
                                        Text(LocalizedStrings.created).font(.caption)
                                        Text("\(formatDate(exercise.date))")
                                    }
                                    
                                }.padding(GridPoints.x2)
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
        .scrollContentBackground(.hidden)
    }
}

private func formatDate(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .short
    dateFormatter.timeStyle = .short
    return dateFormatter.string(from: date)
}

#Preview {
    ExerciseList(
        exerciseViewAdapter: ExerciseViewAdapter(),
        authDatabaseViewAdapter: AuthDatabaseViewAdapter(),
        homeViewAdapter: HomeViewAdapter())
}
