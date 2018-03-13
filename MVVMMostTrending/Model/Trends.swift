//
//  Trends.swift
//  MVVMMostTrending
//
//  Created by burak.ceylan on 09.03.18.
//  Copyright © 2018 burak.ceylan.dev.aperto.com. All rights reserved.
//

import Foundation

typealias TrendResponse = [Entry]

struct Entry: Codable {
    let trends: [Trend]
    let asOf: String
    let createdAt: String
    let locations: [Location]
    
    enum CodingKeys: String, CodingKey {
        case trends
        case asOf = "as_of"
        case createdAt = "created_at"
        case locations
    }
}

struct Location: Codable {
    let name: String
    let woeid: Int
}

struct Trend: Codable {
    let name: String
    let url: String
    let promotedContent: String?
    let query: String
    let tweetVolume: Int?
    
    enum CodingKeys: String, CodingKey {
        case name
        case url
        case promotedContent = "promoted_content"
        case query
        case tweetVolume = "tweet_volume"
    }
}
