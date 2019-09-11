//
//  SimpleGalleryTests.swift
//  SimpleGalleryTests
//
//  Created by Nicolas Vignolo on 12/08/2019.
//  Copyright © 2019 Nicolas Vignolo. All rights reserved.
//

import XCTest
@testable import SimpleGallery

class SimpleGalleryTests: XCTestCase {
    
    var session:Session!

    override func setUp() {
        super.setUp()
        session = Session()
        
    }

    override func tearDown() {
        session = nil
       super.tearDown()
    }
    
    func testStoredCredentials() {
        session.signOut()
        XCTAssertNil(session.user)
    }
    
    func testWrongLoginCredentials() {
        let promise = expectation(description: "Login fail")
        session.signIn(with: "worng@gmail.com", password: "password") { (success, error) in
            if success {
                XCTFail("Login succeed")
            } else {
                promise.fulfill()
            }
        }
        
        wait(for: [promise], timeout: 5)
    }

}
