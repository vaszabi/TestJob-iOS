//
//  MainCoordinator.swift
//  probafeladat
//
//  Created by Szabolcs Varga on 2019. 12. 03..
//  Copyright © 2019. WUP. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    
    private let window: UIWindow
    private var tabBarController: UITabBarController
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var cardsPresenter: CardsPresenter?
    
    init(window: UIWindow = UIWindow(), navigationController: UINavigationController = UINavigationController(), tabBarController: UITabBarController = ProbaTabBarController()) {
        self.window = window
        self.navigationController = tabBarController.viewControllers?.first as! UINavigationController
        self.tabBarController = tabBarController
        setupWindow()
    }

    
    func setupWindow() {
        self.window.rootViewController = tabBarController
        self.window.makeKeyAndVisible()
    }
    
    func start() {
        let vc = CardsViewController.instantiate()
        cardsPresenter = CardsPresenter(view: vc)
        cardsPresenter?.coordinator = self
        guard let cardsPresenter = cardsPresenter else { return }
        vc.presenter = cardsPresenter
        navigationController.pushViewController(vc, animated: false)
    }
    
    func cardDetails() {
        let vc = DetailsTableViewController.instantiate()
        vc.coordinator = self
        guard let cardsPresenter = cardsPresenter else { return }
        vc.card = cardsPresenter.cards[cardsPresenter.currentCardIndex.value]
        navigationController.pushViewController(vc, animated: true)
    }
    
}
