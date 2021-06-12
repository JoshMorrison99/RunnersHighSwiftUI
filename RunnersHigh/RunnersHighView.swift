//
//  RunnersHighView.swift
//  RunnersHigh
//
//  Created by Josh Morrison on 6/10/21.
//

import SwiftUI

struct RunnersHighView: View {
    @EnvironmentObject var UserAuthState: UserViewModel
    var body: some View {
        if(UserAuthState.isUserAuthenticated == .undefined){
            Text("Loading...").onAppear(){UserAuthState.configureFirebaseStateDidChange()}
        }else if(UserAuthState.isUserAuthenticated == .signedIn){
            Text("Home").onAppear(){UserAuthState.configureFirebaseStateDidChange()}
        }else if(UserAuthState.isUserAuthenticated == .signedOut){
            WelcomeView().environmentObject(UserAuthState).onAppear(){UserAuthState.configureFirebaseStateDidChange()}
        }else{
            Text("Error")
        }
    }
}

struct RunnersHighView_Previews: PreviewProvider {
    static var previews: some View {
        RunnersHighView()
    }
}
