//
//  Coordinator.swift
//  probafeladat
//
//  Created by Szabolcs Varga on 2019. 12. 03..
//  Copyright © 2019. WUP. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
