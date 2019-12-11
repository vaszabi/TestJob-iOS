//
//  AlertService.swift
//  probafeladat
//
//  Created by Szabolcs Varga on 2019. 11. 13..
//  Copyright © 2019. WUP. All rights reserved.
//

import UIKit


class AlertService {
    
    static func sendAlert(title:String, message:String, needSettings:Bool = false, handler: ((UIAlertAction) -> Void)? = nil) {
        
    guard let topMostViewController = UIApplication.getTopMostViewController() else { return }
        
        let alertController = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        if needSettings {
            let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
                
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                        print("Settings opened: \(success)")
                    })
                }
            }
            alertController.addAction(settingsAction)
            
        }
        
        alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: handler))
        
        topMostViewController.present(alertController, animated: true, completion: nil)
    }
}
