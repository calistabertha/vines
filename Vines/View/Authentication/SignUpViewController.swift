//
//  SignUpViewController.swift
//  Vines
//
//  Created by Calista Bertha on 09/12/18.
//  Copyright © 2018 Calista Bertha. All rights reserved.
//

import UIKit

class SignUpViewController: VinesViewController {
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "SignUpViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var viewUploadPicture: UIView!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    private func setupView() {
        btnSignUp.layer.cornerRadius = 5
        generateNavBarWithBackButton(titleString: "", viewController: self, isRightBarButton: false)
    }
    
    override func backButtonDidPush() {
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func uploadPictureButtonDidPush(_ sender: Any) {
    }
    
    @IBAction func showPasswordButtonDidPush(_ sender: Any) {
        self.txtPassword.isSecureTextEntry = !self.txtPassword.isSecureTextEntry
    }
    
    @IBAction func showConfirmButtonDidPush(_ sender: Any) {
        self.txtConfirmPassword.isSecureTextEntry = !self.txtConfirmPassword.isSecureTextEntry
    }
    
    @IBAction func signUpButtonDidPush(_ sender: Any) {
        let params = [
            "fullname": self.txtFirstName.text! + self.txtLastName.text!,
            "email": self.txtEmail.text!,
            "password": self.txtPhoneNumber.text!,
            "phone": self.txtPhoneNumber.text!,
            "token_id":"12345jjkkllasdffnnnnnnnnnnnnnnn",
            "longitude":"-6.2732980",
            "latitude":"106.8694690"
        ]
        
        HTTPHelper.shared.requestAPI(url: Constants.ServicesAPI.User.register, param: params, method: HTTPMethodHelper.post) { (success, json) in
            let data = RegisterModelBaseClass(json: json!)
            if success {
                print(data.data ?? "")
            } else {
                print(data.data ?? "")
            }
        }
    }
    @IBAction func signInButtonDidPush(_ sender: Any) {
    }
}
