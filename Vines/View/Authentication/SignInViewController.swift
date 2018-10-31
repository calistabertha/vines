//
//  SignInViewController.swift
//  Vines
//
//  Created by Calista Bertha on 07/10/18.
//  Copyright © 2018 Calista Bertha. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!{
        didSet{
            txtPassword.delegate = self
        }
    }
    @IBOutlet weak var btnSignIn: UIButton!
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
        btnSignIn.layer.cornerRadius = 5
    }
    
    @IBAction func loginButtonDidPush(_ sender: Any) {
        let storyboard = UIStoryboard(name: Constants.StoryboardReferences.home, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: Constants.ViewControllerID.Homepage.home)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func showPasswordButtonDidPush(_ sender: Any) {
        self.txtPassword.isSecureTextEntry = !self.txtPassword.isSecureTextEntry
    }
    
    @IBAction func signUpButtonDidPush(_ sender: Any) {
        let storyboard = UIStoryboard(name: Constants.StoryboardReferences.authentication, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: Constants.ViewControllerID.Authentication.signUp)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func forgotButtonDidPush(_ sender: Any) {
        let storyboard = UIStoryboard(name: Constants.StoryboardReferences.authentication, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: Constants.ViewControllerID.Authentication.forgot)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension SignInViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
