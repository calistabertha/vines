//
//  ForgotPasswordViewController.swift
//  Vines
//
//  Created by Calista Bertha on 09/12/18.
//  Copyright © 2018 Calista Bertha. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: VinesViewController {
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "ForgotPasswordViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var btnReset: UIButton!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    private func setupView() {
        spinner.isHidden = true
        btnReset.layer.cornerRadius = 5
        generateNavBarWithBackButton(titleString: "", viewController: self, isRightBarButton: false, isNavbarColor: false)
    }
    
    override func backButtonDidPush() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func resetButtonDidPush(_ sender: Any) {
        spinner.isHidden = false
        spinner.startAnimating()
        let params = [
            "email": txtEmail.text ?? ""
        ]
        HTTPHelper.shared.requestAPI(url: Constants.ServicesAPI.User.forgotPassword, param: params, method: HTTPMethodHelper.post) { (success, json) in
            let data = LoginModelBaseClass(json: json ?? "")
            if success {
                let alert = JDropDownAlert()
                alert.alertWith("Success", message: "Check your email to reset your password", topLabelColor: UIColor.white, messageLabelColor: UIColor.white, backgroundColor: UIColor(red: 76/255, green: 188/255, blue: 30/255, alpha: 1), image: nil)
                self.navigationController?.popViewController(animated: true)
            } else {
                let alert = JDropDownAlert()
                alert.alertWith("Oopss..", message: data.displayMessage, topLabelColor: UIColor.white, messageLabelColor: UIColor.white, backgroundColor: UIColor(red: 125/255, green: 6/255, blue: 15/255, alpha: 1), image: nil)
                
            }
            self.spinner.stopAnimating()
            self.spinner.isHidden = true
         
        }
    }
}
