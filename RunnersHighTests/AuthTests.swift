//
//  AuthTests.swift
//  RunnersHighTests
//
//  Created by Josh Morrison on 6/12/21.
//

import XCTest
@testable import RunnersHigh

class AuthTests: XCTestCase {
    
    override func setUp() {
        
    }

    // EMAIL VALIDATION
    func testEmailValidationReturnsTrue(){
        XCTAssertTrue(ValidationChecker.isEmailValid(email: "josh@gmail.com"))
    }
    
    func testEmailValidationReturnsFalseWhenThereIsNoDotCom(){
        XCTAssertFalse(ValidationChecker.isEmailValid(email: "josh@gmail"))
    }
    
    func testEmailValidationReturnsFalseWhenThereIsNoAtSymbol(){
        XCTAssertFalse(ValidationChecker.isEmailValid(email: "joshgmail.com"))
    }

    // USERNAME VALIDATION
    func testusernameValidationReturnsTrueEqualTo6Characters(){
        XCTAssertTrue(ValidationChecker.isUsernameValid(username: "JoshuaM"))
    }
    
    func testusernameValidationReturnsFalseLessThan6Characters(){
        XCTAssertFalse(ValidationChecker.isUsernameValid(username: "Joshua"))
    }
    
    func testusernameValidationReturnsTrueGreaterThan6Characters(){
        XCTAssertTrue(ValidationChecker.isUsernameValid(username: "JoshuaMM"))
    }
}
