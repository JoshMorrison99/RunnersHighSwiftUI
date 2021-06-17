//
//  RunModel.swift
//  RunnersHigh
//
//  Created by Josh Morrison on 6/15/21.
//

import Foundation

struct RunModel: Identifiable, Encodable, Decodable {
    var id: Int
    var timeInSeconds: Int
    var distanceInMeters: Float
    var startTime: Date?
    var endTime: Date?
    var distanceTimes: [Int] = [] // each index is the time per kilometer
}
