//
//  Service.swift
//  probafeladat
//
//  Created by Szabolcs Varga on 2019. 10. 21..
//  Copyright © 2019. WUP. All rights reserved.
//

import Foundation

protocol ServiceProtocol {
    var httpClient: HttpClientProtocol { get }
    func fetchData<T: Decodable>(urlString: String, completion: @escaping ((T)?, _ error: Error? ) -> ())
}

struct Service: ServiceProtocol{
    
    let httpClient: HttpClientProtocol
    
    init(httpClient: HttpClientProtocol) {
        self.httpClient = httpClient
    }
    
    func fetchData<T: Decodable>(urlString: String, completion: @escaping ((T)?, _ error: Error? ) -> ()) {
        if !NetworkManager.shared.isConnectedToInternet() {
            NoConnectionErrorHandler.handle()
            let connectionError = NSError(domain: "", code: 503, userInfo: ["Service Unavailable":""])
            completion(nil, connectionError)
            
        } else {
            
            guard let url = URL(string: urlString) else {
                let urlError = NSError(domain: "", code: 400, userInfo: ["Invalid URL provided" : ""])
                completion(nil, urlError)
                return
            }
            
            httpClient.get(url: url) { (data, response, error) in
                if let httpResponse = response as? HTTPURLResponse {
                    
                    switch httpResponse.statusCode {
                    case 200...299:
                        break
                    default:
                        BasicErrorHandler.handleResponse(response: httpResponse)
                        DispatchQueue.main.async {
                            completion(nil, error)
                        }
                        return
                        
                    }
                }
                
                if let error = error {
                    GeneralErrorHandler.handle(description: error.localizedDescription)
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                    return
                }
                
                guard let data = data else {
                    EmptyResponseHandler.handle()
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                    return
                }
                guard data.count != 0 else {
                    JsonErrorHandler.handle()
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                    return
                }
                
                do {
                    let obj = try JSONDecoder().decode(T.self, from: data)
                    
                    DispatchQueue.main.async {
                        completion(obj, nil)
                    }
                } catch let jsonError {
                    JsonErrorHandler.handle()
                    DispatchQueue.main.async {
                        completion(nil, jsonError)
                    }
                }
            }
        }
    }
}
