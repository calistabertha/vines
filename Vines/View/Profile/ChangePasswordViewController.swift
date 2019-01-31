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
        generateNavBarWithBackButton(titleString: "CHANGE PASSWORD", viewController: self, isRightBarButton: false, isNavbarColor: true)
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
            let alert = JDropDownAlert()
            alert.alertWith("Oopss..", message: "Please fill in your password  ", topLabelColor: UIColor.white, messageLabelColor: UIColor.white, backgroundColor: UIColor.red, image: nil)
        } else if txtNewPassword.text != txtRetypeNewPassword.text {
            let alert = JDropDownAlert()
            alert.alertWith("Oopss..", message: "Your password doesn't match", topLabelColor: UIColor.white, messageLabelColor: UIColor.white, backgroundColor: UIColor.red, image: nil)
//        } else if old password not correct { }
        } else {
            guard let newPassword = txtNewPassword.text else { return }
            submitChangePassword(newPassword: newPassword)
        }
    }
    
    func submitChangePassword(newPassword: String) {
        let params = [
            "email": userDefault().getEmailUser(),
            "new_password": newPassword,
            "token": userDefault().getToken()
            ] as [String : Any]
        HTTPHelper.shared.requestAPI(url: Constants.ServicesAPI.Product.favourite, param: params, method: HTTPMethodHelper.post) { [weak self] (success, json) in
            guard let ws = self else { return }
            let data = ProductListModelBaseClass(json: json ?? "")
            if data.message?.lowercased() == "success" {
                let rect = CGRect(x: 0, y: 0, width: ws.view.frame.width, height: ws.view.frame.height + 52)
                let succesEditing = SuccessEditing.init(frame: rect)
                succesEditing.delegate = self
                succesEditing.successType(type: .password)
                succesEditing.show(animated: true)
            } else {
                print(data.displayMessage ?? "")
            }
        }
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
