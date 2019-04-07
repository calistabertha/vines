//
//  FilterViewController.swift
//  Vines
//
//  Created by Calista Bertha on 22/02/19.
//  Copyright © 2019 Calista Bertha. All rights reserved.
//

import UIKit

protocol FilterDelegate: class {
    func setFilter(country: String, categoryID: Int, priceID: Int, filter: [String])
}
class FilterViewController: VinesViewController {

    @IBOutlet weak var txtType: UITextField!
    @IBOutlet weak var txtCountry: UITextField!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var btnFilter: UIButton!
    
    var countryList: [CountryModelData] = []
    var categoryList: [CategoryModelData] = []
    var priceList = [["price" : "> 10.000 - 100.000", "id": 1],
                     ["price" : "> 100.000 - 1.000.000", "id": 2],
                     ["price" : "> 1.000.000 - 5.000.000", "id": 3],
                     ["price" : "> 5.000.000 - 10.000.000 ", "id": 4],
                     ["price" : "> 10.000.000 - 20.000.000", "id": 5],
                     ["price" : "> 20.000.000", "id": "6"]] as [[String: Any]]
    var delegate: FilterDelegate?
    var categoryID: Int?
    var priceID: Int?
    var filtered: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generateNavBarWithBackButton(titleString: "FILTER", viewController: self, isRightBarButton: false, isNavbarColor: true)
        btnFilter.layer.cornerRadius = 4
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchCategory()
        fetchCountry()
    }

    override func backButtonDidPush() {
        navigationController?.popViewController(animated: true)
    }
    
    func fetchCategory() {
        HTTPHelper.shared.requestAPI(url: Constants.ServicesAPI.Filter.category, param: [:], method: HTTPMethodHelper.post) { (success, json) in
            let data = CategoryModelBaseClass(json: json ?? "")
            if data.message == "success" {
                self.categoryList = data.data ?? []
                self.tableview.reloadData()
            } else {
                print(data.displayMessage!)
            }
        }
    }
    
    func fetchCountry() {
        HTTPHelper.shared.requestAPI(url: Constants.ServicesAPI.Filter.country, param: [:], method: HTTPMethodHelper.post) { (success, json) in
            let data = CountryModelBaseClass(json: json ?? "")
            if data.message == "success" {
                self.countryList = data.data ?? []
                self.tableview.reloadData()
            } else {
                print(data.displayMessage!)
            }
        }
    }
    
    @IBAction func filterButtonDidPush(_ sender: Any) {
        delegate?.setFilter(country: txtCountry.text ?? "", categoryID: categoryID ?? 0, priceID: priceID ?? 0, filter: filtered)
        navigationController?.popViewController(animated: true)
    }
    
}

extension FilterViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtType{
            let picker = UIPickerView()
            picker.tag = 0
            picker.delegate = self
            picker.dataSource = self
            txtType.inputView = picker
            
        }else if textField == txtCountry {
            let picker = UIPickerView()
            picker.tag = 1
            picker.delegate = self
            picker.dataSource = self
            txtCountry.inputView = picker
            
        }else if textField == txtPrice {
            let picker = UIPickerView()
            picker.tag = 2
            picker.delegate = self
            picker.dataSource = self
            txtPrice.inputView = picker
        }
    }
}

extension FilterViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0 {
            return categoryList[row].name
        }else if pickerView.tag == 1 {
             return countryList[row].country
        }else if pickerView.tag == 2 {
            return priceList[row]["price"] as? String
        }
       return ""
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 {
           txtType.text = categoryList[row].name
            categoryID = categoryList[row].categoryID
            filtered.append(categoryList[row].name ?? "")
        }else if pickerView.tag == 1 {
            txtCountry.text = countryList[row].country
            filtered.append(countryList[row].country ?? "")
        }else if pickerView.tag == 2 {
            txtPrice.text = priceList[row]["price"] as? String
            priceID = priceList[row]["id"] as? Int
            filtered.append(priceList[row]["price"] as? String ?? "")
        }
    }
}

extension FilterViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            return categoryList.count
        }else if pickerView.tag == 1 {
            return countryList.count
        }else if pickerView.tag == 2 {
            return priceList.count
        }
        return 0
    }
}
