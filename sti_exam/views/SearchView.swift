//
//  SearchView.swift
//  sti_exam
//
//  Created by Andreas Antonsson on 2024-03-14.
//

import SwiftUI


struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    @State var selected: Bool = false
    @State private var title = ""
    
    var body: some View {
        content
    }
    
    @ViewBuilder private var content: some View {
        ZStack {
            backgroundImageView(imageName: "gym_womanBg")
            VStack(spacing: CGFloat(GridPoints.x3)) {
                searchFeildView
                resultListView()
            }
        }
    }
    
    
    @ViewBuilder private func backgroundImageView(imageName: String) -> some View {
        Image(imageName)
            .resizable()
        //            .scaledToFill()
            .edgesIgnoringSafeArea(.bottom)
            .overlay(
                LinearGradient(
                    gradient: Gradient(
                        colors: [
                            Color.cyan.opacity(0.05),
                            Color.black.opacity(1)]
                    ),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.bottom)
            )
    }
    
    
    @ViewBuilder private func resultListView() -> some View {
        
        List(viewModel.apiResponse) { exerciseInfo in
            VStack(alignment: .leading, spacing: 8) {
                HStack(alignment: .top) {
                    Text("Name:")
                        .bold()
                        .foregroundColor(CustomColors.cyan)
                    
                    Text(exerciseInfo.name)
                        .foregroundColor(.white)
                }
                HStack {
                    Text("Type:")
                        .bold()
                        .foregroundColor(CustomColors.cyan)
                    
                    Text("\(exerciseInfo.type)")
                        .foregroundColor(.white)
                }
                HStack {
                    Text("Muscle:")
                        .bold()
                        .foregroundColor(CustomColors.cyan)
                    
                    Text("\(exerciseInfo.muscle)")
                        .foregroundColor(.white)
                    
                }
                HStack {
                    Text("Equipment:")
                        .bold()
                        .foregroundColor(CustomColors.cyan)
                    
                    Text("\(exerciseInfo.equipment)")
                        .foregroundColor(.white)
                }
                HStack {
                    Text("Difficulty:")
                        .bold()
                        .foregroundColor(CustomColors.cyan)
                    
                    Text("\(exerciseInfo.difficulty)")
                        .foregroundColor(.white)
                }
                VStack(alignment: .leading) {
                    Text("Instructions:")
                        .bold()
                        .foregroundColor(CustomColors.cyan)
                    
                    Text("\(exerciseInfo.instructions)")
                        .foregroundColor(.white)
                }
            }
            .padding()
            .background(Color.black)
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            
        }.cornerRadius(GridPoints.x2)
            .listStyle(PlainListStyle())
        
            .padding(.horizontal, GridPoints.x8)
            .shadow(color: CustomColors.cyan.opacity(0.2), radius: 15, x: 0, y: 5)
        
    }
    
    
    @ViewBuilder private var searchFeildView: some View {
        
        
        
        HStack {
            CustomTextField(textInput: $title, title: "musclegroups...")
            
            Button(action: {
                withAnimation(.bouncy(duration: 0.5)) {
                    selected.toggle()
                    viewModel.API(muscle: title)
                }
            }, label: {
                RoundedBtn(title: "", icon: "magnifyingglass.circle.fill")
                    .scaleEffect(selected ? 1.1 : 1.0)
            })
        }.padding(.horizontal, GridPoints.x8)
            .padding(.top, GridPoints.x4)
        
    }
    
    struct ViewModel {
        let title: String
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
