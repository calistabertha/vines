//
//  EditProfileViewController.swift
//  Vines
//
//  Created by Calista Bertha on 06/01/19.
//  Copyright © 2019 Calista Bertha. All rights reserved.
//

import UIKit

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
    
     var userData: LoginModelUserData?
    override func viewDidLoad() {
        super.viewDidLoad()
        generateNavBarWithBackButton(titleString: "EDIT PROFILE", viewController: self, isRightBarButton: false)
        btnSave.layer.cornerRadius = 5
        viewUpload.layer.cornerRadius = viewUpload.frame.height / 2
        setupProfile()
        
        NotificationCenter .default .addObserver(self, selector: #selector(keyboardDidShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter .default .addObserver(self, selector: #selector(keyboardDidHide), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
        
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
        imgProfile.af_setImage(withURL: URL(string: userData?.foto ?? "")!, placeholderImage: UIImage(named: "placeholder")) { [weak self] image in
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
        print("biirrth \(birth.getBithdateString())")
      //  birthdate = birth.getBithdateString()
        tableView.reloadData()
        
    }
    
    @objc func keyboardDidShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let keyboardHeight = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size.height {
                tableView.contentInset = UIEdgeInsetsMake(0, 0, keyboardHeight, 0)
                //scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, keyboardHeight, 0)
                
            }
        }
    }
    
    @objc func keyboardDidHide(notification: NSNotification) {
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    override func backButtonDidPush() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cameraButtonDidPush(_ sender: Any) {
    }
    
    @IBAction func uploadPictureButtonDidPush(_ sender: Any) {
    }
    
    @IBAction func dateOfBirthButtonDidPush(_ sender: UIButton) {
        
    }
    
    @IBAction func saveButtonDidPush(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        let rect = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height + 52)
        let succesEditing = SuccessEditing.init(frame: rect)
        succesEditing.delegate = self
        succesEditing.successType(type: .profile)
        succesEditing.show(animated: true)
    }
    
}

extension EditProfileViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtDay || textField == txtMonth || textField == txtYear{
            let picker = UIDatePicker()
            picker.addTarget(self, action: #selector(birthdateChanged(_:)), for: UIControlEvents.valueChanged)
            picker.datePickerMode = .date
            
            let calendar = Calendar.current
            var comps = DateComponents()
            let maxDate = calendar.date(byAdding: comps, to: Date())
            comps.year = 2009
            picker.maximumDate = maxDate
      
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
