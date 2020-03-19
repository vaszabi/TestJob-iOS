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

protocol CardsPresenter: AnyObject {
    func refresh()
    func viewDidLoad(with viewController: CardsView)
    func navigateToDetials()
}

final class CardsPresenterImpl {
    
    // MARK: - Properties
    weak var coordinator: MainCoordinator?
    private weak var view: CardsView?
    
    var dataSource: [CardPresentationModel] = []
    var cards : [Card] = []
    
    let dataApi: DataApiProtocol
    let currentCardIndex: BehaviorRelay<Int> = BehaviorRelay(value: 0)
    let disposeBag = DisposeBag()
    
    // MARK: - Init
    init(view: CardsView, dataApi: DataApiProtocol = DataApi(service: Service(httpClient: HttpClient()))) {
        self.view = view
        self.dataApi = dataApi
    }
    
    func refresh() {
        loadData()
    }
    
    func loadData() {
        view?.showLoading()
        dataApi.getCard { (fetchedCards, error) in
            guard let fetchedCardsTemp = fetchedCards else {
                self.view?.hideLoading()
                self.view?.showRefresh()
                return
            }
            
            self.cards = fetchedCardsTemp
            self.setupObserver()
            self.view?.showContent()
        }
    }
    
    public func getCurrentCardIndex() -> Int {
        return currentCardIndex.value
    }
    
    // TODO: Use xib
    private func setupDataSource() {
        dataSource.removeAll()
        dataSource.append(CardPresentationModel(title: "Current balance", curreny: cards[getCurrentCardIndex()].currency, value: String(cards[getCurrentCardIndex()].currentBalance)))
        dataSource.append(CardPresentationModel(title: "Min. payment", curreny: cards[getCurrentCardIndex()].currency, value: String(cards[getCurrentCardIndex()].minPayment)))
        dataSource.append(CardPresentationModel(title: "Due date", curreny: nil, value: cards[getCurrentCardIndex()].dueDate.description))
    }
    
    private func setupObserver() {
        currentCardIndex.asObservable()
            .subscribe(onNext: { _ in
                self.view?.updateViews()
                self.setupDataSource()
            })
            .disposed(by: disposeBag)
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

// MARK: - CardsPresenter conform
extension CardsPresenterImpl: CardsPresenter {
    
    func viewDidLoad(with viewController: CardsView) {
        self.view = viewController
        
        refresh()
    }
    
    func navigateToDetials() {
        coordinator?.cardDetails()
    }
    
    
}
