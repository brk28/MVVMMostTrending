//
//  APIAuthentificationTests.swift
//  MVVMMostTrendingTests
//
//  Created by burak.ceylan on 02.03.18.
//  Copyright © 2018 burak.ceylan.dev.aperto.com. All rights reserved.
//

import XCTest
@testable import MVVMMostTrending

class APIAuthentificationTests: XCTestCase {
    
    var authentifikator: APIAuthentifikation?
    
    override func setUp() {
        super.setUp()
        authentifikator = APIAuthentifikation(consumerKey: "p3JJLoAw9NsIOVvu5w5GiNQjZ", consumerSecret: "1XS34O67qXpqCqMO59Ye3WY4zZkeAGXR8xz38kFonFtIFb15UG")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_APIAuthentifikation_ConcatenateToBearerTokenCredentials_shouldReturnRightString() {
        // given
        let key = "p3JJLoAw9NsIOVvu5w5GiNQjZ"
        let secret = "1XS34O67qXpqCqMO59Ye3WY4zZkeAGXR8xz38kFonFtIFb15UG"
        
        // when
        let result = authentifikator?.concatenateToBearerTokenCredentials(key: key, secret: secret)
        
        // then
        
        XCTAssertTrue(result == "p3JJLoAw9NsIOVvu5w5GiNQjZ:1XS34O67qXpqCqMO59Ye3WY4zZkeAGXR8xz38kFonFtIFb15UG")
    }

    
    func test_APIAuthentificator_encodeBase64_shouldReturnRightBase64EncodedString() {
        // given
        let credentials = "xvz1evFS4wEEPTGEFPHBog:L8qq9PZyRg6ieKGEKhZolGC0vJWLw8iEJ88DRdyOg"
        
        //when
        let result = authentifikator?.encodeBase64(credentials: credentials)
        
        // then
        XCTAssertTrue(result == "eHZ6MWV2RlM0d0VFUFRHRUZQSEJvZzpMOHFxOVBaeVJnNmllS0dFS2hab2xHQzB2SldMdzhpRUo4OERSZHlPZw==")
    }
    
}
