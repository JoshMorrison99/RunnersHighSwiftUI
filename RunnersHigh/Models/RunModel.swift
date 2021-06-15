//
//  RunModel.swift
//  RunnersHigh
//
//  Created by Josh Morrison on 6/15/21.
//

import Foundation

struct RunModel: Identifiable, Encodable, Decodable {
    var id: Int
    var avgPace: Float
    var distance: Float
    var startTime: Date
    var endTime: Date
}
