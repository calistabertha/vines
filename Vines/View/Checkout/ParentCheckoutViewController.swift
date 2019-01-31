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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(getDataCustomer(_:)), name: .dataCustomer, object: nil)
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
        
        let vc = DataCustomerViewController()
        vc.view.frame = viewContainer.bounds
        viewContainer.addSubview(vc.view)
        generateNavBarWithBackButton(titleString: "CHECKOUT", viewController: self, isRightBarButton: false, isNavbarColor: true)
        
        lblSummary.textColor = UIColor.lightGray
        lblPayment.textColor = UIColor.lightGray
        iconNext.image = UIImage(named: "ico-nav-chevronr_1")
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
        viewContainer.addSubview(vc.view)
        lblSummary.textColor = UIColor.black
        lblPayment.textColor = UIColor.lightGray
        iconNext.image = UIImage(named: "ico-nav-chevronr")
    }
    
    @objc private func getPaymentMethod(_ notification: NSNotification) {
        let vc = PaymentMethodViewController()
        vc.view.frame = viewContainer.bounds
        viewContainer.addSubview(vc.view)
        lblPayment.textColor = UIColor.black
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .dataCustomer, object: nil)
        NotificationCenter.default.removeObserver(self, name: .orderSummary, object: nil)
        NotificationCenter.default.removeObserver(self, name: .paymentMethod, object: nil)
    }
    
}
