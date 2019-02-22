//
//  PartyServiceViewController.swift
//  Vines
//
//  Created by Calista Bertha on 28/12/18.
//  Copyright © 2018 Calista Bertha. All rights reserved.
//

import UIKit
import iCarousel

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
    @IBOutlet weak var carouselView: iCarousel!
    
    var category: [String] = []
    var packageList: [PartyModelData] = []
    var packageID: Int?
    
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateNavBarWithBackButton(titleString: "PARTY SERVICE", viewController: self, isRightBarButton: false, isNavbarColor: true)
        btnSolveParty.layer.cornerRadius = 5
        fetchPackage()
        setupCarousel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        timer = Timer.scheduledTimer(
            timeInterval: 2,
            target: self,
            selector: #selector(nextBanner),
            userInfo: nil,
            repeats: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer?.invalidate()
        timer = nil
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
    
    func fetchPackage() {
        let params = [
            "limit": "10",
            "offset": "0"
            ] as [String : Any]
        HTTPHelper.shared.requestAPI(url: Constants.ServicesAPI.Party.package, param: params, method: HTTPMethodHelper.post) { (success, json) in
            let data = PartyModelBaseClass(json: json ?? "")
            if data.message == "Success" {
                self.packageList = data.data ?? []
                self.carouselView.reloadData()
                self.tableView.reloadData()
            } else {
                print(data.displayMessage!)
            }
        }
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
            "category": stri,
            "package_id" : packageID ?? 0
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
        
        if textField == txtPartyTheme{
            let picker = UIPickerView()
            picker.delegate = self
            picker.dataSource = self
            txtPartyTheme.inputView = picker
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension PartyServiceViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return packageList[row].packageName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txtPartyTheme.text = packageList[row].packageName
        packageID = packageList[row].packageID
    }
}

extension PartyServiceViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return packageList.count
    }
}

extension PartyServiceViewController: iCarouselDelegate, iCarouselDataSource {
    @objc func nextBanner() {
        carouselView.scroll(byNumberOfItems: 1, duration: 1.0)
    }
    
    func setupCarousel() {
        carouselView.type = .linear
        carouselView.isPagingEnabled = true
        carouselView.bounces = false
        carouselView.stopAtItemBoundary = true
        carouselView.backgroundColor = UIColor.clear
    }
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return self.packageList.count
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if option == .wrap {
            return 1
        } else {
            return value
        }
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let view: BannerView = BannerView.instantiateFromNib()
        let data = self.packageList[index]
        view.frame = CGRect(x: 0, y: 0, width: self.carouselView.bounds.width, height: self.carouselView.bounds.height)
        view.backgroundColor = UIColor.clear
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.bannerImage.af_setImage(withURL: URL(string: data.image!)!, placeholderImage: UIImage(named: "placeholder")) { image in
            if let img = image.value {
                view.bannerImage.image = img
            } else {
                view.bannerImage.image = UIImage(named: "placeholder")
            }
        }
        return view
    }

}

