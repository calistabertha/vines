//
//  SignUpViewController.swift
//  Vines
//
//  Created by Calista Bertha on 07/10/18.
//  Copyright © 2018 Calista Bertha. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var viewUploadPicture: UIView!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    
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
        btnSignUp.layer.cornerRadius = 5
    }
    
    @IBAction func backButtonDidPush(_ sender: Any) {
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
    
}
