//
//  RaceListViewModel.swift
//  RunnersHigh
//
//  Created by Josh Morrison on 6/14/21.
//

import Foundation
import SwiftUI
import FirebaseAuth

class RaceListViewModel: NSObject, ObservableObject {
    private var RaceRepo = RaceRepository()
    @Published var raceList: [RaceModel] = []
    @Published var raceCountdownSeconds: Int = 0
    @Published var raceCountdownTimer: Timer?
    @Published var raceCountdownTimerDisplay: Timer?
    
    var currentRace: RaceModel?
    
    @Published var minutesCoundown: Int = 0
    @Published var secondsCountdown: Int = 0

    func SetRaceList(){
        SetRaceList5k()
        SetRaceList10k()
    }
    
    func SetRaceList5k(){
        var raceID: String
        let raceIDTime = TypeFormatter.FormatDateToTimeOfDayAsStringToStoreInModel(date: Date())
        raceID = raceIDTime + " 5k"
        
        
        RaceRepo.GetRace(RaceID: raceID){ (result) in
            switch result{
            case .success(let raceInfo):
                let race = RaceModel(id: raceInfo.id, distance: raceInfo.distance, competitors: raceInfo.competitors, time: raceInfo.time)
                self.raceList.append(race)
            case .failure(_):
                let calendar = Calendar.current
                var hour = calendar.component(.hour, from: Date())
                hour += 1
                let date = calendar.date(bySettingHour: hour, minute: 0, second: 0, of: Date())
                let race = RaceModel(id: raceID, distance: 5, competitors: [], time: date!)
                self.RaceRepo.AddRace(race: race)
                self.raceList.append(race)
            }
        }
    }
    
    func SetRaceList10k(){
        var raceID: String
        let raceIDTime = TypeFormatter.FormatDateToTimeOfDayAsStringToStoreInModel(date: Date())
        raceID = raceIDTime + " 10k"
        
        RaceRepo.GetRace(RaceID: raceID){ (result) in
            switch result{
            case .success(let raceInfo):
                let race = RaceModel(id: raceInfo.id, distance: raceInfo.distance, competitors: raceInfo.competitors, time: raceInfo.time)
                self.raceList.append(race)
            case .failure(_):
                let calendar = Calendar.current
                var hour = calendar.component(.hour, from: Date())
                hour += 1
                let date = calendar.date(bySettingHour: hour, minute: 0, second: 0, of: Date())
                let race = RaceModel(id: raceID, distance: 10, competitors: [], time: date!)
                self.RaceRepo.AddRace(race: race)
                self.raceList.append(race)
            }
        }
    }
    
    func RaceCardClicked(raceClicked: RaceModel, user: UserModel, runVM: RunViewModel){
        var i = 0
        for race in raceList {
            if(raceClicked.id == race.id){
                for competitor in race.competitors {
                    if(competitor.id == user.id){
                        print("User already signed up")
                        return
                    }
                }
                raceList[i].competitors.append(user)
                RaceRepo.UpdateCompetitorRaceList(user: user, race: raceList[i]){ (result) in
                    switch result {
                    case .success(_):
                        print("Success")
                        runVM.RunState = .waitingForRace
                        self.InitializeWaitingForRaceToStart(race: raceClicked, runVM: runVM)
                        self.currentRace = raceClicked
                    case .failure(_):
                        print("Failure")
                    }
                }
            }
            i += 1
        }
    }
    
    func InitializeWaitingForRaceToStart(race: RaceModel, runVM: RunViewModel){
        raceCountdownTimer = Timer.init(fireAt: race.time, interval: 0, target: runVM, selector: #selector(runVM.StartRun), userInfo: nil, repeats: false)
        RunLoop.main.add(raceCountdownTimer!, forMode: RunLoop.Mode.common)
        let fireDate = raceCountdownTimer!.fireDate
        raceCountdownSeconds = Int(Date().timeIntervalSince(fireDate))
        raceCountdownSeconds = abs(raceCountdownSeconds)
        
        (self.minutesCoundown, self.secondsCountdown) = TypeFormatter.secondsToMinutesSeconds(seconds: self.raceCountdownSeconds)
        raceCountdownTimerDisplay = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true){ _ in
            self.raceCountdownSeconds -= 1
            (self.minutesCoundown, self.secondsCountdown) = TypeFormatter.secondsToMinutesSeconds(seconds: self.raceCountdownSeconds)
        }
    }
    
    func CancelRaceButtonPressed(user: inout UserModel, run: RunViewModel){
        run.currentRace = nil
        
        raceCountdownTimer?.invalidate()
        raceCountdownTimerDisplay?.invalidate()
        var i = 0
        for competitor in currentRace!.competitors {
            if(competitor.id == user.id){
                currentRace!.competitors.remove(at: i)
            }
            i += 1
        }
        
        RaceRepo.UpdateCompetitorRaceList(user: user, race: currentRace!){ (result) in
            switch result {
                case .success(_):
                    print("success removing user from race")
                    self.currentRace = nil
                case .failure(_):
                    print("failed to remove user from race")
                }
        }
    }
    
    
}
