//
//  Card.swift
//  probafeladat
//
//  Created by Szabolcs Varga on 2019. 10. 08..
//  Copyright © 2019. WUP. All rights reserved.
//

import Foundation

struct AccountDetails {

    let accountLimit: Int
    let accountNumber: String
  
}


struct Card {
    
    let cardId: String
    let issuer: String
    let cardNumber: String
    let expirationDate: String
    let cardHolderName: String
    let friendlyName: String
    let currency: String
    let cvv: String
    let availableBalance: Int
    let currentBalance: Int
    let minPayment: Int
    let dueDate: String
    let reservations: Int
    let balanceCarriedOverFromLastStatement: Int
    let spendingsSinceLastStatement: Int
    let yourLastRepayment: String
    let accountDetails: AccountDetails
    let status: String
    let cardImage: String
    
}

extension AccountDetails : Decodable {
    
    enum CodingKeys: String, CodingKey {
          case accountLimit
          case accountNumber
      }
}

extension Card: Decodable {
    
    enum CodingKeys: String, CodingKey {
          case cardId
          case issuer
          case cardNumber
          case CardNumber
          case expirationDate
          case cardHolderName
          case friendlyName
          case currency
          case cvv
          case availableBalance
          case currentBalance
          case minPayment
          case dueDate
          case reservations
          case balanceCarriedOverFromLastStatement
          case spendingsSinceLastStatement
          case yourLastRepayment
          case accountDetails
          case status
          case cardImage
      }
    
    init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.cardId = try container.decode(String.self, forKey: .cardId)
            self.issuer = try container.decode(String.self, forKey: .issuer)
    //        A JSON-ben némelyik card-nál "CardNumber" van "cardNumber" helyett
            do {
                self.cardNumber = try container.decode(String.self, forKey: .cardNumber)
            } catch {
                self.cardNumber = try container.decode(String.self, forKey: .CardNumber)
            }
            
            self.expirationDate = try container.decode(String.self, forKey: .expirationDate)
            self.cardHolderName = try container.decode(String.self, forKey: .cardHolderName)
            self.friendlyName = try container.decode(String.self, forKey: .friendlyName)
            self.currency = try container.decode(String.self, forKey: .currency)
            self.cvv = try container.decode(String.self, forKey: .cvv)
            self.availableBalance = try container.decode(Int.self, forKey: .availableBalance)
            self.currentBalance = try container.decode(Int.self, forKey: .currentBalance)
            self.minPayment = try container.decode(Int.self, forKey: .minPayment)
    //        Egységesen ponttal legyenek elválasztva a dátumok
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd"

            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "yyyy.MM.dd."
            if let due = dateFormatterGet.date(from: try container.decode(String.self, forKey: .dueDate)) {
                self.dueDate = dateFormatterPrint.string(from: due)
            } else {
                self.dueDate = try container.decode(String.self, forKey: .dueDate)
            }
            
            self.reservations = try container.decodeIfPresent(Int.self, forKey: .reservations) ?? 0
            self.balanceCarriedOverFromLastStatement = try container.decodeIfPresent(Int.self, forKey: .balanceCarriedOverFromLastStatement) ?? 0
            self.spendingsSinceLastStatement = try container.decodeIfPresent(Int.self, forKey: .spendingsSinceLastStatement) ?? 0
            
            if let repay = dateFormatterGet.date(from: try container.decode(String.self, forKey: .yourLastRepayment)) {
                self.yourLastRepayment = dateFormatterPrint.string(from: repay)
            } else {
                self.yourLastRepayment = try container.decode(String.self, forKey: .yourLastRepayment)
            }

            self.accountDetails = try container.decode(AccountDetails.self, forKey: .accountDetails)
            self.status = try container.decode(String.self, forKey: .status)
            self.cardImage = try container.decode(String.self, forKey: .cardImage)

        }
}


