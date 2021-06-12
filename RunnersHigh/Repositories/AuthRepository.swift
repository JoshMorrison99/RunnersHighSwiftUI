//
//  AuthRepository.swift
//  RunnersHigh
//
//  Created by Josh Morrison on 6/11/21.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class AuthRepository: ObservableObject {
    
    let db = Firestore.firestore()
    
    func CreateUser(_ userModel: UserModel, password: String, completion: @escaping (Result<Bool, Error>) -> Void){
        do{
            Auth.auth().createUser(withEmail: userModel.email, password: password) { (authResult, error) in
                if let error = error {
                    print("error occurred \(error)")
                    completion(.failure(error))
                    return
                }
                
                guard let _ = authResult?.user else {
                    completion(.failure(error!))
                    return
                }
            }
            _ = try db.collection(FBKeys.FBCollections.users).addDocument(from: userModel)
            completion(.success(true))
        }catch{
            completion(.failure(error))
            fatalError("error occured \(error.localizedDescription)")
        }
        
    }
}
