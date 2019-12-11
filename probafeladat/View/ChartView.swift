//
//  ChartView.swift
//  probafeladat
//
//  Created by Szabolcs Varga on 2019. 10. 18..
//  Copyright © 2019. WUP. All rights reserved.
//

import Foundation
import UIKit

class ChartView: UIView {
    
    var availableBalance = 0
    var currentBalance = 0
    let blueLayer = CAShapeLayer()
    let orangeLayer = CAShapeLayer()
    var imgWidth = CGFloat(0)
    
    
    func setupOverview(available avBal: Int, current curBal: Int) {
        self.availableBalance = avBal
        self.currentBalance = curBal
        
        blueLayer.lineWidth = 12.0
        blueLayer.strokeColor = #colorLiteral(red: 0.2156862745, green: 0.4784313725, blue: 0.6431372549, alpha: 1)
        blueLayer.fillColor = #colorLiteral(red: 0.2156862745, green: 0.4784313725, blue: 0.6431372549, alpha: 1)
        blueLayer.strokeEnd = 0
        
        orangeLayer.lineWidth = 4.0
        orangeLayer.strokeColor = UIColor.orange.cgColor
        orangeLayer.fillColor = UIColor.orange.cgColor
        orangeLayer.strokeEnd = 0
        
        self.layer.addSublayer(blueLayer)
        self.layer.addSublayer(orangeLayer)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1
        animation.duration = 1
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        
        blueLayer.add(animation, forKey: "line")
        orangeLayer.add(animation, forKey: "line")
    }
    
    func setupDetail(available avBal: Int, current curBal: Int) {
        self.availableBalance = avBal
        self.currentBalance = curBal
        
        blueLayer.lineWidth = 30.0
        blueLayer.strokeColor = #colorLiteral(red: 0.2156862745, green: 0.4784313725, blue: 0.6431372549, alpha: 1)
        blueLayer.fillColor = #colorLiteral(red: 0.2156862745, green: 0.4784313725, blue: 0.6431372549, alpha: 1)
        
        orangeLayer.lineWidth = 30.0
        orangeLayer.strokeColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0.5993953339)
        orangeLayer.fillColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0.5993953339)
        self.layer.addSublayer(blueLayer)
        self.layer.addSublayer(orangeLayer)
    }    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if (currentBalance == 0 && availableBalance == 0) {
            return
        } else {
            setupShapeLayers()
        }
    }
    
    private func setupShapeLayers() {
        let ratio = Double(availableBalance) / Double(availableBalance + currentBalance)
        let breakPoint = Double(self.frame.width) * ratio
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: self.frame.width, y: ((self.frame.height)/2)))
        path.addLine(to: CGPoint(x: self.frame.width - CGFloat(breakPoint), y: self.frame.height/2 ))
        path.close()
        blueLayer.path = path.cgPath
        
        let path2 = UIBezierPath()
        path2.move(to: CGPoint(x: 0, y: self.frame.height/2))
        path2.addLine(to: CGPoint(x: self.frame.width - imgWidth - CGFloat(breakPoint), y: self.frame.height/2))
        path2.close()
        orangeLayer.path = path2.cgPath
    }
    
}
