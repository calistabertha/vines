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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for subview in viewContainer.subviews {
            subview.removeFromSuperview()
        }
        
        let vc = DataCustomerViewController()
        vc.view.frame = viewContainer.bounds
        viewContainer.addSubview(vc.view)
        generateNavBarWithBackButton(titleString: "CHECKOUT", viewController: self, isRightBarButton: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func backButtonDidPush() {
        navigationController?.popViewController(animated: true)
    }

}
