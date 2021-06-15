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
    func CreateUser(username: String, email: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void)
    func GetUser(uid: String?, completion: @escaping (Result<UserModel, Error>) -> Void)
    func AddUser(uid: String, username: String, email: String, completion: @escaping (Result<Bool, Error>) -> Void)
}


class AuthRepository: AuthRepositoryProtocol {
    
    func AddUser(uid: String, username: String, email: String, completion: @escaping (Result<Bool, Error>) -> Void){
        print("ENTER")
        let newUser = UserModel(id: uid, username: username, email: email)
        let ref = Firestore.firestore().collection(FBKeys.FBCollections.users).document(newUser.id!)
        do{
            try ref.setData(from: newUser, merge: true){ (err) in
                if let err = err {
                    print("error occurred \(err.localizedDescription)")
                    completion(.failure(err))
                    return
                }
            }
        }catch{
            
        }
        
        completion(.success(true))
        
    }
    
    func CreateUser(username: String, email: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void){
        do{
            Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
                if let error = error {
                    print("error occurred \(error)")
                    completion(.failure(error))
                    return
                }
                
                guard let _ = authResult?.user else {
                    completion(.failure(error!))
                    return
                }
                print("authResult?.user.uid --> \(authResult?.user.uid)")
                self.AddUser(uid: (authResult?.user.uid)!, username: username, email: email) { (result) in
                    
                }
            }
        
        }catch{
            completion(.failure(error))
        }
    }
    
    
    
    func GetUser(uid: String?, completion: @escaping (Result<UserModel, Error>) -> Void){
        let ref = Firestore.firestore().collection(FBKeys.FBCollections.users).document(uid!)
        ref.getDocument { (document, error) in
            if let document = document, document.exists {
                print("Successfully got User")
                let user = try? document.data(as: UserModel.self)
                completion(.success(user!))
            }else{
                print("User id of \(uid) could not be found")
                print("Error Occurred \(error?.localizedDescription)")
                completion(.failure(error as! Error))
            }
        }
    }
}
