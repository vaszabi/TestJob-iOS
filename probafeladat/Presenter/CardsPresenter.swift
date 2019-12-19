//
//  CardsPresenter.swift
//  probafeladat
//
//  Created by Szabolcs Varga on 2019. 11. 19..
//  Copyright © 2019. WUP. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class CardsPresenter {
    weak var coordinator: MainCoordinator?
    
    let view: CardsView
    let dataApi: DataApiProtocol
    
    var dataSource: [CardPresenterModel] = []
    var cards : [Card] = []

    let currentCardIndex: BehaviorRelay<Int> = BehaviorRelay(value: 0)
    let disposeBag = DisposeBag()
    
    init(view: CardsView, dataApi: DataApiProtocol = DataApi(service: Service(httpClient: HttpClient()))) {
        self.view = view
        self.dataApi = dataApi
    }
    
    func loadData(_ completionHandler:@escaping(_ error:Error?)->()) {
        dataApi.getCard { (fetchedCards, error) in
            
            guard let fetchedCardsTemp = fetchedCards else {
                completionHandler(error)
                return
            }
            
            self.cards = fetchedCardsTemp
            self.setupObserver()
            
            completionHandler(error)
                        
        }
    }
    
    private func setupDataSource() {
        dataSource.removeAll()
        dataSource.append(CardPresenterModel(title: "Current balance", curreny: cards[getCurrentCardIndex()].currency, value: String(cards[getCurrentCardIndex()].currentBalance)))
        dataSource.append(CardPresenterModel(title: "Min. payment", curreny: cards[getCurrentCardIndex()].currency, value: String(cards[getCurrentCardIndex()].minPayment)))
        dataSource.append(CardPresenterModel(title: "Due date", curreny: nil, value: cards[getCurrentCardIndex()].dueDate.description))
    }
    
    private func setupObserver() {
        currentCardIndex.asObservable()
            .subscribe(onNext: { _ in
                self.view.updateViews()
                self.setupDataSource()
            })
        .disposed(by: disposeBag)
    }
    
    func showDetails() {
        coordinator?.cardDetails()
    }
    
    func currentCardIndexIncrement() {
        if currentCardIndex.value+1 == cards.count {
            currentCardIndex.accept(0)
        } else {
            let newValue = currentCardIndex.value + 1
            currentCardIndex.accept(newValue)
        }
    }
    
    func currentCardIndexDecrement() {
        if (currentCardIndex.value == 0) {
            currentCardIndex.accept(cards.count-1)
        }else {
            let newValue = currentCardIndex.value - 1
            currentCardIndex.accept(newValue)
        }
    }
    
}

struct CardPresenterModel {
    
    let title: String
    let curreny: String?
    let value: String

}

extension CardsPresenter {
    
    func getCurrentCardIndex() -> Int {
        return currentCardIndex.value
    }
}
