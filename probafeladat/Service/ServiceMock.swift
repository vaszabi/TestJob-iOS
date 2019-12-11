//
//  ServiceMock.swift
//  probafeladat
//
//  Created by Szabolcs Varga on 2019. 12. 05..
//  Copyright © 2019. WUP. All rights reserved.
//

import Foundation

struct ServiceMock : ServiceProtocol {
    
    let httpClient: HttpClientProtocol
    
    init(httpClient: HttpClientProtocol) {
        self.httpClient = httpClient
    }
    
    func fetchData<T>(urlString: String, completion: @escaping ((T)?, Error?) -> ()) where T : Decodable {
        return
    }

}
