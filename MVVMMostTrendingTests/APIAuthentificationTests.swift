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
    
}
