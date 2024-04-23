//
//  AuthViewAdapter.swift
//  sti_exam
//
//  Created by Andreas Antonsson on 2024-04-22.
//


import Foundation
import Firebase
import FirebaseAuth

class AuthViewAdapter: ObservableObject {
    @Published var loginViewModel: LoginView.ViewModel?
    @Published var registerViewModel: RegisterView.ViewModel?
    @Published var emailInput = ""
    @Published var passwordInput = ""
    @Published var id = ""
    @Published var title = ""
    @Published var date = Date()
    @Published var dateString: String = ""
    @Published var description = ""
    @Published var name = ""
    @Published var muscleGroups = ""
    @Published var weight = ""
    @Published var reps = 0
    @Published var sets = 0
    @Published var usersExercises: [UsersExcercise] = []
    @Published var usersTrainingRecord: [UsersTrainingRecord] = []
    @Published var currentUser: User?
    @Published var currentUserData: UserData?
    
    var db = Firestore.firestore()
    var auth = Auth.auth()
    let USER_DATA_COLLECTION = "user_data"
    let USER_EXERCISES = "usersExercises"
    var dbListener: ListenerRegistration?
    
    
    init() {
        auth.addStateDidChangeListener { auth, user in
            if let user = user {
                print("A user has been logged in \(user.email ?? "No Email")")
                self.currentUser = user
                self.startListeningToDb()

            } else {
                self.dbListener?.remove()
                self.dbListener = nil
                self.currentUserData = nil
                self.currentUser = nil
                print("A user has logged out")
            }
        }
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
    
    func clearFeilds() {
        id = ""
        title = ""
        date = Date()
        dateString = ""
        description = ""
        name = ""
        muscleGroups = ""
        weight = ""
        reps = 0
        sets = 0
        usersExercises = []
    }
    
   
    func startListeningToDb() {
        guard let user = currentUser else { return }
        
        let documentPath = "\(USER_DATA_COLLECTION)/\(user.uid)"
        print("Listening to Firestore document: \(documentPath)")
        print("Document path: \(documentPath)")
        
        dbListener = db.collection(self.USER_DATA_COLLECTION).document(user.uid).addSnapshotListener { snapshot, error in

            if let error = error {
                print("Error occurred: \(error.localizedDescription)")
                return
            }
            
            guard let documentSnapshot = snapshot else { return }
            
            let result = Result {
                try documentSnapshot.data(as: UserData.self)
            }
            
            switch result {
            case .success(let userData):
                self.currentUserData = userData

                self.usersExercises = userData.usersExercises
            case .failure(let error):
                print("Error decoding data: \(error.localizedDescription)")
            }
        }
    }
    
    func addProgramToDb(userExercise: UsersExcercise) {
        if let currentUser = currentUser {
            do {
                let documentRef = db.collection(USER_DATA_COLLECTION).document(currentUser.uid)
                
                documentRef.getDocument { (document, error) in
                    do {
                        if let document = document, document.exists {
                            try documentRef.updateData([
                                self.USER_EXERCISES: FieldValue.arrayUnion([try Firestore.Encoder().encode(userExercise)])
                            ]) { error in
                                if let error = error {
                                    print("Error updating Firestore: \(error.localizedDescription)")
                                } else {
                                    print("Exercise added successfully!")
                                }
                            }
                        } else {
                            try documentRef.setData([
                                self.USER_EXERCISES: [try Firestore.Encoder().encode(userExercise)]
                            ]) { error in
                                if let error = error {
                                    print("Error creating Firestore document: \(error.localizedDescription)")
                                } else {
                                    print("Document created successfully!")
                                }
                            }
                        }
                    } catch {
                        print("Error: \(error.localizedDescription)")
                    }
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }

    func deleteProgram(exercise: UsersExcercise) {
        if let currentUser = currentUser {
            do {
         
                var currentPrograms = currentUserData?.usersExercises ?? []
                currentPrograms.removeAll { $0.id == exercise.id }
                try db.collection(USER_DATA_COLLECTION)
                    .document(currentUser.uid)
                    .updateData([
                        USER_EXERCISES: try currentPrograms.map { try Firestore.Encoder().encode($0) }
                    ])
            } catch {
                print("Error updating Firestore: \(error.localizedDescription)")
            }
        }
    }
    
    func updateProgram(usersExercise: [UsersExcercise], completion: @escaping (Error?) -> Void) {
        guard let currentUser = currentUser else { return }

        do {
            let removedData = try usersExercise.map { try Firestore.Encoder().encode($0) }
            try db.collection(USER_DATA_COLLECTION)
                .document(currentUser.uid)
                .updateData([
                    USER_EXERCISES: FieldValue.arrayRemove(removedData)
                ]) { (error: Error?) in
                    if let error = error {
                        completion(error)
                    } else {
                        let addedData = try! usersExercise.map { try! Firestore.Encoder().encode($0) }
                        self.db.collection(self.USER_DATA_COLLECTION)
                            .document(currentUser.uid)
                            .updateData([
                                self.USER_EXERCISES: FieldValue.arrayUnion(addedData)
                            ]) { (error: Error?) in
                                completion(error)
                            }
                    }
                }
        } catch {
            print("Error updating Firestore: \(error.localizedDescription)")
            completion(error)
        }
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
