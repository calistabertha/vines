//
//  SignInViewController.swift
//  Vines
//
//  Created by Calista Bertha on 09/12/18.
//  Copyright © 2018 Calista Bertha. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "SignInViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!{
        didSet{
            txtPassword.delegate = self
        }
    }
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupView() {
        navigationController?.navigationBar.isHidden = true
        spinner.isHidden = true
        btnSignIn.layer.cornerRadius = 5
    }
    
    @IBAction func loginButtonDidPush(_ sender: Any) {
        if let email = self.txtEmail.text, let password = self.txtPassword.text {
            if !email.isValidEmail() {
                print("Email not valid")
            } else {
                spinner.isHidden = false
                spinner.startAnimating()
                callAPILogin(email: email, password: password)
            }
        }
    }
    
    @IBAction func showPasswordButtonDidPush(_ sender: Any) {
        self.txtPassword.isSecureTextEntry = !self.txtPassword.isSecureTextEntry
    }
    
    @IBAction func signUpButtonDidPush(_ sender: Any) {
        let vc = SignUpViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func forgotButtonDidPush(_ sender: Any) {
        let vc = ForgotPasswordViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func callAPILogin(email: String, password: String) {
        let params = [
            "email": email,
            "password": password
        ]
        HTTPHelper.shared.requestAPI(url: Constants.ServicesAPI.User.login, param: params, method: HTTPMethodHelper.post) { (success, json) in
            let data = LoginModelBaseClass(json: json ?? "")
            if success {
                if let token = data.data?.token, let datas = data.data, let id = data.data?.userData?[0].userId {
                    userDefault().setToken(token: token)
                    userDefault().saveUser(user: datas)
                    userDefault().setUserID(userID: id)
                    
                    let vc = HomeViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    print("error login")
                }
            } else {
                let alert = JDropDownAlert()
                alert.alertWith("Oopss..", message: data.displayMessage, topLabelColor: UIColor.white, messageLabelColor: UIColor.white, backgroundColor: UIColor(red: 125/255, green: 6/255, blue: 15/255, alpha: 1), image: nil)
                
            }
            self.spinner.isHidden = true
            self.spinner.stopAnimating()
        }
    }
}

extension SignInViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
