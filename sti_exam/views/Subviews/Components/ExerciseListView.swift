//
//  ExerciseList.swift
//  sti_exam
//
//  Created by Andreas Antonsson on 2024-04-23.
//

import SwiftUI

struct ExerciseListView: View {
    @ObservedObject var authDbViewAdapter: AuthDbViewAdapter
    
    var body: some View {
        VStack() {
            if let userData = authDbViewAdapter.currentUserData {
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
                                authDbViewAdapter: authDbViewAdapter),
                            tag: exercise.id,
                            selection: $authDbViewAdapter.selectedExerciseID
                            
                        ) {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text(exercise.exerciseName)
                                        .font(.headline)
                                        .bold()
                                        .foregroundStyle(.white)
                                        .padding(.vertical, GridPoints.x1)
                                    Spacer()
                                    Image(systemName: authDbViewAdapter.systemImages.arrowRightCircle)
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
                                authDbViewAdapter.deleteProgram(exercise: exercise)
                            }, label: {
                                HStack(alignment: .center) {
                                    RoundedBtn(icon: authDbViewAdapter.systemImages.trash)
                                    Spacer()
                                    VStack(alignment: .leading) {
                                        Text(LocalizedStrings.created).font(.caption)
                                        Text("\(formatDate(exercise.date))")
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
}

private func formatDate(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .short
    dateFormatter.timeStyle = .short
    return dateFormatter.string(from: date)
}

#Preview {
    ExerciseListView(
        authDbViewAdapter: AuthDbViewAdapter())
}
