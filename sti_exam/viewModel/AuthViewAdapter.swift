//
//  AuthViewAdapter.swift
//  sti_exam
//
//  Created by Andreas Antonsson on 2024-04-22.
//

import Foundation
import Firebase

class AuthViewAdapter: ObservableObject {
    
    @Published var loginViewModel: LoginView.ViewModel?
    @Published var signUpViewModel: RegisterView.ViewModel?
    @Published var coordinator: Coordinator
    @Published var emailInput: String
    @Published var passwordInput: String
    @Published var currentUser: User?
    
    var auth =  Auth.auth()
    
    init(coordinator: Coordinator,
         emailInput: String,
         passwordInput: String
    ) {
        self.coordinator = coordinator
        self.emailInput = emailInput
        self.passwordInput = passwordInput
        
        auth.addStateDidChangeListener { auth, user in
            if let user = user {
                
                self.currentUser = user

            } else {
                self.currentUser = nil

            }
        }
    }

    func generateLoginViewModel() {
        let loginViewModel = LoginView.ViewModel(
            appTitle: "Training app",
            loginLabel: "Login",
            signUpLabel: "Sign Up",
            passwordLabel: "Password",
            emailLabel: "Email")
        
        self.loginViewModel = loginViewModel
    }
    
    func generateSignUpViewModel() {
        let signUpViewModel = RegisterView.ViewModel(
            appTitle: "Training app",
            cancelLabel: "Cancel",
            signUpLabel: "Sign Up",
            passwordLabel: "Password",
            confirmPassword: "Confirm Password",
            emailLabel: "Email",
            confirmEmail: "Confirm Email"
        )
        
        self.signUpViewModel = signUpViewModel
    }
    
    func registerUser(email: String, password: String) -> Bool {
        
        var success = false
        
        auth.createUser(withEmail: email, password: password) { authResult, error in
            
            if let error = error {
                print(error.localizedDescription)
                success = false
            }
            
            if authResult != nil {
                success = true
            }
        }
        return success
    }
    
    func loginUser(email: String, password: String, completion: @escaping (Bool) -> Void) {
        auth.signIn(withEmail: email, password: password) { authDataResult, error in
            if let error = error {
                print("Error logging in:", error.localizedDescription)
                completion(false)
            } else {
                print("You are logged in!")
                completion(true)
            }
        }
    }

    
     func logout() {
         do {
             emailInput = ""
             passwordInput = ""
             try Auth.auth().signOut()
         } catch let error as NSError {
             print("Error logout: \(error.localizedDescription)")
         }
     }
}
