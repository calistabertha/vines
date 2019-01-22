//
//  DataCustomerViewController.swift
//  Vines
//
//  Created by Calista Bertha on 19/01/19.
//  Copyright © 2019 Calista Bertha. All rights reserved.
//

import UIKit

class DataCustomerViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnNext: UIButton!
    var isDeliver = false
    var isShipping = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(PersonalInfoTableViewCell.nib, forCellReuseIdentifier: PersonalInfoTableViewCell.identifier)
        tableView.register(ShippingMethodTableViewCell.nib, forCellReuseIdentifier: ShippingMethodTableViewCell.identifier)
        tableView.register(DeliveryTableViewCell.nib, forCellReuseIdentifier: DeliveryTableViewCell.identifier)
        tableView.register(PickupTableViewCell.nib, forCellReuseIdentifier: PickupTableViewCell.identifier)
        btnNext.layer.cornerRadius = 5
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.tableView.addGestureRecognizer(tap)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func showKeyboard() {
        NotificationCenter .default .addObserver(self, selector: #selector(keyboardDidShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter .default .addObserver(self, selector: #selector(keyboardDidHide), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
    }
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    @objc func keyboardDidShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let keyboardHeight = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size.height {
                tableView.contentInset = UIEdgeInsetsMake(0, 0, keyboardHeight, 0)
            }
        }
    }
    
    @objc func keyboardDidHide(notification: NSNotification) {
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    @IBAction func nextButtonDidPush(_ sender: Any) {
        let vc = OrderSummaryViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension DataCustomerViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 297
        } else if indexPath.row == 1 {
            if isShipping {
                return 260
            }else {
                if isDeliver{
                    return 208
                }else {
                    return 169
                }
            }
        }
        return 0
    }
}

extension DataCustomerViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PersonalInfoTableViewCell.identifier, for: indexPath) as! PersonalInfoTableViewCell
            cell.txtFirstName.delegate = self
            cell.txtLastName.delegate = self
            cell.rememberSelected = {
                (cells) in
                if cell.btnRemember.isSelected {
                    cell.btnRemember.isSelected = false
                    cell.btnRemember.setImage(UIImage(named: "ico-checkbox-active"), for: .normal)
                    cell.isRemember = true
                    print("selected")
                }else{
                    cell.btnRemember.setImage(UIImage(named: "ico-checkbox-inactive"), for: .normal)
                    cell.btnRemember.isSelected = true
                    cell.isRemember = false
                    print("unselected")
                }
                tableView.reloadData()
            }
            return cell
            
        } else if indexPath.row == 1 {
            if isShipping{
                let cell = tableView.dequeueReusableCell(withIdentifier: ShippingMethodTableViewCell.identifier, for: indexPath) as! ShippingMethodTableViewCell
                cell.btnConfirm.layer.cornerRadius = cell.btnConfirm.frame.height / 2
                cell.deliverSelected = {
                    (cells) in
                    cell.btnDeliver.setImage(UIImage(named: "ico-radiobutton-active"), for: .normal)
                    cell.btnPickup.setImage(UIImage(named: "ico-radiobutton-inactive"), for: .normal)
                    cell.isDeliver = true
                    tableView.reloadData()
                }
                
                cell.pickupSelected = {
                    (cells) in
                    cell.btnDeliver.setImage(UIImage(named: "ico-radiobutton-inactive"), for: .normal)
                    cell.btnPickup.setImage(UIImage(named: "ico-radiobutton-active"), for: .normal)
                    cell.isDeliver = false
                    tableView.reloadData()
                }
                
                cell.confirmSelected = {
                    (cells) in
                    self.isDeliver = cell.isDeliver!
                    self.isShipping = false
                    tableView.reloadData()
                }
                return cell
                
            }else {
                if isDeliver {
                    let cell = tableView.dequeueReusableCell(withIdentifier: DeliveryTableViewCell.identifier, for: indexPath) as! DeliveryTableViewCell
                    let point = CGPoint(x: 0, y: cell.textView.frame.height)
                    cell.textView.setContentOffset(point, animated: false)
                    if cell.textView.text.isEmpty {
                        cell.textView.text = "Your Address"
                        cell.textView.textColor = UIColor.lightGray
                    }
                    cell.btnBack.layer.cornerRadius = cell.btnBack.frame.height / 2
                    cell.textView.delegate = self
                    cell.backSelected = {
                        (cells) in
                        self.isShipping = true
                        tableView.reloadData()
                    }
                    return cell
                }else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: PickupTableViewCell.identifier, for: indexPath) as! PickupTableViewCell
                    cell.btnBack.layer.cornerRadius = cell.btnBack.frame.height / 2
                    cell.backSelected = {
                        (cells) in
                        self.isShipping = true
                        tableView.reloadData()
                    }
                    return cell
                }
            }
        }
        return UITableViewCell()
    }
    
}

extension DataCustomerViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.showKeyboard()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension DataCustomerViewController: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        self.showKeyboard()
    }
}
