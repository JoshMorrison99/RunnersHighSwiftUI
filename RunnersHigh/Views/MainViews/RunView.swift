//
//  RunView.swift
//  RunnersHigh
//
//  Created by Josh Morrison on 6/15/21.
//

import SwiftUI

struct RunView: View {
    @ObservedObject var RunVM: RunViewModel
    @EnvironmentObject var UserVM: UserViewModel
    
    var body: some View {
        VStack{
            HStack{
                VStack{
                    Text(TypeFormatter.FormatePaceInMinutesPerKilometer(distance: RunVM.distance, seconds: RunVM.secondsTimer, outputUnit: UnitSpeed.minutesPerKilometer))
                    Text("Avg Pace")
                        .font(.caption)
                }
                VStack{
                    Text("\(RunVM.place)")
                    Text("Place")
                        .font(.caption)
                }
                VStack{
                    Text("\(RunVM.secondsTimer)")
                    Text("Time")
                        .font(.caption)
                }
            }
            VStack{
                Text("\(TypeFormatter.FormatMeasurementAsKilometers(distance: RunVM.distance))")
                    .font(.largeTitle)
                Text("Kilometers")
            }
            Button("End"){
                RunVM.RunState = .notRunning
                RunVM.EndRun()
                RunVM.SaveRun(user: &UserVM.user)
            }.frame(width: 100, height: 100)
            .foregroundColor(Color.black)
            .background(Color.red)
            .clipShape(Circle())
            .padding()
        }
    }
}
