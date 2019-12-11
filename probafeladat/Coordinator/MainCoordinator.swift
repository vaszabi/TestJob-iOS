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
    
    init(window: UIWindow = UIWindow(), navigationController: UINavigationController = UINavigationController(), tabBarController: UITabBarController = UITabBarController()) {
        self.window = window
        self.navigationController = navigationController
        self.tabBarController = tabBarController
        setupTabBarController()
        setupWindow()
    }
    
    func setupTabBarController() {
        tabBarController.viewControllers = getViewControllers()
        tabBarController.selectedViewController = tabBarController.viewControllers?.first
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
    
  
    
    private func getViewControllers() -> [UIViewController]{
        var vcArray = [UIViewController]()
        let tabBarItems = configureTabBarItems()
        
        navigationController.tabBarItem = tabBarItems.first
        
        vcArray.append(navigationController)
        
        for i in 1..<tabBarItems.count {
            let vc = UIViewController()
            vc.tabBarItem = tabBarItems[i]
            vcArray.append(vc)
        }
        
        return vcArray
    }
    
    private func configureTabBarItems() -> [UITabBarItem] {
          var array = [UITabBarItem]()
          
          let cardsItem = UITabBarItem()
          cardsItem.title = "Cards"
          cardsItem.image = UIImage(named: "nav_cards")
          array.append(cardsItem)
          
          let transactionsItem = UITabBarItem()
          transactionsItem.title = "Transactions"
          transactionsItem.image = UIImage(named: "nav_trans")
          array.append(transactionsItem)
          
          let statementsItem = UITabBarItem()
          statementsItem.title = "Statements"
          statementsItem.image = UIImage(named: "nav_state")
          array.append(statementsItem)
          
          let moreItem = UITabBarItem()
          moreItem.title = "More"
          moreItem.image = UIImage(named: "nav_more")
          array.append(moreItem)
          
          return array
      }
    
}
