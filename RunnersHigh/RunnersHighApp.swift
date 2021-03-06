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
    var RunVM = RunViewModel()
    var RaceVM = RaceListViewModel()
    var body: some Scene {
        WindowGroup {
            RunnersHighView(RunVM: RunVM, RaceVM: RaceVM).environmentObject(UserAuthState).onAppear(){
                UserAuthState.configureFirebaseStateDidChange()
                RunVM.locationManagerObject.requestWhenInUseAuthorization()
            }
        }
    }
}
