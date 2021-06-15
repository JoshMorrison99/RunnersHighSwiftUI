//
//  UserModel.swift
//  RunnersHigh
//
//  Created by Josh Morrison on 6/10/21.
//

import Foundation
import FirebaseFirestoreSwift

struct UserModel: Identifiable, Encodable, Decodable {
    @DocumentID var documentID: String?
    var id: String?
    let username: String
    let email: String
    var runs: [RunModel] = []
}
