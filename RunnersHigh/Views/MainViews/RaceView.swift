//
//  RaceView.swift
//  RunnersHigh
//
//  Created by Josh Morrison on 6/13/21.
//

import SwiftUI

struct RaceView: View {
    var body: some View {
        RaceCard(distance: 5, time: Date(), competitors: 2)
    }
}

struct RaceView_Previews: PreviewProvider {
    static var previews: some View {
        RaceView()
    }
}
