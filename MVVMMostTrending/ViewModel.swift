//
//  ViewModel.swift
//  MVVMMostTrending
//
//  Created by burak.ceylan on 01.03.18.
//  Copyright © 2018 burak.ceylan.dev.aperto.com. All rights reserved.
//

import Foundation
import Bond

class ViewModel {
    
    var trends: MutableObservableArray<Trend> = MutableObservableArray([])
    
    func fetchTrends(restClient: APIRestClientProtocol, apiAuth: APIAuthentificationProtocol) {
        restClient.obtainTrends( apiAuth: apiAuth) { (entry) in
            guard let entry = entry, let trends = entry.trends else {
                print("Some Error Handling")
                return
            }
            self.trends.batchUpdate({ (observableTrends) in
                for item in trends {
                    observableTrends.append(item)
                }
            })
            
        }
    }
  
}
