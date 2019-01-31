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
        
        NotificationCenter .default .addObserver(self, selector: #selector(keyboardDidShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter .default .addObserver(self, selector: #selector(keyboardDidHide), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
        
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
    
    @objc func keyboardDidShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let keyboardHeight = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size.height {
                scrollView.contentInset = UIEdgeInsetsMake(0, 0, keyboardHeight, 0)
                scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, keyboardHeight, 0)
                
                self.btnSendMessage.frame = CGRect(x: 0, y: (self.btnSendMessage.frame.origin.y + keyboardHeight), width: self.btnSendMessage.frame.width, height: self.btnSendMessage.frame.height)

            }
        }
    }
    
    @objc func keyboardDidHide(notification: NSNotification) {
          scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
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
