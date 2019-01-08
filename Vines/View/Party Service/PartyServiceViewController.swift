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
    var birthdate: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateNavBarWithBackButton(titleString: "PARTY SERVICE", viewController: self, isRightBarButton: false)
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
        birthdate = birth.getBithdateString()
        tableView.reloadData()
    }
    
    override func backButtonDidPush() {
        navigationController?.popViewController(animated: true)
    }
}

extension PartyServiceViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 5
        case 2:
            return 4
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

            return 44
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 3{
            return 36
        }else{
            return 56
        }
    }
}

extension PartyServiceViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: HeaderSectionStoreTableViewCell.identifier) as! HeaderSectionStoreTableViewCell
        cell.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        switch section {
        case 0:
            cell.lblTitle.text = "PERSONAL INFORMATION"
            return cell
        case 1:
            cell.lblTitle.text = "PARTY INFORMATION"
            return cell
        case 2:
            cell.lblTitle.text = "LIQUOR SELECTION"
            return cell
        default:
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row{
            case 0:
                return GeneralInformationTableViewCell.configure(context: self, tableView: tableView, indexPath: indexPath, object: "")
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: PersonalInformationTableViewCell.identifier, for: indexPath) as! PersonalInformationTableViewCell
                cell.textField.placeholder = "Email Address"
                cell.textField.keyboardType = .emailAddress
                cell.textField.delegate = self
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: PersonalInformationTableViewCell.identifier, for: indexPath) as! PersonalInformationTableViewCell
                cell.textField.placeholder = "Phone Number"
                cell.textField.keyboardType = .phonePad
                cell.textField.delegate = self
                return cell
            default:
                return UITableViewCell()
            }
        case 1:
            switch indexPath.row{
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: PersonalInformationTableViewCell.identifier, for: indexPath) as! PersonalInformationTableViewCell
                cell.textField.placeholder = "Party Theme"
                cell.textField.delegate = self
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: PersonalInformationTableViewCell.identifier, for: indexPath) as! PersonalInformationTableViewCell
                cell.textField.placeholder = "Locations"
                cell.textField.delegate = self
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: PersonalInformationTableViewCell.identifier, for: indexPath) as! PersonalInformationTableViewCell
                cell.textField.placeholder = "Budget on this party (Rp)"
                cell.textField.delegate = self
                return cell
            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: PersonalInformationTableViewCell.identifier, for: indexPath) as! PersonalInformationTableViewCell
                cell.textField.placeholder = "Attendance"
                cell.textField.delegate = self
                return cell
            case 4:
                let cell = tableView.dequeueReusableCell(withIdentifier: PersonalInformationTableViewCell.identifier, for: indexPath) as! PersonalInformationTableViewCell
                if birthdate == nil {
                    cell.textField.placeholder = "Date"
                }else {
                    cell.textField.text = birthdate
                }
                
                cell.textField.delegate = self
                cell.textField.tag = 10
                return cell
            default:
                return UITableViewCell()
            }
        case 2:
            switch indexPath.row{
            case 0:
                return LiquorOptionTableViewCell.configure(context: self, tableView: tableView, indexPath: indexPath, object: "")
            case 1:
                return LiquorOptionTableViewCell.configure(context: self, tableView: tableView, indexPath: indexPath, object: "")
            case 2:
                return LiquorOptionTableViewCell.configure(context: self, tableView: tableView, indexPath: indexPath, object: "")
            case 3:
                return FooterButtonTableViewCell.configure(context: self, tableView: tableView, indexPath: indexPath, object: "")
            default:
                return UITableViewCell()
            }
        default:
            return UITableViewCell()
        }
    }
}
extension PartyServiceViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 10 {
            let picker = UIDatePicker()
            picker.addTarget(self, action: #selector(birthdateChanged(_:)), for: UIControlEvents.valueChanged)
            picker.datePickerMode = .date
            textField.inputView = picker
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

