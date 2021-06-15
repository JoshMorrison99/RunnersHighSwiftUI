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
        FirebaseApp.configure()
    }
    
    var UserAuthState = UserViewModel()
    var RaceVM = RaceListViewModel()
    var RunVM = RunViewModel()
    var body: some Scene {
        WindowGroup {
            RunnersHighView(RunVM: RunVM, RaceVM: RaceVM).environmentObject(UserAuthState).onAppear(){UserAuthState.configureFirebaseStateDidChange()}
        }
    }
}
