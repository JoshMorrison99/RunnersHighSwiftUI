//
//  SignUpViewModel.swift
//  RunnersHigh
//
//  Created by Josh Morrison on 6/8/21.
//

import Foundation
import SwiftUI
import FirebaseAuth

class SignUpViewModel: ObservableObject{
    
    @Published var AuthRepo = AuthRepository()
    
    @Published var usernameError = ""
    @Published var emailError = ""
    @Published var passwordError = ""
    
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    @Published var rePassword = ""
    
    func SignUp(email: String, password: String){
        print(email)
        print(password)
        
        let newUser = UserModel(username: username, email: email)
        
        if(!ValidationChecker.isUsernameValid(username: username)){
            usernameError = "Must be at least 6 characters."
        }else{
            usernameError = ""
        }
        
        if(!ValidationChecker.isEmailValid(email: email)){
            emailError = "Enter a valid email address."
        }else{
            emailError = ""
        }
        
        if(!ValidationChecker.isPasswordMatch(password: password, rePassword: rePassword)){
            passwordError = "Password fields do not match."
        }else if(!ValidationChecker.isPasswordValid(password: password)){
            passwordError = "Must be 8 characters containing at least one number and one Capital letter."
        }else{
            passwordError = ""
        }
        
        if(usernameError == "" && emailError == "" && passwordError == ""){
            AuthRepo.CreateUser(newUser, password: password) { (result) in
                switch result {
                    case .failure(let error):
                        guard let errCode = AuthErrorCode(rawValue: error._code) else {return}
                        switch errCode {
                            case .emailAlreadyInUse:
                                self.emailError = "Email is already in use."
                            default:
                                print("default")
                        }
                        print("error \(error.localizedDescription)")
                    case .success(_):
                        print("Account Created")
                }
            }
        }
        
    }
}
