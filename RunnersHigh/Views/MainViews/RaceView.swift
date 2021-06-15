//
//  RaceView.swift
//  RunnersHigh
//
//  Created by Josh Morrison on 6/13/21.
//

import SwiftUI

struct RaceView: View {
    @ObservedObject var RaceVM: RaceListViewModel
    var body: some View {
        VStack{
            ScrollView{
                ForEach(RaceVM.raceList){ race in
                    RaceCard(raceVM: RaceVM, race: race)
                }
            }.onAppear(){
                RaceVM.SetRaceList()
                print("Race list count is \(RaceVM.raceList.count)")
            }
            Button("Solo"){
                
            }
        }
        
    }
}
