//
//  CardsViewController.swift
//  probafeladat
//
//  Created by Szabolcs Varga on 2019. 10. 08..
//  Copyright © 2019. WUP. All rights reserved.
//

import UIKit

protocol CardsView: class {
    func updateViews()
}

class CardsViewController: UIViewController, Storyboarded {
    
    weak var presenter: CardsPresenter!
    
    @IBOutlet weak var overviewTV: UITableView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var detailsButton: UIButton!
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var leftArrowButton: UIButton!
    @IBOutlet weak var rightArrowButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var chartView: ChartView!
    @IBOutlet weak var exclamationImg: UIImageView!
    @IBOutlet weak var availableLbl: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overviewTV.estimatedRowHeight = 40
        overviewTV.rowHeight = UITableView.automaticDimension
        
        
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
        let origImage = UIImage(named: "ic_arrowleft.png")
        let rotatedImage = origImage?.rotate(radians: .pi)
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        let rotatedTintedImage = rotatedImage?.withRenderingMode(.alwaysTemplate)
        leftArrowButton.setImage(tintedImage, for: .normal)
        leftArrowButton.tintColor = #colorLiteral(red: 0.3254901961, green: 0.6039215686, blue: 0.7764705882, alpha: 1)
        rightArrowButton.setImage(rotatedTintedImage, for: .normal)
        rightArrowButton.tintColor = #colorLiteral(red: 0.3254901961, green: 0.6039215686, blue: 0.7764705882, alpha: 1)
        
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
        return presenter.overviewTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = overviewTV.dequeueReusableCell(withIdentifier: "cell") as? OverviewCell else { return UITableViewCell() }
        
        if !presenter.cards.isEmpty {
            switch indexPath.row {
            case 0:
                cell.addCell(title: presenter.overviewTitles[indexPath.row], curreny: presenter.cards[presenter.getCurrentCardIndex()].currency, value: String(presenter.cards[presenter.getCurrentCardIndex()].currentBalance))
            case 1:
                cell.addCell(title: presenter.overviewTitles[indexPath.row], curreny: presenter.cards[presenter.getCurrentCardIndex()].currency, value: String(presenter.cards[presenter.getCurrentCardIndex()].minPayment))
            case 2:
                cell.addCell(title: presenter.overviewTitles[indexPath.row], curreny: nil, value: presenter.cards[presenter.getCurrentCardIndex()].dueDate.description)
            default:
                break
            }
        }
        return cell
    }
}

extension CardsViewController: CardsView {
    func updateViews() {
        setValues()
    }
}


extension UIImage {
    func rotate(radians: CGFloat) -> UIImage {
        let rotatedSize = CGRect(origin: .zero, size: size)
            .applying(CGAffineTransform(rotationAngle: CGFloat(radians)))
            .integral.size
        UIGraphicsBeginImageContext(rotatedSize)
        if let context = UIGraphicsGetCurrentContext() {
            let origin = CGPoint(x: rotatedSize.width / 2.0,
                                 y: rotatedSize.height / 2.0)
            context.translateBy(x: origin.x, y: origin.y)
            context.rotate(by: radians)
            draw(in: CGRect(x: -origin.y, y: -origin.x,
                            width: size.width, height: size.height))
            let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return rotatedImage ?? self
        }
        
        return self
    }
}


// A Details button borderColor illetve cornerRadius értékeinek megadására
extension UIView {
    
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
