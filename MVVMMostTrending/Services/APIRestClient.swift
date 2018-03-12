//
//  APIRestClient.swift
//  MVVMMostTrending
//
//  Created by burak.ceylan on 09.03.18.
//  Copyright © 2018 burak.ceylan.dev.aperto.com. All rights reserved.
//

import Foundation

protocol APIRestClientProtocol {
    func obtainTrends(apiAuth: APIAuthentificationProtocol, completion: @escaping (Entry?) -> Void)
}


class APIRestClient: APIRestClientProtocol {

    func obtainTrends(apiAuth: APIAuthentificationProtocol, completion: @escaping (Entry?) -> Void) {
        
        guard let url = URL(string: "https://api.twitter.com/1.1/trends/place.json?id=1") else { return }
        
        apiAuth.obtainBearerToken { (token) in
            guard let validToken = token else { return }
            let request = self.getTrendingRequest(url: url, bearerToken: validToken)
            let getTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                var entry: Entry? = nil
                defer {
                    completion(entry)
                }
                guard let data = data, error == nil else {
                    print("error=\(error!)")
                    return
                }
                
                guard let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 200 else {
                    print("statusCode should be 200")
                    return
                }
                
                entry = self.parseTrends(data: data)
             }
            
            getTask.resume()
        }
        
    }
    
    private func parseTrends(data: Data) -> Entry? {
        var responseJson: [Entry]? = nil
        do {
            responseJson = try JSONDecoder().decode(TrendResponse.self, from: data)
        } catch {
            print(error)
        }
        return responseJson?.first
    }
    
    private func getTrendingRequest(url: URL, bearerToken: String) -> URLRequest {
        var request = URLRequest(url: url)
        request.setValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/gzip", forHTTPHeaderField: "Accept-Encoding")
        return request
    }
    
}
