//
//  WaitingForRaceView.swift
//  RunnersHigh
//
//  Created by Josh Morrison on 6/16/21.
//

import SwiftUI

struct WaitingForRaceView: View {
    @ObservedObject var RaceVM: RaceListViewModel
    @ObservedObject var RunVM: RunViewModel
    @EnvironmentObject var userVM: UserViewModel
    
    var body: some View {
        VStack{
            Text("Race starts in")
                .font(.caption)
            Text("\(RaceVM.minutesCoundown) minutes \(RaceVM.secondsCountdown) seconds")
                .font(.largeTitle)
            Button("Cancel"){
                RunVM.RunState = .notRunning
                RaceVM.CancelRaceButtonPressed(user: &userVM.user)
            }
        }
    }
}

