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
    
    @Published var currentRun = RunModel(id: 0, timeInSeconds: 0, distanceInMeters: 0)
    
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
