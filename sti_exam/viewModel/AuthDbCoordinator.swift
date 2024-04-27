////
////  AuthDbCoordinator.swift
////  sti_exam
////
////  Created by Andreas Antonsson on 2024-04-26.
////
//
//import Foundation
//
//class AuthDbCoordinator {
//    private let testAuth: TestAuth
//    private let testDb: TestDb
//
//    init(testAuth: TestAuth, testDb: TestDb) {
//        self.testAuth = testAuth
//        self.testDb = testDb
//
//        initializeAuthListener()
//    }
//
//    private func initializeAuthListener() {
//        testAuth.auth.addStateDidChangeListener { auth, user in
//            if let user = user {
//                print("A user has been logged in \(user.email ?? "No Email")")
//                self.testAuth.currentUser = user
//                self.testDb.startListeningToDb()
//
//            } else {
//                self.testDb.dbListener?.remove()
//                self.testDb.dbListener = nil
//                self.testDb.currentUserData = nil
//                self.testAuth.currentUser = nil
//                print("A user has logged out")
//            }
//        }
//    }
//}
