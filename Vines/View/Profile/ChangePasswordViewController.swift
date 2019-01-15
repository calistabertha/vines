//
//  ChangePasswordViewController.swift
//  Vines
//
//  Created by Calista Bertha on 15/01/19.
//  Copyright © 2019 Calista Bertha. All rights reserved.
//

import UIKit

class ChangePasswordViewController: VinesViewController {
    @IBOutlet weak var txtOldPassword: UITextField!
    @IBOutlet weak var txtNewPassword: UITextField!
    @IBOutlet weak var txtRetypeNewPassword: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateNavBarWithBackButton(titleString: "CHANGE PASSWORD", viewController: self, isRightBarButton: false)
        btnSave.layer.cornerRadius = 5
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
        
    }
    
    override func backButtonDidPush() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonDidPush(_ sender: Any) {
        if (txtOldPassword.text?.isEmpty)! || (txtNewPassword.text?.isEmpty)! || (txtRetypeNewPassword.text?.isEmpty)!{
            return
        }
        navigationController?.popViewController(animated: true)
        let rect = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height + 52)
        let succesEditing = SuccessEditing.init(frame: rect)
        succesEditing.delegate = self
        succesEditing.successType(type: .password)
        succesEditing.show(animated: true)
    }
}

extension ChangePasswordViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension ChangePasswordViewController: SuccessEditingViewDelegate{
    func continueButtonDidPush(sender: UIButton, view: SuccessEditing) {
        view.dismiss(animated: true)
    }
    
}
