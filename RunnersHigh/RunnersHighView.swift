//
//  RunnersHighView.swift
//  RunnersHigh
//
//  Created by Josh Morrison on 6/10/21.
//

import SwiftUI

struct RunnersHighView: View {
    @ObservedObject var RunVM: RunViewModel
    @EnvironmentObject var UserAuthState: UserViewModel
    @ObservedObject var RaceVM: RaceListViewModel
    var body: some View {
        if(UserAuthState.isUserAuthenticated == .undefined){
            Text("Loading...")
        }else if(UserAuthState.isUserAuthenticated == .signedIn){
            if(RunVM.RunState == .notRunning){
                TabView{
                    HomeView().environmentObject(UserAuthState)
                        .tabItem{
                            Label("Home", systemImage: "house")
                        }
                    RaceView(RaceVM: RaceVM, RunVM: RunVM).environmentObject(UserAuthState)
                        .tabItem{
                            Label("Race", systemImage: "figure.walk")
                        }
                    ProfileView().environmentObject(UserAuthState)
                        .tabItem{
                            Label("Profile", systemImage: "person")
                        }
                }
            }else if(RunVM.RunState == .running){
                RunView(RunVM: RunVM)
            }else if(RunVM.RunState == .waitingForRace){
                WaitingForRaceView(RaceVM: RaceVM, RunVM: RunVM)
            }
            
        }else if(UserAuthState.isUserAuthenticated == .signedOut){
            WelcomeView().environmentObject(UserAuthState)
        }else{
            Text("Error")
        }
    }
}


