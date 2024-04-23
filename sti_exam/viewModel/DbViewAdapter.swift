//
//  DbViewModel.swift
//  sti_exam
//
//  Created by Andreas Antonsson on 2024-04-23.
//

//import Foundation
//import Firebase
//
//class DbViewAdapter: ObservableObject {
//    @Published var id = ""
//    @Published var title = ""
//    @Published var date = Date()
//    @Published var dateString: String = ""
//    @Published var description = ""
//    @Published var name = ""
//    @Published var muscleGroups = ""
//    @Published var weight = ""
//    @Published var reps = 0
//    @Published var sets = 0
//    @Published var usersExercises: [UsersExcercise] = []
//    @Published var usersTrainingRecord: [UsersTrainingRecord] = []
//    @Published var currentUser: User?
//    @Published var currentUserData: UserData?
//    
//    var db = Firestore.firestore()
//    var auth = Auth.auth()
//    let USER_DATA_COLLECTION = "user_data"
//    let USER_EXERCISES = "usersExercises"
//    var dbListener: ListenerRegistration?
//    
//    func clearFeilds() {
//        id = ""
//        title = ""
//        date = Date()
//        dateString = ""
//        description = ""
//        name = ""
//        muscleGroups = ""
//        weight = ""
//        reps = 0
//        sets = 0
//        usersExercises = []
//        usersExercises = []
//    }
//    
//    
//   
//    func startListeningToDb() {
//        guard let user = currentUser else { return }
//        
//        let documentPath = "\(USER_DATA_COLLECTION)/\(user.uid)"
//        print("Listening to Firestore document: \(documentPath)")
//        
//        dbListener = db.collection(self.USER_DATA_COLLECTION).document(user.uid).addSnapshotListener { snapshot, error in
//
//            if let error = error {
//                print("Error occurred: \(error.localizedDescription)")
//                return
//            }
//            
//            guard let documentSnapshot = snapshot else { return }
//            
//            let result = Result {
//                try documentSnapshot.data(as: UserData.self)
//            }
//            
//            switch result {
//            case .success(let userData):
//                self.currentUserData = userData
//                print("sucess with userdata")
//                // Update local data
//                self.usersExercises = userData.usersExercises
//            case .failure(let error):
//                print("Error decoding data: \(error.localizedDescription)")
//            }
//        }
//    }
//
//    
//    func addProgramToDb(userExercise: UsersExcercise) {
//        if let currentUser = currentUser {
//            do {
//                // Update Firestore with arrayUnion to add the new exercise
//                try db.collection(USER_DATA_COLLECTION)
//                    .document(currentUser.uid)
//                    .updateData([
//                        USER_EXERCISES: FieldValue.arrayUnion([try Firestore.Encoder().encode(userExercise)])
//                    ])
//            } catch {
//                // Handle error
//                print("Error updating Firestore: \(error.localizedDescription)")
//            }
//        }
//    }
//
//    func deleteProgram(exercise: UsersExcercise) {
//        if let currentUser = currentUser {
//            do {
//         
//                var currentPrograms = currentUserData?.usersExercises ?? []
//
//                // Remove the program from the local array
//                currentPrograms.removeAll { $0.id == exercise.id }
//
//                // Update Firestore with the modified array
//                try db.collection(USER_DATA_COLLECTION)
//                    .document(currentUser.uid)
//                    .updateData([
//                        USER_EXERCISES: try currentPrograms.map { try Firestore.Encoder().encode($0) }
//                    ])
//            } catch {
//                // Handle error
//                print("Error updating Firestore: \(error.localizedDescription)")
//            }
//        }
//    }
//    
//    func updateProgram(usersExercise: [UsersExcercise], completion: @escaping (Error?) -> Void) {
//        guard let currentUser = currentUser else { return }
//
//        do {
//            // Remove the old exercise from the array
//            let removedData = try usersExercise.map { try Firestore.Encoder().encode($0) }
//            try db.collection(USER_DATA_COLLECTION)
//                .document(currentUser.uid)
//                .updateData([
//                    USER_EXERCISES: FieldValue.arrayRemove(removedData)
//                ]) { (error: Error?) in
//                    if let error = error {
//                        completion(error)
//                    } else {
//                        // Add the updated exercise to the array
//                        let addedData = try! usersExercise.map { try! Firestore.Encoder().encode($0) }
//                        self.db.collection(self.USER_DATA_COLLECTION)
//                            .document(currentUser.uid)
//                            .updateData([
//                                self.USER_EXERCISES: FieldValue.arrayUnion(addedData)
//                            ]) { (error: Error?) in
//                                completion(error)
//                            }
//                    }
//                }
//        } catch {
//            print("Error updating Firestore: \(error.localizedDescription)")
//            completion(error)
//        }
//    }
//}

//    init() {
//        auth.addStateDidChangeListener { auth, user in
//            if let user = user {
//                // A user is logged in
//                print("A user has been logged in \(user.email ?? "No Email")")
//
//                self.currentUser = user
//                self.startListeningToDb()
//
//            } else {
//                // A user has logged out. Clear all data
//                self.dbListener?.remove()
//                self.dbListener = nil
//                self.currentUserData = nil
//                self.currentUser = nil
//
//                print("A user has logged out")
//            }
//
//        }
//    }

