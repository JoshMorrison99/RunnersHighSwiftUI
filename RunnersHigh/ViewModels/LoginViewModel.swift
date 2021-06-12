//
//  LoginViewModel.swift
//  RunnersHigh
//
//  Created by Josh Morrison on 6/8/21.
//

import Foundation
import SwiftUI
import FirebaseAuth

class LoginViewModel: ObservableObject{
    
    @Published var emailError = ""
    @Published var passwordError = ""
    @Published var email = ""
    @Published var password = ""
    
    func Login(email: String, password: String){
        print(email)
        print(password)
    }
}
