//
//  RunViewModel.swift
//  RunnersHigh
//
//  Created by Josh Morrison on 6/15/21.
//

import Foundation
import SwiftUI

class RunViewModel: ObservableObject {
    
    @Published var secondsTimer: Int = 0
    
    init(){
        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true){ _ in
            self.eachSecond() }
    }
    // Timer doesn't conform to codable, so it needs to be in the VM
    
    
    func eachSecond(){
        self.secondsTimer += 1
    }
    
    enum RunStates {
        case running
        case notRunning
    }
    
    @Published var RunState: RunStates = .notRunning
}
