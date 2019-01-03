//
//  DetailPromoViewController.swift
//  Vines
//
//  Created by Calista Bertha on 28/12/18.
//  Copyright © 2018 Calista Bertha. All rights reserved.
//

import UIKit

class DetailPromoViewController: VinesViewController {

    @IBOutlet weak var viewSeparator0: UIView!
    @IBOutlet weak var viewSeparator1: UIView!
    @IBOutlet weak var viewSeparator2: UIView!
    @IBOutlet weak var btnMenu0: UIButton!
    @IBOutlet weak var btnMenu1: UIButton!
    @IBOutlet weak var btnMenu2: UIButton!
    @IBOutlet weak var lblDetail: UILabel!
    
    var isCopied = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
       generateNavBarWithBackButton(titleString: "GET SPECIAL OFFER FROM VINES...", viewController: self, isRightBarButton: false)
        btnMenu0.setTitleColor(UIColor(red: 125/255, green: 6/255, blue: 15/255, alpha: 1), for: .normal)
        viewSeparator0.backgroundColor = UIColor(red: 125/255, green: 6/255, blue: 15/255, alpha: 1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func backButtonDidPush() {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func detailMenu0(_ sender: UIButton) {
        btnMenu0.setTitleColor(UIColor(red: 125/255, green: 6/255, blue: 15/255, alpha: 1), for: .normal)
        viewSeparator0.backgroundColor = UIColor(red: 125/255, green: 6/255, blue: 15/255, alpha: 1)
        btnMenu1.setTitleColor(UIColor(red: 155/255, green: 155/255, blue: 155/255, alpha: 1), for: .normal)
        viewSeparator1.backgroundColor = UIColor(red: 155/255, green: 155/255, blue: 155/255, alpha: 1)
        btnMenu2.setTitleColor(UIColor(red: 155/255, green: 155/255, blue: 155/255, alpha: 1), for: .normal)
        viewSeparator2.backgroundColor = UIColor(red: 155/255, green: 155/255, blue: 155/255, alpha: 1)
        lblDetail.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
    }
    
    @IBAction func detailMenu1(_ sender: Any) {
        btnMenu1.setTitleColor(UIColor(red: 125/255, green: 6/255, blue: 15/255, alpha: 1), for: .normal)
        viewSeparator1.backgroundColor = UIColor(red: 125/255, green: 6/255, blue: 15/255, alpha: 1)
        btnMenu0.setTitleColor(UIColor(red: 155/255, green: 155/255, blue: 155/255, alpha: 1), for: .normal)
        viewSeparator0.backgroundColor = UIColor(red: 155/255, green: 155/255, blue: 155/255, alpha: 1)
        btnMenu2.setTitleColor(UIColor(red: 155/255, green: 155/255, blue: 155/255, alpha: 1), for: .normal)
        viewSeparator2.backgroundColor = UIColor(red: 155/255, green: 155/255, blue: 155/255, alpha: 1)
        lblDetail.text = "Label Detail"
    }
    
    @IBAction func detailMenu2(_ sender: Any) {
        btnMenu2.setTitleColor(UIColor(red: 125/255, green: 6/255, blue: 15/255, alpha: 1), for: .normal)
        viewSeparator2.backgroundColor = UIColor(red: 125/255, green: 6/255, blue: 15/255, alpha: 1)
        btnMenu1.setTitleColor(UIColor(red: 155/255, green: 155/255, blue: 155/255, alpha: 1), for: .normal)
        viewSeparator1.backgroundColor = UIColor(red: 155/255, green: 155/255, blue: 155/255, alpha: 1)
        btnMenu0.setTitleColor(UIColor(red: 155/255, green: 155/255, blue: 155/255, alpha: 1), for: .normal)
        viewSeparator0.backgroundColor = UIColor(red: 155/255, green: 155/255, blue: 155/255, alpha: 1)
        lblDetail.text = "Do Nothing Do Nothing Do Nothing Do Nothing Do Nothing Do Nothing Do Nothing Do Nothing Do Nothing Do Nothing Do Nothing Do Nothing Do Nothing Do Nothing Do Nothing Do Nothing Do Nothing"

    }
    
    @IBAction func promotionButtonDidPush(_ sender: UIButton) {
        if isCopied{
            print("shop now")
            
        }else{
            let alert = UIAlertController(title: "Discount Code Copied", message: nil, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                sender.setTitle("SHOP NOW", for: .normal)
                self.isCopied = true
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
}
