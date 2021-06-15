//
//  RunnersHighView.swift
//  RunnersHigh
//
//  Created by Josh Morrison on 6/10/21.
//

import SwiftUI

struct RunnersHighView: View {
    @EnvironmentObject var UserAuthState: UserViewModel
    @ObservedObject var RaceVM: RaceListViewModel
    var body: some View {
        if(UserAuthState.isUserAuthenticated == .undefined){
            Text("Loading...")
        }else if(UserAuthState.isUserAuthenticated == .signedIn){
            TabView{
                HomeView().environmentObject(UserAuthState)
                    .tabItem{
                        Label("Home", systemImage: "house")
                    }
                RaceView(RaceVM: RaceVM).environmentObject(UserAuthState)
                    .tabItem{
                        Label("Race", systemImage: "figure.walk")
                    }
                ProfileView().environmentObject(UserAuthState)
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
