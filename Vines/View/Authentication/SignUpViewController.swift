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
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var viewProfile: UIView!
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
        viewUploadPicture.layer.cornerRadius = viewUploadPicture.frame.height / 2
        viewProfile.layer.cornerRadius = viewProfile.frame.width / 2
        btnSignUp.layer.cornerRadius = 5
        generateNavBarWithBackButton(titleString: "", viewController: self, isRightBarButton: false, isNavbarColor: false)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    override func backButtonDidPush() {
        navigationController?.popViewController(animated: true)
        
    }
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
        
    }
    
    @IBAction func uploadPictureButtonDidPush(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: {
            (action) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .camera
                imagePicker.allowsEditing = true
                self.present(imagePicker, animated: true, completion: nil)
            }
        }))
        alert.addAction(UIAlertAction(title: "Choose Photo", style: .default, handler: {
            (action) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary){
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .photoLibrary
                imagePicker.allowsEditing = true
                self.present(imagePicker, animated: true, completion: nil)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    
    }
    
    @IBAction func showPasswordButtonDidPush(_ sender: Any) {
        self.txtPassword.isSecureTextEntry = !self.txtPassword.isSecureTextEntry
    }
    
    @IBAction func showConfirmButtonDidPush(_ sender: Any) {
        self.txtConfirmPassword.isSecureTextEntry = !self.txtConfirmPassword.isSecureTextEntry
    }
    
    @IBAction func signUpButtonDidPush(_ sender: Any) {
        spinner.isHidden = false
        spinner.startAnimating()
        if let imageData = UIImageJPEGRepresentation(self.imgProfile.image ?? UIImage(named: "placeholderProfile")!, 0.5) {
            let params = [
                "fullname": self.txtFirstName.text! + self.txtLastName.text!,
                "email": self.txtEmail.text!,
                "password": self.txtPassword.text!,
                "phone": self.txtPhoneNumber.text!,
                "image": imageData,
                "token_id":"12345jjkkllasdffnnnnnnnnnnnnnnn",
                "longitude":"-6.2732980",
                "latitude":"106.8694690"
            ] as [String : Any]
            
            HTTPHelper.shared.requestFormData(url: Constants.ServicesAPI.User.register, param: params, method: .post) { (success, code, json) in
                let data = RegisterModelBaseClass(json: json ?? "")
                if success {
                    let alert = JDropDownAlert()
                    alert.alertWith("Success", message: "Register success", topLabelColor: UIColor.white, messageLabelColor: UIColor.white, backgroundColor: UIColor(red: 76/255, green: 188/255, blue: 30/255, alpha: 1), image: nil)
                    self.navigationController?.popViewController(animated: true)
                    print(data.data ?? "")
                } else {
                    let alert = JDropDownAlert()
                    alert.alertWith("Oopss..", message: "Register failed", topLabelColor: UIColor.white, messageLabelColor: UIColor.white, backgroundColor: UIColor(red: 125/255, green: 6/255, blue: 15/255, alpha: 1), image: nil)
                    print(data.data ?? "")
                }
            }
        }
        self.spinner.isHidden = true
        self.spinner.stopAnimating()
    }
    
    @IBAction func signInButtonDidPush(_ sender: Any) {
         navigationController?.popViewController(animated: true)
    }
}

extension SignUpViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        picker.dismiss(animated: true, completion: nil)
        
        self.imgProfile.image = image

        
//        if let img = image {
//            ProfileController.shared.uploadImage(images: img, completion: { (success, code, message, result) in
//                if success {
//                    let alert = JDropDownAlert()
//                    alert.alertWith("Success", message: message, topLabelColor: UIColor.white, messageLabelColor: UIColor.white, backgroundColor: UIColor.black, image: nil)
//
//                }else{
//                    if code == HTTPCode.failure {
//                        let alert = JDropDownAlert()
//                        alert.alertWith("Failed", message: message, topLabelColor: UIColor.white, messageLabelColor: UIColor.white, backgroundColor: UIColor.black, image: nil)
//                        print("Berhasil konek ke server tapi failure")
//                    } else {
//                        let alert = JDropDownAlert()
//                        alert.alertWith("Please Check Your Connection", message: nil, topLabelColor:
//                            UIColor.white, messageLabelColor: UIColor.white, backgroundColor: UIColor.red, image: nil)
//                        print("Gagal koneksi ke internet atau response yg diterima tidak sesuai")
//                    }
//
//
//                }
//            })
//        }
    }
}
