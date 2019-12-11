//
//  HttpClientProtocol.swift
//  probafeladat
//
//  Created by Szabolcs Varga on 2019. 11. 18..
//  Copyright © 2019. WUP. All rights reserved.
//

import Foundation

protocol HttpClientProtocol {
    
    func get(url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
    
}
