//
//  APIAuthentification.swift
//  MVVMMostTrending
//
//  Created by burak.ceylan on 01.03.18.
//  Copyright © 2018 burak.ceylan.dev.aperto.com. All rights reserved.
//

import Foundation

protocol APIAuthentificationProtocol {
    func obtainBearerToken(completion: @escaping (_ token: String?) -> Void)
}

class APIAuthentifikation: APIAuthentificationProtocol{
    
    private let authenticationURL: String = "https://api.twitter.com/oauth2/token"
    
    private var consumerKey: String
    private var consumerSecret: String
    
    private var bearerToken: String?
    
    init(consumerKey: String, consumerSecret: String) {
        self.consumerKey = consumerKey
        self.consumerSecret = consumerSecret
    }

    
    
    func obtainBearerToken(completion: @escaping (_ token: String?) -> Void) {
        
        if bearerToken != nil {
            completion(bearerToken)
            return
        }
        
        guard let url = URL(string: authenticationURL) else { return }
        let request = getTokenRequest(url: url)
        
        let postTask = URLSession.shared.dataTask(with: request) { data, response, error in
            var token: String? = nil
            defer {
                completion(token)
            }
            guard let data = data, error == nil else {
                print("error=\(error!)")
                return
            }
            
            guard let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 200 else {
                print("statusCode should be 200")
                return
            }
            token = self.parseToken(data: data)
            self.bearerToken = token
        }
        postTask.resume()
    }
    
    private func parseToken(data: Data) -> String? {
        var token: String? = nil
        do {
            guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] else {
                print("Serialisation error")
                return nil
            }
            token = json["access_token"] as? String
        } catch {
            print("Fail JSON Serialization")
        }
        return token
    }
    
    private func getTokenRequest(url: URL) -> URLRequest {
        let credentialsInBase64 = encodeBase64(credentials: concatenateToBearerTokenCredentials(key: self.consumerKey, secret: self.consumerSecret))
        let authHeaderValue = "Basic \(credentialsInBase64)"
        var request = URLRequest(url: url)
        request.setValue("application/gzip", forHTTPHeaderField: "Accept-Encoding")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue(authHeaderValue, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        let postBody = "grant_type=client_credentials"
        request.httpBody = postBody.data(using: .utf8)
        return request
    }
    
    private func encodeBase64(credentials: String) -> String {
        return Data(credentials.utf8).base64EncodedString()
    }
    
    private func concatenateToBearerTokenCredentials(key: String, secret: String) -> String {
        let concStr = "\(key):\(secret)"
        return concStr
    }
    
}


