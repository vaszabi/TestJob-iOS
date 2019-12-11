//
//  NoConnectionErrorHandler.swift
//  probafeladat
//
//  Created by Szabolcs Varga on 2019. 11. 06..
//  Copyright © 2019. WUP. All rights reserved.
//

import Foundation
import UIKit

class NoConnectionErrorHandler {
    
    static private let errorTitle = "Connection Failure"
    static private let errorMessage = "Check your internet connection and try again"
    
    static func handle() {
        DispatchQueue.main.async {
            AlertService.sendAlert(title: errorTitle, message: errorMessage, needSettings: true)
        }
    }
}

