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
    
    func GetRace(RaceID: String?, completion: @escaping (Result<RaceModel, Error>) -> Void){
        print("GetRaceInformation")
        let ref = Firestore.firestore().collection(FBKeys.FBCollections.races).document(RaceID!)
        ref.getDocument { (document, error) in
            if let document = document, document.exists {
                let race = try? document.data(as: RaceModel.self)
                completion(.success(race!))
            }else{
                completion(.failure(error!))
            }
        }
    }
    
    func AddCompetitorToRace(user: UserModel, race: RaceModel, completion: @escaping (Result<String, Error>) -> Void){
        print("AddCompetitorToRace")
        print(user.id!)
        print(race.id)
        print(race.id)
        try? Firestore.firestore().collection(FBKeys.FBCollections.races).document(race.id!).setData(from: race)
    }
}
