//
//  DetailProductViewController.swift
//  Vines
//
//  Created by Calista Bertha on 14/12/18.
//  Copyright © 2018 Calista Bertha. All rights reserved.
//

import UIKit

class DetailProductViewController: VinesViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnAddItem: UIButton!
    @IBOutlet weak var btnBuyProduct: UIButton!
    @IBOutlet weak var viewOption: UIView!
    @IBOutlet weak var viewButton: UIView!
    @IBOutlet weak var btnProduct: UIButton!
    
    var titleText = ""
    
    var similiarList: [ProductListModelData] = []
    var product: ProductListModelData?
    
    var collectionItemSize: CGSize = CGSize(width: 0, height: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        generateNavBarWithBackButton(titleString: titleText, viewController: self, isRightBarButton: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchSimiliarList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    override func backButtonDidPush() {
        navigationController?.popViewController(animated: true)
    }
    
    func setupView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(HeaderProductTableViewCell.nib, forCellReuseIdentifier: HeaderProductTableViewCell.identifier)
        tableView.register(DescriptionTableViewCell.nib, forCellReuseIdentifier: DescriptionTableViewCell.identifier)
        tableView.register(HeaderSectionStoreTableViewCell.nib, forCellReuseIdentifier: HeaderSectionStoreTableViewCell.identifier)
        tableView.register(ProductTableViewCell.nib, forCellReuseIdentifier: ProductTableViewCell.identifier)
        
        collectionItemSize = calculateSize()
        
        btnAddItem.layer.cornerRadius = 5
        btnAddItem.layer.borderColor = UIColor.init(red: 151/255, green: 151/255, blue: 151/255, alpha: 1).cgColor
        btnAddItem.layer.borderWidth = 1
        btnBuyProduct.layer.cornerRadius = 5
        
        /*
         viewButton.isHidden = false
         btnProduct.layer.cornerRadius = 5
         btnProduct.layer.borderColor = UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 1).cgColor
         btnProduct.setTitle("OUT OF STOCK", for: .normal)
         btnProduct.setTitleColor(UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 1), for: .normal)
         */
    }
    
    @IBAction func addItemButtonDidPush(_ sender: Any) {
        viewButton.isHidden = false
        btnProduct.layer.cornerRadius = 5
        btnProduct.layer.borderWidth = 1
        btnProduct.layer.borderColor = UIColor.init(red: 151/255, green: 151/255, blue: 151/255, alpha: 1).cgColor
        btnProduct.setTitle("ADDED", for: .normal)
        btnProduct.setTitleColor(UIColor(red: 125/255, green: 6/255, blue: 15/255, alpha: 1), for: .normal)
    }

    func fetchSimiliarList() {
        let params = [
            "category_id": 2,
            "by_title": "",
            "limit": 10,
            "offset":0
            ] as [String : Any]
        HTTPHelper.shared.requestAPI(url: Constants.ServicesAPI.Product.similiar, param: params, method: HTTPMethodHelper.post) { (success, json) in
            let data = ProductListModelBaseClass(json: json!)
            if data.message == "Success", let datas = data.data {
                self.similiarList = datas
                self.tableView.reloadData()
            } else {
                print(data.displayMessage ?? "")
            }
        }
    }
    
}

extension DetailProductViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return HeaderProductTableViewCell.configure(context: self, tableView: tableView, indexPath: indexPath, object: product)
        case 1:
            return DescriptionTableViewCell.configure(context: self, tableView: tableView, indexPath: indexPath, object: product)
        case 2:
            let cell = ProductTableViewCell.configure(context: self, tableView: tableView, indexPath: indexPath, object: similiarList) as! ProductTableViewCell
            cell.size = collectionItemSize
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension DetailProductViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: HeaderSectionStoreTableViewCell.identifier) as! HeaderSectionStoreTableViewCell
        
        if section == 1 {
            cell.lblTitle.text = "PRODUCT DESCRIPTION"
            cell.layer.backgroundColor = UIColor.white.cgColor
            return cell
            
        }else if section == 2 {
            cell.lblTitle.text = "SIMILIAR PRODUCT"
            return cell
            
        }
        
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return CGFloat.leastNormalMagnitude
        }else{
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 1 {
            return 16
        }
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 2 {
            return (collectionItemSize.height * CGFloat(halfCeil(similiarList.count)))
        }
        return UITableViewAutomaticDimension
    }
}
