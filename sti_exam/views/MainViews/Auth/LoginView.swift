//
//  LoginView.swift
//  sti_exam
//
//  Created by Andreas Antonsson on 2024-03-14.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var userAuthAdapter: UserAuthAdapter
    @State private var navigateToHome = false
    
    var body: some View {
        if let viewModel = userAuthAdapter.loginViewModel{
            content(viewModel: viewModel)
            NavigationLink(
                destination: HomeView()
                    .environmentObject(userAuthAdapter),
                isActive: $navigateToHome,
                label: { EmptyView() })
        } else {
            ProgressView()
                .onAppear(perform: {
                    userAuthAdapter.generateLoginViewModel()
                })
        }
    }
    
    @ViewBuilder func content(viewModel: ViewModel) -> some View {
        VStack(spacing: 0) {
            ZStack(alignment: .bottom) {
                backgroundImageView(imageName: "")
                
                Text(viewModel.appTitle)
                    .padding(.leading, GridPoints.custom(4))
                    .rotation3DEffect(
                        .degrees(50),
                        axis: (x: 20.0, y: -90, z: 0.0)
                    )
                    .shadow(color: .yellow.opacity(0.5), radius: 1, x: 1, y: 1)
                    .font(Font.custom("PermanentMarker-Regular", size: 35))
            }
            VStack(spacing: 18) {
                VStack {
                    EmailView(
                        authDbViewAdapter: userAuthAdapter.authDbViewAdapter,
                        userNameInput: $userAuthAdapter.authDbViewAdapter.emailInput,
                        customLabel: viewModel.emailTitle, textSize: 14)
                    .padding(.vertical)
                    
                    PasswordView(authDbViewAdapter: userAuthAdapter.authDbViewAdapter,
                                 userNameInput: $userAuthAdapter.authDbViewAdapter.passwordInput,
                                 customLabel: viewModel.passwordTitle, textSize: 12)
                    .padding()
                }
                .padding(.horizontal, GridPoints.x2)
                Divider()
                    .rotationEffect(Angle(degrees: -GridPoints.x1))
                
                Text(viewModel.loginTitle)
                    .font(.title2)
                    .bold()
                    .padding(.vertical, GridPoints.x1)
                    .padding(.horizontal, GridPoints.x3)
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(color: Color.brown.opacity(0.6), radius: 8, x: 0, y: 2)
                    .onTapGesture {
                        if !userAuthAdapter.authDbViewAdapter.emailInput.isEmpty && !userAuthAdapter.authDbViewAdapter.passwordInput.isEmpty {
                            viewModel.loginAction { success in
                                if success {
                                    navigateToHome = true
                                } else {
                                    
                                }
                            }
                        }
                    }
                
                NavigationLink(destination: RegisterView(
                    userAuthAdapter: userAuthAdapter),
                               label: {
                    Text(viewModel.registerTitle)
                })
                .bold()
                .padding(.vertical, GridPoints.x1)
                .padding(.horizontal, GridPoints.x3)
                .background(.yellow)
                .border(.white, width: 3)
                .cornerRadius(8)
                .padding(.bottom, GridPoints.x2)
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
        let loginTitle: String
        let registerTitle: String
        let passwordTitle: String
        let emailTitle: String
        let loginAction: (@escaping (Bool) -> Void) -> Void
    }
}

#Preview {
    LoginView()
}
