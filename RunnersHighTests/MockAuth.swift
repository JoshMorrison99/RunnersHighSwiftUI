//
//  MockAuth.swift
//  RunnersHighTests
//
//  Created by Josh Morrison on 6/12/21.
//

import Foundation
@testable import RunnersHigh

final class MockAuth: AuthRepositoryProtocol {
    func CreateUser(_ userModel: UserModel, password: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        completion(.success(true))
    }
    
    func GetUser(uid: String?, completion: @escaping (Result<UserModel, Error>) -> Void) {
        let newUser = UserModel(username: "josh", email: "josh@gmail.com")
        completion(.success(newUser))
    }
    
    
}
