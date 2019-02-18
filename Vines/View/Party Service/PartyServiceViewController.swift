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
    @IBOutlet weak var btnSolveParty: UIButton!
    @IBOutlet weak var imgCheckBoxWine: UIImageView!
    @IBOutlet weak var imgCheckBoxBeer: UIImageView!
    @IBOutlet weak var imgCheckBoxSpirits: UIImageView!
    
    
    var category: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateNavBarWithBackButton(titleString: "PARTY SERVICE", viewController: self, isRightBarButton: false, isNavbarColor: true)
        btnSolveParty.layer.cornerRadius = 5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
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
        var stri: String = ""
        for item in category {
            if item == category.first {
                stri = item
            } else {
                stri += ", \(item)"
            }
        }
        guard let fname = txtFirstname.text else {return}
        guard let lname = txtLastname.text else {return}
        guard let email = txtEmailAddress.text else {return}
        guard let phone = txtPhoneNumber.text else {return}
        guard let location = txtLocations.text else {return}
        guard let budget = txtBudget.text else {return}
        guard let attendes = txtAttendess.text else {return}
        guard let date = txtDate.text?.getDateFormat() else {return}
       
        let params = [
            "first_name": fname,
            "last_name": lname,
            "email": email,
            "phone": phone,
            "location": location,
            "budget": budget,
            "person": attendes,
            "date_party": date,
            "category": stri
            ] as [String : Any]
        
        HTTPHelper.shared.requestAPI(url: Constants.ServicesAPI.Party.submit, param: params, method: HTTPMethodHelper.post) { (success, json) in
            if success {
                let alert = JDropDownAlert()
                alert.alertWith("Success", message: "We will solve your party", topLabelColor: UIColor.white, messageLabelColor: UIColor.white, backgroundColor: UIColor(red: 76/255, green: 188/255, blue: 30/255, alpha: 1), image: nil)
                self.navigationController?.popViewController(animated: true)
            }else{
                let alert = JDropDownAlert()
                alert.alertWith("Oopss..", message: "Please fill all field", topLabelColor: UIColor.white, messageLabelColor: UIColor.white, backgroundColor: UIColor(red: 125/255, green: 6/255, blue: 15/255, alpha: 1), image: nil)
            }
        }
    }
    
    @IBAction func wineButtonDidPush(_ sender: UIButton) {
        if sender.isSelected{
            imgCheckBoxWine.image = UIImage(named: "ico-checkbox-inactive")
            category.remove(at: category.count-1)
            sender.isSelected = false
        }else {
            imgCheckBoxWine.image = UIImage(named: "ico-checkbox-active")
            category.append("Wine")
            sender.isSelected = true
        }
        print("category \(category)")
    }
    
    @IBAction func beerButtonDidPush(_ sender: UIButton) {
        if sender.isSelected{
            imgCheckBoxBeer.image = UIImage(named: "ico-checkbox-inactive")
            category.remove(at: category.count-1)
            sender.isSelected = false
        }else {
            imgCheckBoxBeer.image = UIImage(named: "ico-checkbox-active")
            category.append("Beer")
            sender.isSelected = true
        }
        print("category \(category)")
    }
    
    @IBAction func spiritsButtonDidPush(_ sender: UIButton) {
        if sender.isSelected{
            imgCheckBoxSpirits.image = UIImage(named: "ico-checkbox-inactive")
            category.remove(at: category.count-1)
            sender.isSelected = false
        }else {
            imgCheckBoxSpirits.image = UIImage(named: "ico-checkbox-active")
            category.append("Spirits")
            sender.isSelected = true
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

