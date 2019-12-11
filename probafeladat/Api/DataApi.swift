//
//  DataApi.swift
//  probafeladat
//
//  Created by Szabolcs Varga on 2019. 11. 06..
//  Copyright © 2019. WUP. All rights reserved.
//

import Foundation

struct DataApi {
    
    let urlString = "https://raw.githubusercontent.com/wupdigital/interview-api/master/api/v1/cards.json"
    let service: ServiceProtocol
    
    init(service: ServiceProtocol) {
        self.service = service
    }
    
    func getCard(completion: @escaping (_ fetchedCards: [Card]?, _ error: Error?) -> ()) {
        service.fetchData(urlString: urlString) { (fetchedCards: [Card]?, error)   in
            completion(fetchedCards,error)
        }
     
    }
}
