//
//  SignUpView.swift
//  RunnersHigh
//
//  Created by Josh Morrison on 6/8/21.
//

import SwiftUI

struct SignUpView: View {
    @ObservedObject var SignUpVM = SignUpViewModel()
    
    var body: some View {
        VStack{
            Text("Signup")
            VStack{
                TextField("username", text: $SignUpVM.username)
                Text(SignUpVM.usernameError)
                    .foregroundColor(.red)
                    .font(.subheadline)
            }
            VStack{
                TextField("email", text: $SignUpVM.email)
                Text(SignUpVM.emailError)
                    .foregroundColor(.red)
                    .font(.subheadline)
            }
            VStack{
                SecureField("password", text: $SignUpVM.password)
                Text(SignUpVM.passwordError)
                    .foregroundColor(.red)
                    .font(.subheadline)
            }
            SecureField("re-enter password", text: $SignUpVM.rePassword)
            Button("Signup"){
                SignUpVM.SignUp(email: SignUpVM.email, password: SignUpVM.password)
            }
        }
        
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
