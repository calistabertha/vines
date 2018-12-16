//
//  ListProductViewController.swift
//  Vines
//
//  Created by Calista Bertha on 08/12/18.
//  Copyright © 2018 Calista Bertha. All rights reserved.
//

import UIKit

class StoreViewController: VinesViewController {
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "StoreViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewCart: UIView!
    
    var storeName: String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateNavBarWithBackButton(titleString: storeName ?? "", viewController: self, isRightBarButton: false)
        setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    
    override func backButtonDidPush() {
        navigationController?.popViewController(animated: true)
    }
    
    func setupView() {
        //tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(HeaderStoreTableViewCell.nib, forCellReuseIdentifier: HeaderStoreTableViewCell.identifier)
        tableView.register(FeatureProductTableViewCell.nib, forCellReuseIdentifier: FeatureProductTableViewCell.identifier)
        tableView.register(ProductTableViewCell.nib, forCellReuseIdentifier: ProductTableViewCell.identifier)
        tableView.register(HeaderSectionStoreTableViewCell.nib, forCellReuseIdentifier: HeaderSectionStoreTableViewCell.identifier)
        
        viewCart.layer.cornerRadius = viewCart.layer.frame.width / 2
    }
    
    @IBAction func searchButtonDidPush(_ sender: Any) {
        
    }
    
}

extension StoreViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }else{
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 211
        }else{
            if indexPath.row == 0 {
                return 280
            }else{
                return 560
            }
        }
    }
}

extension StoreViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: HeaderSectionStoreTableViewCell.identifier) as! HeaderSectionStoreTableViewCell
            cell.lblTitle.text = "FEATURED PRODUCT"
            return cell
            
        }else if section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: HeaderSectionStoreTableViewCell.identifier) as! HeaderSectionStoreTableViewCell
            cell.lblTitle.text = "SPECIAL OFFERS"
            return cell
            
        }else if section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: HeaderSectionStoreTableViewCell.identifier) as! HeaderSectionStoreTableViewCell
            cell.lblTitle.text = "PRODUCT"
            return cell
        }
        
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            return HeaderStoreTableViewCell.configure(context: self, tableView: tableView, indexPath: indexPath, object: "")
            
        }else if indexPath.section == 1 {
              return FeatureProductTableViewCell.configure(context: self, tableView: tableView, indexPath: indexPath, object: "")
            
        }else if indexPath.section == 2 {
            return ProductTableViewCell.configure(context: self, tableView: tableView, indexPath: indexPath, object: "")
            
        }else if indexPath.section == 3 {
             return ProductTableViewCell.configure(context: self, tableView: tableView, indexPath: indexPath, object: "")
        }
        
        return UITableViewCell()
    }

}

