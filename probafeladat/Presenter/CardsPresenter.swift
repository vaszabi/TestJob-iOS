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
    
    let dataApi = DataApi(service: Service(httpClient: HttpClient()))
    let overviewTitles = ["Current balance","Min. payment","Due date"]
    
    var cards : [Card] = []

    let currentCardIndex: BehaviorRelay<Int> = BehaviorRelay(value: 0)
    let disposeBag = DisposeBag()
    
    init(view: CardsView) {
        self.view = view
    }
    
    func loadData(_ completionHandler:@escaping(_ error:Error?)->()) {
        dataApi.getCard { (fetchedCards, error) in
            
            guard let fetchedCardsTemp = fetchedCards else {
                completionHandler(error)
                return
            }
            self.cards = fetchedCardsTemp
            
            completionHandler(error)
            
            self.setupObserver()
        }
    }
    
    private func setupObserver() {
        currentCardIndex.asObservable()
            .subscribe(onNext: { _ in
                self.view.updateViews()
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

extension CardsPresenter {
    
    func getCurrentCardIndex() -> Int {
        return currentCardIndex.value
    }
}
