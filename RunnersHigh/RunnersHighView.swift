//
//  RunnersHighView.swift
//  RunnersHigh
//
//  Created by Josh Morrison on 6/10/21.
//

import SwiftUI

struct RunnersHighView: View {
    @EnvironmentObject var UserAuthState: UserViewModel
    var body: some View {
        if(UserAuthState.isUserAuthenticated == .undefined){
            Text("Loading...")
        }else if(UserAuthState.isUserAuthenticated == .signedIn){
            TabView{
                HomeView()
                    .tabItem{
                        Label("Home", systemImage: "house")
                    }
                RaceView()
                    .tabItem{
                        Label("Race", systemImage: "figure.walk")
                    }
                ProfileView()
                    .tabItem{
                        Label("Profile", systemImage: "person")
                    }
            }
        }else if(UserAuthState.isUserAuthenticated == .signedOut){
            WelcomeView().environmentObject(UserAuthState)
        }else{
            Text("Error")
        }
    }
}

struct RunnersHighView_Previews: PreviewProvider {
    static var previews: some View {
        RunnersHighView()
    }
}
