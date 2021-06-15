//
//  RunView.swift
//  RunnersHigh
//
//  Created by Josh Morrison on 6/15/21.
//

import SwiftUI

struct RunView: View {
    @ObservedObject var RunVM: RunViewModel
    
    var body: some View {
        VStack{
            HStack{
                VStack{
                    Text("8'01")
                    Text("Avg Pace")
                        .font(.caption)
                }
                VStack{
                    Text("\(RunVM.secondsTimer)")
                    Text("Time")
                        .font(.caption)
                }
            }
            VStack{
                Text("2.95")
                    .font(.largeTitle)
                Text("Kilometers")
            }
            Button("End"){
                RunVM.RunState = .notRunning
            }.frame(width: 100, height: 100)
            .foregroundColor(Color.black)
            .background(Color.red)
            .clipShape(Circle())
            .padding()
        }
    }
}
