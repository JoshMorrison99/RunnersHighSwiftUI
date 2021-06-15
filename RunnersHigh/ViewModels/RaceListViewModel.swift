//
//  RaceListViewModel.swift
//  RunnersHigh
//
//  Created by Josh Morrison on 6/14/21.
//

import Foundation
import SwiftUI
import FirebaseAuth

class RaceListViewModel: ObservableObject {
    private var RaceRepo = RaceRepository()
    @Published var raceList: [RaceModel] = []
    
    func SetRaceList(){
        SetRaceList5k()
        SetRaceList10k()
    }
    
    func SetRaceList5k(){
        var raceID: String
        let raceIDTime = TypeFormatter.FormatDateToTimeOfDayAsStringToStoreInModel(date: Date())
        raceID = raceIDTime + " 5k"
        let race = RaceModel(id: raceID, distance: 5, competitorsAmount: 0, time: Date())
        raceList.append(race)
    }
    
    func SetRaceList10k(){
        var raceID: String
        let raceIDTime = TypeFormatter.FormatDateToTimeOfDayAsStringToStoreInModel(date: Date())
        raceID = raceIDTime + " 10k"
        let race = RaceModel(id: raceID, distance: 10, competitorsAmount: 0, time: Date())
        raceList.append(race)
    }
    
    func RaceCardClicked(raceClicked: RaceModel, user: UserModel){
        var i = 0
        for race in raceList {
            if(raceClicked.id == race.id){
                raceList[i].competitors.append(user)
                raceList[i].competitorsAmount += 1
                RaceRepo.AddCompetitorToRace(user: user, race: raceList[i]){ (result) in
                    switch result {
                    case .success(_):
                        print("Success")
                    case .failure(_):
                        print("Failure")
                    }
                }
            }
            i += 1
        }
    }
}
