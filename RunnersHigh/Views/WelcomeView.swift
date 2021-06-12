//
//  ContentView.swift
//  RunnersHigh
//
//  Created by Josh Morrison on 6/5/21.
//

import SwiftUI

struct WelcomeView: View {
    
    var body: some View {
        NavigationView{
            VStack{
                Spacer()
                Text("Competition")
                    .padding()
                NavigationLink(
                    destination: SignUpView(),
                    label: {
                        Text("Signup")
                    })
                Spacer()
                HStack{
                    Text("Already have an account?")
                    NavigationLink(
                        destination: LoginView(),
                        label: {
                            Text("Login")
                        })
                    Spacer()
                }
            }
        }
        
        
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
