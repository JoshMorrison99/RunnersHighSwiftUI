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

protocol AuthRepositoryProtocol {
    func CreateUser(_ userModel: UserModel, password: String, completion: @escaping (Result<Bool, Error>) -> Void)
    func GetUser(uid: String?, completion: @escaping (Result<UserModel, Error>) -> Void)
}

class AuthRepository: AuthRepositoryProtocol {
    
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
            let ref = Firestore.firestore().collection(FBKeys.FBCollections.users).document(userModel.id!)
            try ref.setData(from: userModel, merge: true){ (err) in
                if let err = err {
                    print("error occurred \(err.localizedDescription)")
                    completion(.failure(err))
                    return
                }
            }
            completion(.success(true))
        }catch{
            completion(.failure(error))
            fatalError("error occured \(error.localizedDescription)")
        }
    }
    
    func GetUser(uid: String?, completion: @escaping (Result<UserModel, Error>) -> Void){
        let ref = Firestore.firestore().collection(FBKeys.FBCollections.users).document(uid!)
        ref.getDocument { (document, error) in
            if let document = document, document.exists {
                let user = try? document.data(as: UserModel.self)
                completion(.success(user!))
            }
        }
    }
}
