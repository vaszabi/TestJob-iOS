//
//  CardsViewController.swift
//  probafeladat
//
//  Created by Szabolcs Varga on 2019. 10. 08..
//  Copyright © 2019. WUP. All rights reserved.
//

import UIKit

protocol CardsView: AnyObject {
    func showLoading()
    func hideLoading()
    func updateViews()
}

class CardsViewController: UIViewController, Storyboarded {
    
    weak var presenter: CardsPresenterImpl!
    
    @IBOutlet weak var overviewTV: SelfSizedTableView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var detailsButton: UIButton!
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var leftArrowButton: UIButton!
    @IBOutlet weak var rightArrowButton: ArrowButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var chartView: ChartView!
    @IBOutlet weak var exclamationImg: UIImageView!
    @IBOutlet weak var availableLbl: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setImages()
        setup()
    }
    
    private func setup() {
        
        presenter.loadData { (error) in
            if error == nil  {
                self.setValues()
                self.activityIndicator.stopAnimating()
                self.unhideElements()
                self.addSwipeGesture()
            } else {
                self.activityIndicator.stopAnimating()
                self.refreshButton.isHidden = false
                print(error!.localizedDescription)
            }
        }
        
        overviewTV.maxHeight = 320
        overviewTV.estimatedRowHeight = 40
        overviewTV.rowHeight = UITableView.automaticDimension
    }
    
    
    @IBAction func detailsBtnTapped(_ sender: UIButton) {
        presenter.showDetails()
    }
    
    @IBAction func leftClick(_ sender: UIButton) {
        if !presenter.cards.isEmpty {
            rightSwipe()
        }
    }
    
    @IBAction func rightClick(_ sender: UIButton) {
        if !presenter.cards.isEmpty {
            leftSwipe()
        }
    }
    
    @IBAction func reloadContent(_ sender: UIButton) {
        self.refreshButton.isHidden = true
        self.activityIndicator.startAnimating()
        self.setup()
    }
    
    
    private func unhideElements() {
        topView.isHidden = false
        overviewTV.isHidden = false
        detailsButton.isHidden = false
        chartView.isHidden = false
    }
    
    private func addSwipeGesture() {
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        
        topView.addGestureRecognizer(leftSwipe)
        topView.addGestureRecognizer(rightSwipe)
        topView.isUserInteractionEnabled = true
        topView.isMultipleTouchEnabled = true
    }
    
    private func setValues() {
        if presenter.cards[presenter.getCurrentCardIndex()].availableBalance == 0 {
            chartView.imgWidth = exclamationImg.frame.width
            availableLbl.textColor = #colorLiteral(red: 0.8078431373, green: 0.2156862745, blue: 0.3764705882, alpha: 1)
        }else {
            chartView.imgWidth = 0
            availableLbl.textColor = #colorLiteral(red: 0, green: 0.3058823529, blue: 0.4823529412, alpha: 1)
        }
        availableLbl.text = String(presenter.cards[presenter.getCurrentCardIndex()].availableBalance)
        chartView.setupOverview(available: presenter.cards[presenter.getCurrentCardIndex()].availableBalance, current: presenter.cards[presenter.getCurrentCardIndex()].currentBalance)
        overviewTV.reloadData()
        
        if (presenter.cards[presenter.getCurrentCardIndex()].availableBalance == 0) {
            exclamationImg.isHidden = false
        } else {
            exclamationImg.isHidden = true
        }
        pageControl.numberOfPages = presenter.cards.count
        pageControl.currentPage = presenter.getCurrentCardIndex()
        
        switch presenter.cards[presenter.getCurrentCardIndex()].cardImage {
        case "1":
            cardImage.image = UIImage(named: "cccard.png")
        case "2":
            cardImage.image = UIImage(named: "cccard2.png")
        case "3":
            cardImage.image = UIImage(named: "cccard3.png")
        default:
            cardImage.image = UIImage(named: "cccard.png")
        }
    }
    
    private func setImages() {
        rightArrowButton.transform = rightArrowButton.transform.rotated(by: CGFloat(Double.pi))
        
        let origExcImage = UIImage(named: "ic_alert.png")
        let tintedExcImage = origExcImage?.withRenderingMode(.alwaysTemplate)
        exclamationImg.image = tintedExcImage
        exclamationImg.tintColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        
        addCardShadow()
    }
    
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
        if (sender.direction == .left) {
            leftSwipe()
        }
        
        if (sender.direction == .right) {
            rightSwipe()
        }
    }
    
    
    private func leftSwipe() {
        presenter.currentCardIndexIncrement()
    }
    
    private func rightSwipe() {
        presenter.currentCardIndexDecrement()
    }
    
    private func addCardShadow() {
        cardImage.layer.cornerRadius = 10
        cardImage.layer.shadowRadius = 10
        cardImage.layer.shadowColor = UIColor.black.cgColor
        cardImage.layer.shadowOffset = .zero
        cardImage.layer.shadowOpacity = 0.6
        cardImage.clipsToBounds = true
        cardImage.layer.masksToBounds = false
    }
}

extension CardsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = overviewTV.dequeueReusableCell(withIdentifier: "cell") as? OverviewCell else { return UITableViewCell() }
        
        if (!presenter.dataSource.isEmpty) {
            cell.addCell(title: presenter.dataSource[indexPath.row].title, curreny: presenter.dataSource[indexPath.row].curreny, value: presenter.dataSource[indexPath.row].value)
        }

        return cell
    }
}

extension CardsViewController: CardsView {
    
    func showLoading() {
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        self.activityIndicator.stopAnimating()
    }
    
    func updateViews() {
        setValues()
    }
}
