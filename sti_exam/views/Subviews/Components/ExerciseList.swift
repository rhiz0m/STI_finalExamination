//
//  ExerciseList.swift
//  sti_exam
//
//  Created by Andreas Antonsson on 2024-04-23.
//

import SwiftUI
import FirebaseAuth


struct ExerciseList: View {
    @ObservedObject var db: AuthViewAdapter
    @StateObject private var exerciseViewAdapter = ExerciseViewAdapter()
  
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
                Text("Welcome!")
                    .font(.title).bold()
                    .foregroundStyle(.black)
                Spacer()
                Button(action: {
                    db.logout()
                }, label: {
                    RoundedBtn(title: "", icon: "power")
                }).background(.black).cornerRadius(50)
             
            }.padding(.top).padding(.horizontal, GridPoints.x4)
            
            if let userData = db.currentUserData {
                if userData.usersExercises.isEmpty {
                    Text("You have no programs yet!")
                        .foregroundStyle(CustomColors.dark)
                        .italic()
                        .padding(.top)
                    
                    Spacer()
                } else {
                    List(userData.usersExercises) { exercise in
                        
                        NavigationLink(
                            destination: UpdateProgramView(authViewAdapter: db, viewModel: exerciseViewAdapter),
                            tag: exercise.id,
                            selection: $exerciseViewAdapter.selectedExerciseID
                            
                        ) {
                            VStack(alignment: .leading) {
                                Text(exercise.exerciseName)
                                    .font(.headline)
                                    .bold()
                                    .foregroundStyle(.white)
                                    .padding(.vertical, GridPoints.x1)
                                Text("Type: \(exercise.type)")
                                    .foregroundStyle(.white)
                                    .font(.caption)
                                Text("Muscle Groups: \(exercise.muscleGroups.joined(separator: " "))")
                                    .foregroundStyle(.white)
                                    .font(.caption)
                                
                                ForEach(exercise.usersTrainingRecords) { records in
                                    HStack() {
                                        VStack(alignment: .leading) {
                                            HStack {
                                                Text("Weight: \(records.weight)").foregroundStyle(.white).font(.caption)
                                                Text("Sets: \(records.sets)").foregroundStyle(.white).font(.caption)
                                                Text("Reps: \(records.reps)").foregroundStyle(.white).font(.caption)
                                                
                                            }
                                            HStack {
                                                Text("Total Reps: \(records.totalReps)")
                                                    .foregroundStyle(.white)
                                                    .font(.caption)
                                                Text("Total Weight: \(records.totalWeight)")
                                                    .foregroundStyle(.white)
                                                    .font(.caption)
                                            }
                                        }
                                        Spacer()
                                        Image(systemName: "arrow.right.circle")
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
                                db.deleteProgram(exercise: exercise)
                            }, label: {
                                HStack(alignment: .center) {
                                    RoundedBtn(title: "", icon: "trash")
                                    Spacer()
                                    VStack(alignment: .leading) {
                                        Text("Created:").font(.caption)
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
    ExerciseList(db: AuthViewAdapter())
}
