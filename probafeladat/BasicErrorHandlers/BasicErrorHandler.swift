//
//  BasicErrorHandler.swift
//  probafeladat
//
//  Created by Szabolcs Varga on 2019. 11. 14..
//  Copyright © 2019. WUP. All rights reserved.
//

import Foundation

protocol ErrorHandlerProtocol {
    static var errorTitle: String { get }
    static var errorMessage: String { get }
    static func handle()
}

class BasicErrorHandler {
    
    static func handleResponse(response: HTTPURLResponse) {
        
        switch response.statusCode {
        case 401:
            UnauthorizedErrorHandler.handle()
        case 403:
            ForbiddenErrorHandler.handle()
        case 404:
            NotFoundErrorHandler.handle()
        case 500:
            InternalServerErrorHandler.handle()
        default:
            GeneralErrorHandler.handle(statusCode: response.statusCode)
        }
        
    }
}
