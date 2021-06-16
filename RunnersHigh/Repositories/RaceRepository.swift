//
//  RaceRepository.swift
//  RunnersHigh
//
//  Created by Josh Morrison on 6/14/21.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class RaceRepository {
    
    enum MyError: Error{
        case noDocument
        case errorAddingCompetitor
    }
    
    func GetRace(RaceID: String?, completion: @escaping (Result<RaceModel, Error>) -> Void){
        print("GetRaceInformation")
        let ref = Firestore.firestore().collection(FBKeys.FBCollections.races).document(RaceID!)
        ref.getDocument { (document, error) in
            if let document = document, document.exists {
                let race = try? document.data(as: RaceModel.self)
                completion(.success(race!))
            }else{
                completion(.failure(MyError.noDocument))
            }
        }
    }
    
    func AddCompetitorToRace(user: UserModel, race: RaceModel, completion: @escaping (Result<String, Error>) -> Void){
        print("AddCompetitorToRace")
        
        let ref: ()? = try? Firestore.firestore().collection(FBKeys.FBCollections.races).document(race.id!).setData(from: race)
        print(ref)
        if ref != nil {
            completion(.success("Success"))
        }else{
            completion(.failure(MyError.errorAddingCompetitor))
        }
    }
    
    func AddRace(race: RaceModel){
        try? Firestore.firestore().collection(FBKeys.FBCollections.races).document(race.id!).setData(from: race)
    }
    
    
}
