//
//  RunViewModel.swift
//  RunnersHigh
//
//  Created by Josh Morrison on 6/15/21.
//

import Foundation
import SwiftUI
import CoreLocation

class RunViewModel: NSObject, ObservableObject {
    
    
    var runRepo = RunRepository()
    var raceRepo = RaceRepository()
    @Published var secondsTimer: Int = 0
    let locationManagerObject = CLLocationManager()
    private var locationList: [CLLocation] = []
    @Published var distance = Measurement(value: 0, unit: UnitLength.meters)
    private var timer: Timer?
    @Published var place: Int = 1
    private var distanceIncrementer: Int = 0
    var previousSeconds:Int = 0
    
    var currentRace: RaceModel?
    
    @Published var currentRun = RunModel(id: 0, timeInSeconds: 0, distanceInMeters: 0)
    @Published var RunState: RunStates = .notRunning
    
    var currentUser:UserModel?
    
    @objc func StartRun(){
        RunState = .running
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true){ _ in
            self.eachSecond()
        }
        locationManagerObject.delegate = self
        locationManagerObject.startUpdatingLocation()
        locationManagerObject.activityType = .fitness
        locationManagerObject.distanceFilter = 10
        
        currentRun.startTime = Date()
        currentUser?.runs.append(currentRun)
    }
    
    func GetUserFromEnv(user: inout UserModel){
        currentUser = user
    }
    
    func GetRaceFromEnv(race: RaceModel, user: inout UserModel){
        currentRace = race
        currentUser = user
    }
    
    func EndRun(){
        locationManagerObject.stopUpdatingLocation()
        timer?.invalidate()
    }
    
    func SaveRun(){
        currentUser!.runs[currentUser!.runs.count - 1].id = currentUser!.runs.count
        currentUser!.runs[currentUser!.runs.count - 1].distanceInMeters = Float(distance.value)
        currentUser!.runs[currentUser!.runs.count - 1].endTime = Date()
        currentUser!.runs[currentUser!.runs.count - 1].timeInSeconds = secondsTimer
        currentUser!.runs[currentUser!.runs.count - 1].distanceTimes.append(secondsTimer - previousSeconds)
        
        runRepo.SaveRun(user: currentUser!) { (result) in
            switch result{
            case .success(_):
                print("success saving run")
            case .failure(_):
                print("failed saving run")
            }
            
        }
    }
    
    func eachSecond(){
        self.secondsTimer += 1
        if(Int(Int(floor(self.distance.value)) / 1000) == distanceIncrementer+1 && self.distance.value != 0){
            eachKilometer()
        }
    }
    
    func eachKilometer(){
        print("KILOMETER!!!")
        distanceIncrementer += 1
        
        // Add the time to the array of times and save
        currentUser!.runs[currentUser!.runs.count - 1].distanceTimes.append(secondsTimer - previousSeconds)
        runRepo.SaveRun(user: currentUser!) {(result) in
            switch result {
            case .success(_):
                print("Success saving kilometer milestone")
            case .failure(_):
                print("Failure saving kilometer milestone")
            }
        }
        
        if(currentRace != nil){
            CalculateRacePlacement()
        }
        
        previousSeconds = secondsTimer
    }
    
    func CalculateRacePlacement(){
        
        // GET UPDATED COMPETITORS
        raceRepo.GetRace(RaceID: currentRace!.id){ (result) in
            switch result {
                case .success(let race):
                    self.currentRace = race
                    
                    // UPDATE SINGLE COMPETITOR
                    for i in 0..<(self.currentRace?.competitors.count)! {
                        if((self.currentRace?.competitors[i].id)! == self.currentUser!.id){
                            self.currentRace?.competitors[i] = self.currentUser!
                        }
                    }
                    
                    // SORT UPDATED COMPETITORS
                    self.currentRace!.competitors.sort{ $0.runs[$0.runs.count - 1].distanceTimes.count > $1.runs[$1.runs.count - 1].distanceTimes.count}
                    
                    // UPDATE ALL COMPETITORS
                    self.raceRepo.UpdateCompetitorRaceList(user: self.currentUser!, race: self.currentRace!){(result) in
                        switch result {
                        case .success(_):
                            print("success updating competitors")
                        case .failure(_):
                            print("failure updating competitors")
                        }
                    }
                case .failure(_):
                    print("failure")
            }
        }
    }
    
    enum RunStates {
        case running
        case notRunning
        case waitingForRace
    }
    
    
}

extension RunViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for newLocation in locations {
          let howRecent = newLocation.timestamp.timeIntervalSinceNow
          guard newLocation.horizontalAccuracy < 20 && abs(howRecent) < 10 else { continue }

          if let lastLocation = locationList.last {
            let delta = newLocation.distance(from: lastLocation)
            distance = distance + Measurement(value: delta, unit: UnitLength.meters)
          }

          locationList.append(newLocation)
        }
      }
}
