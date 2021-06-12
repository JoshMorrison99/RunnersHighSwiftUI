//
//  UserViewModel.swift
//  RunnersHigh
//
//  Created by Josh Morrison on 6/8/21.
//

import Foundation
import SwiftUI

class UserViewModel:ObservableObject{
    enum UserAuthState {
        case undefined, signedOut, signedIn
    }
    
    @Published var isUserAuthenticated:UserAuthState = .undefined
    
    func configureFirebaseStateDidChange(){
        self.isUserAuthenticated = .signedOut
    }
}
