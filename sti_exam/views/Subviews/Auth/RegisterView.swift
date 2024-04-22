//
//  SignUpView.swift
//  sti_exam
//
//  Created by Andreas Antonsson on 2024-03-14.
//

import SwiftUI

struct RegisterView: View {
    @ObservedObject var authViewAdapter: AuthViewAdapter
    @ObservedObject var homeViewAdapter: HomeViewAdapter
    @State var email = ""
    @State var confirmEmail = ""
    @State var password = ""
    @State var confirmPassword = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        if let viewModel = authViewAdapter.signUpViewModel {
            content(viewModel: viewModel)
            
        } else {
            ProgressView()
                .onAppear(perform: {
                    authViewAdapter.generateSignUpViewModel()
                    
                })
        }
    }
    
    @ViewBuilder func content(viewModel: ViewModel) -> some View {
        VStack(spacing: 0) {
            VStack(spacing: 18) {
                VStack {
                    EmailView(viewAdapter: authViewAdapter, userNameInput: $email, customLabel: viewModel.emailLabel, textSize: 14)
                        .padding(.vertical)
                    EmailView(viewAdapter: authViewAdapter, userNameInput: $confirmEmail, customLabel: viewModel.confirmEmail, textSize: 12)
                        .padding(.vertical)
                    PasswordView(viewAdapter: authViewAdapter, userNameInput: $password, customLabel: viewModel.passwordLabel, textSize: 14)
                        .padding(.bottom, GridPoints.x3)
                    PasswordView(viewAdapter: authViewAdapter, userNameInput: $confirmPassword, customLabel: viewModel.confirmPassword, textSize: 12)
                        .padding(.bottom, GridPoints.x3)
                }
                .padding(.horizontal, GridPoints.x2)
                Divider()
                    .rotationEffect(Angle(degrees: -GridPoints.x1))
                
                Text(viewModel.signUpLabel)
                    .font(.title2)
                    .bold()
                    .padding(.vertical, GridPoints.x1)
                    .padding(.horizontal, GridPoints.x3)
                    .background(.white)
                    .cornerRadius(8)
                    .shadow(color: Color.brown.opacity(0.6), radius: 8, x: 0, y: 2)
                    .onTapGesture {
                        if !email.isEmpty && email == confirmEmail && !password.isEmpty && password == confirmPassword {
                            _ = authViewAdapter.registerUser(email: email, password: password)
                        }
                    }
                
                
                Text(viewModel.cancelLabel)
                    .bold()
                    .padding(.vertical, GridPoints.x1)
                    .padding(.horizontal, GridPoints.x3)
                    .background(.yellow)
                    .border(.white, width: 3)
                    .cornerRadius(8)
                    .padding(.bottom, GridPoints.x2)
                    .onTapGesture {
                        presentationMode.wrappedValue.dismiss()
                    }
            }
            .background(.yellow)
            .padding(.bottom, GridPoints.x8)
        }
        .padding(GridPoints.half)
        .navigationBarBackButtonHidden(true)
        
    }
    
    @ViewBuilder private func backgroundImageView(imageName: String) -> some View {
        Image(imageName)
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.bottom)
            .overlay(
                LinearGradient(
                    gradient: Gradient(
                        colors: [
                            .yellow.opacity(0.2),
                            .yellow.opacity(1.8)]
                    ),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.bottom)
            )
    }
    
    struct ViewModel {
        let appTitle: String
        let cancelLabel: String
        let signUpLabel: String
        let passwordLabel: String
        let confirmPassword: String
        let emailLabel: String
        let confirmEmail: String
    }
}

#Preview {
    RegisterView(authViewAdapter: AuthViewAdapter(coordinator: Coordinator(), emailInput: "", passwordInput: ""), homeViewAdapter: HomeViewAdapter(),
                 email: "", confirmEmail: "", password: "", confirmPassword: "")
}
