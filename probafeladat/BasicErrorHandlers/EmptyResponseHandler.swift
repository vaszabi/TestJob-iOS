//
//  EmptyResponseHandler.swift
//  probafeladat
//
//  Created by Szabolcs Varga on 2019. 11. 05..
//  Copyright © 2019. WUP. All rights reserved.
//

import Foundation

class EmptyResponseHandler {
    
    static private let errorTitle = "Empty Response"
    static private let errorMessage = "Check your internet connection and try again"
    
    static func handle() {
        DispatchQueue.main.async {
            AlertService.sendAlert(title: errorTitle, message: errorMessage)
        }
    }
}
