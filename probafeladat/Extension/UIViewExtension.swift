//
//  UIViewExtension.swift
//  probafeladat
//
//  Created by Szabolcs Varga on 2020. 03. 19..
//  Copyright © 2020. WUP. All rights reserved.
//

import UIKit

extension UIView {
    
    func addBlurToView() {
           var blurEffect: UIBlurEffect!
           
           if #available(iOS 10.0, *) {
               blurEffect = UIBlurEffect(style: .dark)
           } else {
               blurEffect = UIBlurEffect(style: .light)
           }
           let blurredEffectView = UIVisualEffectView(effect: blurEffect)
           blurredEffectView.frame = self.bounds
           blurredEffectView.alpha = 0.6
           blurredEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
           self.addSubview(blurredEffectView)
       }
       
       func removeBlurFromView() {
           for subview in self.subviews {
               if subview is UIVisualEffectView {
                   subview.removeFromSuperview()
               }
           }
       }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}
