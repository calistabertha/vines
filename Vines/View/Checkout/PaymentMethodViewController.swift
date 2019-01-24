//
//  PaymentMethodViewController.swift
//  Vines
//
//  Created by Calista Bertha on 21/01/19.
//  Copyright © 2019 Calista Bertha. All rights reserved.
//

import UIKit

class PaymentMethodViewController: UIViewController {

    @IBOutlet weak var lblPay: UILabel!
    @IBOutlet weak var lblFullname: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var btnEdit1: UIButton!
    @IBOutlet weak var viewPickup: UIView!
    @IBOutlet weak var lblStore: UILabel!
    @IBOutlet weak var lblStoreAddress: UILabel!
    @IBOutlet weak var btnEdit2: UIButton!
    @IBOutlet weak var btnPayNow: UIButton!
    @IBOutlet weak var viewDelivery: UIView!
    @IBOutlet weak var lblDeliveryAddress: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func editPersonalInfoButtonDidPush(_ sender: Any) {
        NotificationCenter.default.post(name: .dataCustomer, object: nil)
    }
   
    @IBAction func editShippingButtonDidPush(_ sender: Any) {
        NotificationCenter.default.post(name: .orderSummary, object: nil)
    }
    
    @IBAction func payNowButtonDidPush(_ sender: Any) {
    }
    
}
