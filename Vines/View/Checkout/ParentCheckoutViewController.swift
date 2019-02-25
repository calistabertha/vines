//
//  ParentCheckoutViewController.swift
//  Vines
//
//  Created by Calista Bertha on 17/01/19.
//  Copyright © 2019 Calista Bertha. All rights reserved.
//

import UIKit

class ParentCheckoutViewController: VinesViewController {
    @IBOutlet weak var lblCustomer: UILabel!
    @IBOutlet weak var lblSummary: UILabel!
    @IBOutlet weak var lblPayment: UILabel!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var iconNext: UIImageView!
    var storeName: String?
    var storeID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
       // NotificationCenter.default.addObserver(self, selector: #selector(getDataCustomer(_:)), name: .dataCustomer, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(getOrderSummary(_:)), name: .orderSummary, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(getPaymentMethod(_:)), name: .paymentMethod, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    private func setupView() {
        for subview in viewContainer.subviews {
            subview.removeFromSuperview()
        }
        
//        let vc = DataCustomerViewController()
//        vc.vinesStore = storeName ?? ""
//        vc.view.frame = viewContainer.bounds
//        self.addChildViewController(vc)
//        viewContainer.addSubview(vc.view)
//        vc.didMove(toParentViewController: self)
//        generateNavBarWithBackButton(titleString: "CHECKOUT", viewController: self, isRightBarButton: false, isNavbarColor: true)
//
//        lblSummary.textColor = UIColor.lightGray
//        lblPayment.textColor = UIColor.lightGray
//        iconNext.image = UIImage(named: "ico-nav-chevronr_1")
        
        let vc = OrderSummaryViewController()
        vc.view.frame = viewContainer.bounds
        self.addChildViewController(vc)
        viewContainer.addSubview(vc.view)
        vc.didMove(toParentViewController: self)
        generateNavBarWithBackButton(titleString: "CHECKOUT", viewController: self, isRightBarButton: false, isNavbarColor: true)
        lblSummary.textColor = UIColor.black
        lblPayment.textColor = UIColor.lightGray
        iconNext.image = UIImage(named: "ico-nav-chevronr")
    }
    
    override func backButtonDidPush() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func getDataCustomer(_ notification: NSNotification) {
        let vc = DataCustomerViewController()
        vc.view.frame = viewContainer.bounds
        viewContainer.addSubview(vc.view)
        lblSummary.textColor = UIColor.lightGray
        lblPayment.textColor = UIColor.lightGray
        iconNext.image = UIImage(named: "ico-nav-chevronr_1")
    }
    
    @objc private func getOrderSummary(_ notification: NSNotification) {
        let vc = OrderSummaryViewController()
        vc.view.frame = viewContainer.bounds
        self.addChildViewController(vc)
        viewContainer.addSubview(vc.view)
        vc.didMove(toParentViewController: self)
        lblSummary.textColor = UIColor.black
        lblPayment.textColor = UIColor.lightGray
        iconNext.image = UIImage(named: "ico-nav-chevronr")
    }
    
    @objc private func getPaymentMethod(_ notification: NSNotification) {
        let vc = PaymentMethodViewController()
        vc.view.frame = viewContainer.bounds
        vc.storeID = storeID
        self.addChildViewController(vc)
        viewContainer.addSubview(vc.view)
        vc.didMove(toParentViewController: self)
        lblPayment.textColor = UIColor.black
        if notification.name == .paymentMethod {
            if let obj = notification.object as? OrderSummaryViewController {
                vc.lblDeliveryAddress.text = obj.delivery
                vc.lblPay.text = obj.totalPayment
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .dataCustomer, object: nil)
        NotificationCenter.default.removeObserver(self, name: .orderSummary, object: nil)
        NotificationCenter.default.removeObserver(self, name: .paymentMethod, object: nil)
    }
    
}
