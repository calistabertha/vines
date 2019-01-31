//
//  PartyServiceViewController.swift
//  Vines
//
//  Created by Calista Bertha on 28/12/18.
//  Copyright © 2018 Calista Bertha. All rights reserved.
//

import UIKit

class PartyServiceViewController: VinesViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var txtFirstname: UITextField!
    @IBOutlet weak var txtLastname: UITextField!
    @IBOutlet weak var txtEmailAddress: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var txtPartyTheme: UITextField!
    @IBOutlet weak var txtLocations: UITextField!
    @IBOutlet weak var txtBudget: UITextField!
    @IBOutlet weak var txtAttendess: UITextField!
    
    @IBOutlet weak var txtDate: UITextField!
    
    
    var birthdate: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateNavBarWithBackButton(titleString: "PARTY SERVICE", viewController: self, isRightBarButton: false, isNavbarColor: true)
        tableView.register(HeaderSectionStoreTableViewCell.nib, forCellReuseIdentifier: HeaderSectionStoreTableViewCell.identifier)
        tableView.register(PersonalInformationTableViewCell.nib, forCellReuseIdentifier: PersonalInformationTableViewCell.identifier)
        tableView.register(GeneralInformationTableViewCell.nib, forCellReuseIdentifier: GeneralInformationTableViewCell.identifier)
        tableView.register(LiquorOptionTableViewCell.nib, forCellReuseIdentifier: LiquorOptionTableViewCell.identifier)
        tableView.register(FooterButtonTableViewCell.nib, forCellReuseIdentifier: FooterButtonTableViewCell.identifier)
        
        NotificationCenter .default .addObserver(self, selector: #selector(keyboardDidShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter .default .addObserver(self, selector: #selector(keyboardDidHide), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @objc func keyboardDidShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let keyboardHeight = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size.height {
                tableView.contentInset = UIEdgeInsetsMake(0, 0, keyboardHeight, 0)
            }
        }
    }
    
    @objc func keyboardDidHide(notification: NSNotification) {
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    @objc func birthdateChanged(_ sender: UIDatePicker) {
        let birth = sender.date.getStringDate()
        txtDate.text = birth.getBithdateString()
        tableView.reloadData()
    }
    
    override func backButtonDidPush() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func solvePartyButtonDidPush(_ sender: Any) {
        print("solve")
        guard let fname = txtFirstname.text else {return}
        guard let lname = txtLastname.text else {return}
        guard let email = txtEmailAddress.text else {return}
        guard let phone = txtPhoneNumber.text else {return}
        guard let location = txtLastname.text else {return}
        let params = [
            "first_name": fname,
            "last_name": lname,
            "email": "jamblang@yahoo.com",
            "phone": "081245677876",
            "location": "jakarta",
            "budget": "1000000",
            "person": "10",
            "date_party": "2019-02-20",
            "category": "Wine"
            ] as [String : Any]
        
        HTTPHelper.shared.requestAPI(url: Constants.ServicesAPI.Party.submit, param: params, method: HTTPMethodHelper.post) { (success, json) in
            if success {
                let alert = JDropDownAlert()
                alert.alertWith("Success", message: "We will solve your party", topLabelColor: UIColor.white, messageLabelColor: UIColor.white, backgroundColor: UIColor(red: 76/255, green: 188/255, blue: 30/255, alpha: 1), image: nil)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}

extension PartyServiceViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtDate {
            let picker = UIDatePicker()
            picker.addTarget(self, action: #selector(birthdateChanged(_:)), for: UIControlEvents.valueChanged)
            let calendar = Calendar.current
            let backDate = calendar.date(byAdding: .year, value: 0, to: Date())
            picker.minimumDate = backDate!
            picker.datePickerMode = .date
            txtDate.inputView = picker
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

