//
//  WaitingForRaceView.swift
//  RunnersHigh
//
//  Created by Josh Morrison on 6/16/21.
//

import SwiftUI

struct WaitingForRaceView: View {
    @ObservedObject var RaceVM: RaceListViewModel
    
    var body: some View {
        VStack{
            Text("Race starts in")
                .font(.caption)
            Text("\(RaceVM.raceCountdownSeconds)")
                .font(.largeTitle)
            Button("Cancel"){
                
            }
        }
    }
}

