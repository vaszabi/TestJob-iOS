//
//  Storyboarded.swift
//  probafeladat
//
//  Created by Szabolcs Varga on 2019. 12. 03..
//  Copyright © 2019. WUP. All rights reserved.
//

import Foundation
import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        return storyboard.instantiateViewController(identifier: id) as! Self
    }
}
