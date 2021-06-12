//
//  ValidationChecks.swift
//  RunnersHigh
//
//  Created by Josh Morrison on 6/11/21.
//

import Foundation

class ValidationChecker{
    
    static func isEmailValid(email: String) -> Bool{
        let emailTest = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        return emailTest.evaluate(with: email)
    }
    
    static func isPasswordMatch(password: String, rePassword: String) -> Bool{
        return password == rePassword
    }
    
    static func isPasswordValid(password: String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$")
        return passwordTest.evaluate(with: password)
    }
    
    static func isUsernameValid(username: String) -> Bool{
        return username.trimmingCharacters(in: .whitespacesAndNewlines).count >= 6
    }
    
}
