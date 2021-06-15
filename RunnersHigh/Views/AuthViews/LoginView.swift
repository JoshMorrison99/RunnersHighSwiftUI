//
//  LoginView.swift
//  RunnersHigh
//
//  Created by Josh Morrison on 6/8/21.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var LoginVM = LoginViewModel()
    
    var body: some View {
        VStack{
            Text("Login")
            VStack{
                TextField("email", text: $LoginVM.email)
                Text(LoginVM.emailError)
                    .foregroundColor(.red)
                    .font(.subheadline)
            }
            VStack{
                SecureField("password", text: $LoginVM.password)
                Text(LoginVM.passwordError)
                    .foregroundColor(.red)
                    .font(.subheadline)
            }
            Button("Login"){
                LoginVM.Login(email: LoginVM.email, password: LoginVM.password)
            }
        }
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
