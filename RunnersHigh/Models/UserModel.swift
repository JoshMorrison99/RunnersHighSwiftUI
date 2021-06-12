//
//  UserModel.swift
//  RunnersHigh
//
//  Created by Josh Morrison on 6/10/21.
//

import Foundation
import FirebaseFirestoreSwift

struct UserModel: Identifiable, Encodable {
    @DocumentID var id: String? = UUID().uuidString
    let username: String
    let email: String
}
