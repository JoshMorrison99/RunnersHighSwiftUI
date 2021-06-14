//
//  RaceModel.swift
//  RunnersHigh
//
//  Created by Josh Morrison on 6/13/21.
//

import Foundation
import FirebaseFirestoreSwift

struct RaceModel: Identifiable, Encodable, Decodable {
    @DocumentID var id: String?
    let distance: Float
    var competitors: Int = 0
    let time: Date
}
