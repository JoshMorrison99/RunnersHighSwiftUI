//
//  RunnersHighApp.swift
//  RunnersHigh
//
//  Created by Josh Morrison on 6/5/21.
//

import SwiftUI
import Firebase

@main
struct RunnersHighApp: App {
    
    init(){
        setupAuthentication()
    }
    
    var UserAuthState = UserViewModel()
    
    var body: some Scene {
        WindowGroup {
            RunnersHighView().environmentObject(UserAuthState).onAppear(){UserAuthState.configureFirebaseStateDidChange()}
        }
    }
}

extension RunnersHighApp {
    private func setupAuthentication(){
        FirebaseApp.configure()
    }
}
