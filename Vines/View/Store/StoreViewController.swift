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

    // Still dummy data
    var featuredList: [Any] = []
    // If you want to test responsive, you could change item count inside this below array.
    // Hope everything is fine wkwk
    var specialOfferList: [Any] = [0,0,0,0,0,0,0,0]
    var productList: [Any] = [0,0,0,0,0]
    
    var collectionItemSize: CGSize = CGSize(width: 0, height: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateNavBarWithBackButton(titleString: storeName ?? "", viewController: self, isRightBarButton: false)
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        calculateSize()
        // fetchData
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
    
    func calculateSize() {
        let width = ((self.view.frame.width - 48) / 2) - 8
        let height = width * 1.8
        self.collectionItemSize = CGSize(width: width, height: height)
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
            return CGFloat.leastNormalMagnitude
        }else{
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 211
        } else if indexPath.section == 1 {
            return collectionItemSize.height
        } else if indexPath.section == 2 {
            return (collectionItemSize.height * CGFloat(halfCeil(specialOfferList.count)))
        } else {
            return (collectionItemSize.height * CGFloat(halfCeil(productList.count)))
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
            let cell = FeatureProductTableViewCell.configure(context: self, tableView: tableView, indexPath: indexPath, object: "") as! FeatureProductTableViewCell
            cell.size = collectionItemSize
            return cell
        }else if indexPath.section == 2 {
            let cell = ProductTableViewCell.configure(context: self, tableView: tableView, indexPath: indexPath, object: specialOfferList) as! ProductTableViewCell
            cell.size = collectionItemSize
            return cell
        }else if indexPath.section == 3 {
            let cell = ProductTableViewCell.configure(context: self, tableView: tableView, indexPath: indexPath, object: productList) as! ProductTableViewCell
            cell.size = collectionItemSize
            return cell
        }
        
        return UITableViewCell()
    }

}

