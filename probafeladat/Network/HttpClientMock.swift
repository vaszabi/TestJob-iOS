//
//  HttpClientMock.swift
//  probafeladat
//
//  Created by Szabolcs Varga on 2019. 11. 18..
//  Copyright © 2019. WUP. All rights reserved.
//

import Foundation

class HttpClientMock: HttpClientProtocol {
    
    private let data: Data?
    private let response: URLResponse?
    private let error: Error?
    
    var gotCalled = false
    
    init(data:Data?, response: URLResponse?, error: Error?) {
        self.data = data
        self.response = response
        self.error = error
    }
    
    func get(url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        completionHandler(data, response, error)
        gotCalled = true
    }
    
}
