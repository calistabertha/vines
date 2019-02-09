//
//  ContactUsViewController.swift
//  Vines
//
//  Created by Calista Bertha on 04/01/19.
//  Copyright © 2019 Calista Bertha. All rights reserved.
//

import UIKit

class ContactUsViewController: VinesViewController {
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtEmailAddress: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var txtMessage: UITextView!
    @IBOutlet weak var btnSendMessage: UIButton!
    @IBOutlet weak var btnMessage: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewHideKeyboard: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateNavBarWithBackButton(titleString: "CONTACT US", viewController: self, isRightBarButton: false, isNavbarColor: true)
        btnSendMessage.layer.cornerRadius = 5
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.viewHideKeyboard.addGestureRecognizer(tap)
        self.viewHideKeyboard.isHidden = true
    }
    
    override func backButtonDidPush() {
        navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
        viewHideKeyboard.isHidden = true
        if txtEmailAddress.text?.isEmpty ?? false {
            btnMessage.isHidden = false
        }else{
            btnMessage.isHidden = true
        }
        
    }
    
    @IBAction func hidePlaceholderMessage(_ sender: Any) {
        btnMessage.isHidden = true
        viewHideKeyboard.isHidden = false
        txtMessage.becomeFirstResponder()
    }
    
}

extension ContactUsViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        btnMessage.isHidden = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension ContactUsViewController: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
       
    }
}
