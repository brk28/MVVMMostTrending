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
    let trends: [Trend]?
    let as_of: String
    let created_at: String
    let locations: [Location]?
}

struct Location: Codable {
    let name: String
    let woeid: Int
}

struct Trend: Codable {
    let name: String
    let url: String
    let promoted_content: String?
    let query: String
    let tweet_volume: Int?
}
