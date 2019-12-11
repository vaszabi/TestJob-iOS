//
//  HttpClient.swift
//  probafeladat
//
//  Created by Szabolcs Varga on 2019. 11. 13..
//  Copyright © 2019. WUP. All rights reserved.
//

import Foundation

class HttpClient: HttpClientProtocol {
    
    typealias completeClosure = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->Void
    
    func get(url: URL, completionHandler: @escaping completeClosure) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            completionHandler(data, response, error)
        }
        .resume()
    }
}
