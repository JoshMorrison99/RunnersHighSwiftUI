//
//  UserViewModel.swift
//  RunnersHigh
//
//  Created by Josh Morrison on 6/8/21.
//

import Foundation
import SwiftUI
import FirebaseAuth

class UserViewModel:ObservableObject{
    private let AuthRepo: AuthRepositoryProtocol
    
    init(AuthRepo: AuthRepositoryProtocol = AuthRepository()){
        self.AuthRepo = AuthRepo
    }
    
    enum UserAuthState {
        case undefined, signedOut, signedIn
    }
    
    @Published var isUserAuthenticated:UserAuthState = .undefined
    @Published var user: UserModel = .init(username: "", email: "")
    
    var authStateDidChangeListenerHandle: AuthStateDidChangeListenerHandle?
    
    func configureFirebaseStateDidChange(){
        print("IS AUTHENTICATED \(self.isUserAuthenticated)")
        //try? Auth.auth().signOut() //USE THIS DURING DEBUGGING TO LOG OUT USER
        authStateDidChangeListenerHandle = Auth.auth().addStateDidChangeListener({ _, user in
            guard let user = user else {
                print("IS AUTHENTICATED \(self.isUserAuthenticated)")
                self.isUserAuthenticated = .signedOut
                print("IS AUTHENTICATED \(self.isUserAuthenticated)")
                return
            }
            print("IS AUTHENTICATED \(self.isUserAuthenticated)")
            self.isUserAuthenticated = .signedIn
            print("IS AUTHENTICATED \(self.isUserAuthenticated)")
            self.AuthRepo.GetUser(uid: user.uid) {(result) in
                switch result {
                    case .failure(let error):
                        print("Error Occurred \(error.localizedDescription)")
                    case .success(let user):
                        print("User logged in")
                        self.user = user
                        print(self.user.email)
                }
            }
        })
    }
}
