//
//  DetailsTableViewController.swift
//  probafeladat
//
//  Created by Szabolcs Varga on 2019. 10. 15..
//  Copyright © 2019. WUP. All rights reserved.
//

import Foundation
import UIKit

class DetailsTableViewController: UITableViewController, Storyboarded {
    weak var coordinator: MainCoordinator?
    
    var card: Card!
    
    @IBOutlet weak var chartView: ChartView!
    @IBOutlet weak var currBalanceLbl: UILabel!
    @IBOutlet weak var availableBalanceLbl: UILabel!
    @IBOutlet var currencyLbl: [UILabel]!
    @IBOutlet weak var reservationsLbl: UILabel!
    @IBOutlet weak var carriedBalanceLbl: UILabel!
    @IBOutlet weak var spendingLbl: UILabel!
    @IBOutlet weak var repaymentLbl: UILabel!
    @IBOutlet weak var accLimitLbl: UILabel!
    @IBOutlet weak var accNumLbl: UILabel!
    @IBOutlet weak var cardNumLbl: UILabel!
    @IBOutlet weak var cardHolderNameLbl: UILabel!    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLabels()
        chartView.setupDetail(available: card.availableBalance, current: card.currentBalance)
    }
    
    
    
    private func setLabels() {
        currBalanceLbl.text = String(card.currentBalance)
        availableBalanceLbl.text = String(card.availableBalance)
        reservationsLbl.text = String(card.reservations)
        carriedBalanceLbl.text = String(card.balanceCarriedOverFromLastStatement)
        spendingLbl.text = String(card.spendingsSinceLastStatement)
        repaymentLbl.text = card.yourLastRepayment
        accLimitLbl.text = String(card.accountDetails.accountLimit)
        accNumLbl.text = card.accountDetails.accountNumber
        
        let hiddenCardNumber:String = {
            let splittedCardNumber = card.cardNumber.split(separator: "-")
            var cardNumber = ""
            for _ in 2...splittedCardNumber.count {
                cardNumber.append("****-")
            }
            cardNumber.append(String(splittedCardNumber.last!))
            return cardNumber
        }()
        
        
        cardNumLbl.text = hiddenCardNumber
        cardHolderNameLbl.text = card.cardHolderName
        
        for label in currencyLbl {
            label.text = card.currency
        }
    }
}
