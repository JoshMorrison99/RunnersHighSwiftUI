//
//  RaceCard.swift
//  RunnersHigh
//
//  Created by Josh Morrison on 6/13/21.
//

import SwiftUI

struct RaceCard: View {
    @ObservedObject var raceVM: RaceListViewModel
    @EnvironmentObject var userVM: UserViewModel
    @ObservedObject var runVM: RunViewModel
//    let raceID: String?
//    let distance: Float
//    let competitorAmount: Int
//    let time: String
    var race: RaceModel
    
    var body: some View {
        ZStack{
            HStack{
                Text("\(Int(race.distance))km")
                    .font(.title)
                Spacer()
                Text(TypeFormatter.FormatDateToTimeOfDayAsString(date: race.time))
                    .font(.title)
                Divider()
                VStack{
                    Text("\(race.competitors.count)")
                        .bold()
                        .font(.title)
                    Text("competitors")
                        .font(.caption)
                }
            }
        }.frame(height: 100)
        .padding(.horizontal, 20)
        .onTapGesture {
            raceVM.RaceCardClicked(raceClicked: race, user: userVM.user, runVM: runVM)
            runVM.GetRaceFromEnv(race: race, user: &userVM.user)
        }
    }
}

