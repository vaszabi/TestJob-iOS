//
//  ProbaTabBarController.swift
//  probafeladat
//
//  Created by Szabolcs Varga on 2019. 12. 16..
//  Copyright © 2019. WUP. All rights reserved.
//

import UIKit

class ProbaTabBarController: UITabBarController {
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = getViewControllers()
        guard let viewControllers = viewControllers else { return }
        selectedViewController = viewControllers.first
    }
    
    private func getViewControllers() -> [UIViewController]{
        var vcArray = [UIViewController]()
        let tabBarItems = configureTabBarItems()
        
        let navigationController = UINavigationController()
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
