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
    @Published var secondsTimer: Int = 0
    let locationManagerObject = CLLocationManager()
    private var locationList: [CLLocation] = []
    @Published var distance = Measurement(value: 0, unit: UnitLength.meters)
    private var timer: Timer?
    @Published var place: Int = 1
    private var distanceIncrementer: Int = 0
    var previousSeconds:Int = 0
    
    @Published var currentRun = RunModel(id: 0, timeInSeconds: 0, distanceInMeters: 0)
    
    var currentUser:UserModel?
    
    @objc func StartRun(){
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true){ _ in
            self.eachSecond()
        }
        locationManagerObject.delegate = self
        locationManagerObject.startUpdatingLocation()
        locationManagerObject.activityType = .fitness
        locationManagerObject.distanceFilter = 10
        
        currentRun.startTime = Date()
    }
    
    func GetUserFromEnv(user: UserModel){
        currentUser = user
    }
    
    func EndRun(){
        locationManagerObject.stopUpdatingLocation()
        timer?.invalidate()
    }
    
    func SaveRun(user: inout UserModel){
        currentRun.id = user.runs.count + 1
        currentRun.distanceInMeters = Float(distance.value)
        currentRun.endTime = Date()
        currentRun.timeInSeconds = secondsTimer
        
        user.runs.append(currentRun)
        runRepo.SaveRun(user: user) { (result) in
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
//        if(distanceIncrementer == 1){
//            currentUser!.runs.append(currentRun)
//        }
//
//        currentUser!.runs[currentUser!.runs.count - 1].distanceTimes.append(secondsTimer - previousSeconds)
//        runRepo.SaveRun(user: currentUser!) {(result) in
//            switch result {
//            case .success(_):
//                print("Success saving kilometer milestone")
//            case .failure(_):
//                print("Failure saving kilometer milestone")
//            }
//        }
//        previousSeconds = secondsTimer
    }
    
    enum RunStates {
        case running
        case notRunning
        case waitingForRace
    }
    
    @Published var RunState: RunStates = .notRunning
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
