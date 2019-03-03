//
//  OrderSummaryViewController.swift
//  Vines
//
//  Created by Calista Bertha on 19/01/19.
//  Copyright © 2019 Calista Bertha. All rights reserved.
//

import UIKit

class OrderSummaryViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnNext: UIButton!
    var cartList: [CartModelData] = []
    var isCodeApplied = false
    var totalPayment: String?
    var delivery: String?
    var postCode: String?
    var discountCode: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ListOrderTableViewCell.nib, forCellReuseIdentifier: ListOrderTableViewCell.identifier)
        tableView.register(DiscountCodeTableViewCell.nib, forCellReuseIdentifier: DiscountCodeTableViewCell.identifier)
        tableView.register(ApplyDiscountTableViewCell.nib, forCellReuseIdentifier: ApplyDiscountTableViewCell.identifier)
        tableView.register(DeliveryTableViewCell.nib, forCellReuseIdentifier: DeliveryTableViewCell.identifier)
        tableView.register(SummaryTableViewCell.nib, forCellReuseIdentifier: SummaryTableViewCell.identifier)
        btnNext.layer.cornerRadius = 5
        fetchCartList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let serialQueue = DispatchQueue(label: "atc-serial-queue")
        
        serialQueue.sync {
            for productData in cartList {
                let params = [
                    "order_code": userDefault().getOrderCode(),
                    "token": userDefault().getToken(),
                    "product_id": productData.productID ?? 0
                  
                    ] as [String: Any]
                
                HTTPHelper.shared.requestAPI(url: Constants.ServicesAPI.User.deleteCart, param: params, method: HTTPMethodHelper.post) { (success, json) in
                    let data = CartModelBaseClass(json: json ?? "")
                    if data.message?.lowercased() == "success" {
                        
                    } else {
                        let alert = JDropDownAlert()
                        alert.alertWith("Oopss..", message: data.displayMessage, topLabelColor: UIColor.white, messageLabelColor: UIColor.white, backgroundColor: UIColor(red: 125/255, green: 6/255, blue: 15/255, alpha: 1), image: nil)
                        print(data.displayMessage ?? "")
                    }
                }
            }
        }
        
        serialQueue.sync {
            print("delete cart done")
        }
    }
    
    func fetchCartList() {
        let params = [
            "token": userDefault().getToken(),
            "user_id": userDefault().getUserID(),
            "order_code": userDefault().getOrderCode()
            ] as [String : Any]
        
        HTTPHelper.shared.requestAPI(url: Constants.ServicesAPI.User.listCart, param: params, method: HTTPMethodHelper.post) { (success, json) in
            let data = CartModelBaseClass(json: json ?? "")
            if data.message == "success", let datas = data.data {
                self.cartList = datas
                self.tableView.reloadData()
                
            } else {
                print(data.displayMessage ?? "")
            }
        }
    }
    
    @IBAction func nextButtonDidPush(_ sender: Any) {
        if delivery == "" || delivery == nil{
            let alert = JDropDownAlert()
            alert.alertWith("Oopss..", message: "Please fill delivery address", topLabelColor: UIColor.white, messageLabelColor: UIColor.white, backgroundColor: UIColor(red: 125/255, green: 6/255, blue: 15/255, alpha: 1), image: nil)
        }else if postCode == "" || postCode == nil{
            let alert = JDropDownAlert()
            alert.alertWith("Oopss..", message: "Please fill your post code", topLabelColor: UIColor.white, messageLabelColor: UIColor.white, backgroundColor: UIColor(red: 125/255, green: 6/255, blue: 15/255, alpha: 1), image: nil)
        }else{
             NotificationCenter.default.post(name: .paymentMethod, object: self)
        }
    }
}

extension OrderSummaryViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return UITableViewAutomaticDimension
        } else if indexPath.row == 1 {
            if isCodeApplied {
                return 194
            }else{
                return 163
            }
        }else if indexPath.row == 2 {
            return 233
        }else if indexPath.row == 3 {
            return UITableViewAutomaticDimension
        }
        
        return 0
    }
}

extension OrderSummaryViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ListOrderTableViewCell.identifier, for: indexPath) as! ListOrderTableViewCell
            cell.setupOrderList(list: cartList)
            return cell
        }else if indexPath.row == 1 {
            if isCodeApplied{
                return ApplyDiscountTableViewCell.configure(context: self, tableView: tableView, indexPath: indexPath, object: "")
            }else {
                return DiscountCodeTableViewCell.configure(context: self, tableView: tableView, indexPath: indexPath, object: "")
            }
        }else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: DeliveryTableViewCell.identifier, for: indexPath) as! DeliveryTableViewCell
            if delivery != nil {
                cell.textView.text = delivery
            }else{
                if cell.textView.text.isEmpty {
                    cell.textView.text = "Your Address"
                    cell.textView.textColor = UIColor.lightGray
                }
            }
            if postCode != nil{
                cell.txtPostCode.text = postCode
            }else {
                cell.txtPostCode.text = ""
                
            }
            cell.textView.delegate = self
            cell.txtPostCode.delegate = self
            return cell
        }
        else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SummaryTableViewCell.identifier, for: indexPath) as! SummaryTableViewCell
            let subtotal = cartList
                .map { (productData: CartModelData) -> Int in
                    guard let price = productData.price, let quantity = productData.jumlahOrder else { return 0 }
                    return quantity * price
                }
                .reduce(0, +)
            
            if isCodeApplied{
                cell.viewDiscount.frame.size.height = 20
                cell.viewDiscount.isHidden = false
                let totalPrice = subtotal - 100000
                cell.lblSubtotal.text = String(subtotal).asRupiah()
                cell.lblTotal.text = String(totalPrice).asRupiah()
                self.totalPayment = String(totalPrice).asRupiah()
            }else{
                cell.viewDiscount.frame.size.height = 0
                cell.viewDiscount.isHidden = true
                cell.lblSubtotal.text = String(subtotal).asRupiah()
                cell.lblTotal.text = String(subtotal).asRupiah()
                self.totalPayment = String(subtotal).asRupiah()
            }
           
            
            return cell
        }
        return UITableViewCell()
    }
}

extension OrderSummaryViewController: UITextViewDelegate{
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView.text == "Your Address"{
            textView.text = ""
        }
     
        textView.textColor = UIColor.black
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        delivery = textView.text
        return true
    }
}

extension OrderSummaryViewController: UITextFieldDelegate{
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        postCode = textField.text
        return true
    }
}
