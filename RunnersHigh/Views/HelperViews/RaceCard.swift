//
//  RaceCard.swift
//  RunnersHigh
//
//  Created by Josh Morrison on 6/13/21.
//

import SwiftUI

struct RaceCard: View {
    let distance: Float
    let time: Date
    let competitors: Int
    
    var body: some View {
        ZStack{
            HStack{
                Text("\(distance)k")
                    .bold()
                    .font(.title)
                Spacer()
                Text(TypeFormatter.FormatDateToTimeOfDayAsString(date: time))
                    .bold()
                    .font(.title)
                Divider()
                VStack{
                    Text("\(competitors)")
                        .bold()
                        .font(.title)
                    Text("competitors")
                        .font(.caption)
                }
            }
        }.frame(height: 100)
         .padding()
        
    }
}

struct RaceCard_Previews: PreviewProvider {
    static var previews: some View {
        RaceCard()
    }
}
