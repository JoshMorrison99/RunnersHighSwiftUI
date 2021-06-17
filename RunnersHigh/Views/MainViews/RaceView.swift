//
//  RaceView.swift
//  RunnersHigh
//
//  Created by Josh Morrison on 6/13/21.
//

import SwiftUI

struct RaceView: View {
    @ObservedObject var RaceVM: RaceListViewModel
    @ObservedObject var RunVM: RunViewModel
    @EnvironmentObject var UserVM: UserViewModel
    var body: some View {
        VStack{
            ScrollView{
                ForEach(RaceVM.raceList){ race in
                    RaceCard(raceVM: RaceVM, runVM: RunVM, race: race)
                }
            }.onAppear(){
                RaceVM.SetRaceList()
                print("Race list count is \(RaceVM.raceList.count)")
            }.onDisappear(){
                RaceVM.raceList = []
            }
            Button("Solo Run"){
                RunVM.RunState = .running
                RunVM.StartRun()
                RunVM.GetUserFromEnv(user: UserVM.user)
            }
            .frame(width: 100, height: 100)
            .foregroundColor(Color.black)
            .background(Color.red)
            .clipShape(Circle())
            .padding()
        }
        
    }
}
