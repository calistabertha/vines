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
    var storeID : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnPayNow.layer.cornerRadius = 4
        btnEdit2.layer.cornerRadius = btnEdit2.frame.height / 2
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func editPersonalInfoButtonDidPush(_ sender: Any) {
        NotificationCenter.default.post(name: .orderSummary, object: nil)
    }
   
    @IBAction func editShippingButtonDidPush(_ sender: Any) {
        NotificationCenter.default.post(name: .orderSummary, object: nil)
    }
    
    @IBAction func payNowButtonDidPush(_ sender: Any) {
        let url = "https://vines-indonesia.com/cart/payment_list?user_id=\(userDefault().getUserID())&order_code=\(userDefault().getOrderCode())&user_email=iwan_infor%40yahoo.co.id&delivery_address=Pejaten+Timur%2C+South+Jakarta+City%2C+Jakarta%2C+Indonesia&city=South+Jakarta+City&postal_code=17113&use_point=&lat=-6.270095&long=106.85028790000001&address=jakarta&store_id=\(storeID ?? 0)&promotion_code=&submit=Submit"
        guard let settingsUrl = URL(string: url) else {
            return
        }
        
        if UIApplication.shared.canOpenURL(settingsUrl) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                })
            } else {
                UIApplication.shared.openURL(settingsUrl as URL)
            }
        }

    }
    
}
