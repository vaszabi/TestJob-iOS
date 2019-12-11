//
//  GeneralErrorHandler.swift
//  probafeladat
//
//  Created by Szabolcs Varga on 2019. 11. 13..
//  Copyright © 2019. WUP. All rights reserved.
//

import Foundation

class GeneralErrorHandler {
    
    static private let errorTitle = "Error"
    
    static func handle(statusCode: Int) {
        DispatchQueue.main.async {
            AlertService.sendAlert(title: errorTitle, message: "Respone code: \(statusCode)")
        }
    }
    
    static func handle(description: String) {
        DispatchQueue.main.async {
            AlertService.sendAlert(title: errorTitle, message: description)
        }
    }
    
}
