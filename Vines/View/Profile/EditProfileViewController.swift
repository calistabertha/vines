//
//  EditProfileViewController.swift
//  Vines
//
//  Created by Calista Bertha on 06/01/19.
//  Copyright © 2019 Calista Bertha. All rights reserved.
//

import UIKit
import AlamofireImage

class EditProfileViewController: VinesViewController {

    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtEmailAddress: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var viewUpload: UIView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var txtDay: UITextField!
    @IBOutlet weak var txtMonth: UITextField!
    @IBOutlet weak var txtYear: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
     var userData: LoginModelUserData?
    override func viewDidLoad() {
        super.viewDidLoad()
        generateNavBarWithBackButton(titleString: "EDIT PROFILE", viewController: self, isRightBarButton: false, isNavbarColor: true)
        btnSave.layer.cornerRadius = 5
        viewUpload.layer.cornerRadius = viewUpload.frame.height / 2
        imgProfile.layer.cornerRadius = imgProfile.frame.height / 2
        setupProfile()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(tap)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
        
    }
    
    func setupProfile() {
        self.spinner.isHidden = true
        let fullname = userData?.fullname ?? ""
        var components = fullname.components(separatedBy: " ")
        if(components.count > 0)
        {
            let firstName = components.removeFirst()
            let lastName = components.joined(separator: " ")
            txtFirstName.text = firstName.capitalized
            txtLastName.text = lastName.capitalized
        }
        txtEmailAddress.text = userData?.email ?? ""
        txtPhoneNumber.text = userData?.phone ?? ""
        
        let birth = userData?.dob ?? ""
        if birth == ""{
            txtDay.text = ""
            txtMonth.text = ""
            txtYear.text = ""
        }else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            let date = dateFormatter.date(from: birth)
            dateFormatter.dateFormat = "dd"
            txtDay.text = dateFormatter.string(from: date!)
            
            dateFormatter.dateFormat = "MMMM"
            txtMonth.text = dateFormatter.string(from: date!)
            
            dateFormatter.dateFormat = "yyyy"
            txtYear.text = dateFormatter.string(from: date!)
            
        }
        
        let filter = AspectScaledToFillSizeWithRoundedCornersFilter(
            size: imgProfile.frame.size,
            radius: 70.0
        )
        imgProfile.af_setImage(withURL: URL(string: userData?.foto ?? "")!, placeholderImage: UIImage(named: "placeholder"), filter: filter)
            { [weak self] image in
            guard let ws = self else { return }
            if let img = image.value {
                ws.imgProfile.image = img
                
            } else {
                ws.imgProfile.image = UIImage(named: "placeholder")
            }
        }
    }
    
    @objc func birthdateChanged(_ sender: UIDatePicker) {
        let birth = sender.date.getStringDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let date = dateFormatter.date(from: birth)
        dateFormatter.dateFormat = "dd"
        txtDay.text = dateFormatter.string(from: date!)
        
        dateFormatter.dateFormat = "MMMM"
        txtMonth.text = dateFormatter.string(from: date!)
        
        dateFormatter.dateFormat = "yyyy"
        txtYear.text = dateFormatter.string(from: date!)
        tableView.reloadData()
        
    }
    
    override func backButtonDidPush() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cameraButtonDidPush(_ sender: Any) {
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
    
    @IBAction func saveButtonDidPush(_ sender: Any) {
        spinner.isHidden = false
        spinner.startAnimating()
       // if let imageData = UIImageJPEGRepresentation(self.imgProfile.image ?? UIImage(named: "placeholderProfile")!, 0.5) {
        let imageData = UIImageJPEGRepresentation(self.imgProfile.image ?? UIImage(named: "placeholderProfile")!, 0.5)
            let params = [
                "user_id": userDefault().getUserID(),
                "first_name": self.txtFirstName.text!,
                "last_name": self.txtLastName.text!,
                "email": self.txtEmailAddress.text!,
                "phone": self.txtPhoneNumber.text!,
                "image": imageData ?? "",
                "dob": "",
                "token": userDefault().getToken(),
                ] as [String : Any]
            
            HTTPHelper.shared.requestFormData(url: Constants.ServicesAPI.User.editProfile, param: params, method: .post) { (success, code, json) in
                let data = LoginModelBaseClass(json: json ?? "")
                if success {
                    self.navigationController?.popViewController(animated: true)
                    let rect = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height + 52)
                    let succesEditing = SuccessEditing.init(frame: rect)
                    succesEditing.delegate = self
                    succesEditing.successType(type: .profile)
                    succesEditing.show(animated: true)
                } else {
                    let alert = JDropDownAlert()
                    alert.alertWith("Oopss..", message: "Edit profile failed", topLabelColor: UIColor.white, messageLabelColor: UIColor.white, backgroundColor: UIColor(red: 125/255, green: 6/255, blue: 15/255, alpha: 1), image: nil)
                    print(data.data ?? "")
                }
            }
       // }
        self.spinner.isHidden = true
        self.spinner.stopAnimating()
    }
    
}

extension EditProfileViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtDay || textField == txtMonth || textField == txtYear{
            let picker = UIDatePicker()
            picker.addTarget(self, action: #selector(birthdateChanged(_:)), for: UIControlEvents.valueChanged)
            picker.datePickerMode = .date
            
            let calendar = Calendar.current
            let backDate = calendar.date(byAdding: .year, value: -10, to: Date())
            picker.maximumDate = backDate!
            txtDay.inputView = picker
            txtMonth.inputView = picker
            txtYear.inputView = picker
        }
       
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension EditProfileViewController: SuccessEditingViewDelegate{
    func continueButtonDidPush(sender: UIButton, view: SuccessEditing) {
        view.dismiss(animated: true)
    }

}

extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        picker.dismiss(animated: true, completion: nil)
        viewUpload.layer.cornerRadius = viewUpload.frame.height / 2
        self.imgProfile.layer.cornerRadius = self.imgProfile.frame.height / 2
        self.imgProfile.image = image
        //image to data
    }
}
