//
//  LoginViewAdapter.swift
//  sti_exam
//
//  Created by Andreas Antonsson on 2024-04-27.
//

import Foundation

class UserAuthAdapter: ObservableObject {
    @Published var loginViewModel: LoginView.ViewModel?
    @Published var registerViewModel: RegisterView.ViewModel?
    
    var authDbViewAdapter: AuthDbViewAdapter
    
    init(authDbViewAdapter: AuthDbViewAdapter) {
        self.authDbViewAdapter = authDbViewAdapter
    }
    
    func generateLoginViewModel() {
        let loginViewModel = LoginView.ViewModel(
            appTitle: LocalizedStrings.apptitle,
            loginTitle: LocalizedStrings.login,
            registerTitle: LocalizedStrings.register,
            passwordTitle: LocalizedStrings.apptitle,
            emailTitle: LocalizedStrings.email)

        self.loginViewModel = loginViewModel
    }
    
    func generateRegisterViewModel() {
        let registerViewModel = RegisterView.ViewModel(
            appTitle: LocalizedStrings.apptitle,
            cancelTitle: LocalizedStrings.cancel,
            registerTitle: LocalizedStrings.register,
            passwordTitle: LocalizedStrings.password,
            confirmPasswordTitle: LocalizedStrings.confirmPassword,
            emailTitle: LocalizedStrings.email,
            confirmEmailTitle: LocalizedStrings.confirmEmail
        )

        self.registerViewModel = registerViewModel
    }
}
