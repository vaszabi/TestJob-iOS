//
//  NetworkManager.swift
//  probafeladat
//
//  Created by Szabolcs Varga on 2019. 11. 05..
//  Copyright © 2019. WUP. All rights reserved.
//

import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init(){}
    
    func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}


