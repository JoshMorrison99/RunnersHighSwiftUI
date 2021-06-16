//
//  RunRepository.swift
//  RunnersHigh
//
//  Created by Josh Morrison on 6/16/21.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class RunRepository {
    
    enum RunErrors: Error{
        case errorSaving
    }
    
    func SaveRun(user: UserModel, completion: @escaping (Result<RunModel, Error>) -> Void){
        try? Firestore.firestore().collection(FBKeys.FBCollections.users).document(user.documentID!).setData(from: user)
    }
}
