//
//  UIApplication+.swift
//  probafeladat
//
//  Created by Szabolcs Varga on 2020. 03. 19..
//  Copyright © 2020. WUP. All rights reserved.
//

import UIKit

extension UIApplication {
    class func getTopMostViewController(base: UIViewController? = (UIApplication.shared.windows.first { $0.isKeyWindow })?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return getTopMostViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return getTopMostViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return getTopMostViewController(base: presented)
        }
        return base
    }
}
