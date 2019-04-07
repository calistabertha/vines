//
//  DetailProductViewController.swift
//  Vines
//
//  Created by Calista Bertha on 14/12/18.
//  Copyright © 2018 Calista Bertha. All rights reserved.
//

import UIKit

class ProductListCollection {
    static let shared = ProductListCollection()
    var products: [ProductListModelData] = []
}

class DetailProductViewController: VinesViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnAddItem: UIButton!
    @IBOutlet weak var btnBuyProduct: UIButton!
    @IBOutlet weak var viewOption: UIView!
    @IBOutlet weak var viewButton: UIView!
    @IBOutlet weak var btnProduct: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var titleText = ""
    var similiarList: [ProductListModelData] = []
    var storeIDCode: String?
    var storeID: Int?
    var productID: Int?
    var detail: ProductListModelData?
    var size: String?
    var cartList: [ProductListModelData] = []
    var storeName: String?
    
    var collectionItemSize: CGSize = CGSize(width: 0, height: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateNavBarWithBackButton(titleString: titleText, viewController: self, isRightBarButton: true, isNavbarColor: true)
        spinner.startAnimating()
        tableView.isHidden = true
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(HeaderProductTableViewCell.nib, forCellReuseIdentifier: HeaderProductTableViewCell.identifier)
        tableView.register(DescriptionTableViewCell.nib, forCellReuseIdentifier: DescriptionTableViewCell.identifier)
        tableView.register(HeaderSectionStoreTableViewCell.nib, forCellReuseIdentifier: HeaderSectionStoreTableViewCell.identifier)
        tableView.register(ProductTableViewCell.nib, forCellReuseIdentifier: ProductTableViewCell.identifier)
        
        collectionItemSize = calculateSize()
        fetchDetail()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    override func backButtonDidPush() {
        navigationController?.popViewController(animated: true)
    }
    
    override func cartButtonDidPush() {
        let vc = ShoppingCartViewController()
        vc.storeName = storeName
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: false)
    }
    
    func setupView() {
        if detail?.stock == 0 {
            viewButton.isHidden = false
            btnProduct.layer.cornerRadius = 5
            btnProduct.layer.borderColor = UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 1).cgColor
            btnProduct.setTitle("OUT OF STOCK", for: .normal)
            btnProduct.layer.borderWidth = 1
            btnProduct.setTitleColor(UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 1), for: .normal)
            btnProduct.backgroundColor = UIColor.white
            btnProduct.isUserInteractionEnabled = false
            
        } else {
            viewButton.isHidden = true
            btnAddItem.layer.cornerRadius = 5
            btnAddItem.layer.borderColor = UIColor.init(red: 151/255, green: 151/255, blue: 151/255, alpha: 1).cgColor
            btnAddItem.layer.borderWidth = 1
            btnBuyProduct.layer.cornerRadius = 5
        }
        
        guard let _ = ProductListCollection.shared.products.first(where: { $0.productId == detail?.productId }) else {
            return
        }
        
        self.viewButton.isHidden = false
        self.btnProduct.layer.cornerRadius = 5
        self.btnProduct.layer.borderWidth = 1
        self.btnProduct.layer.borderColor = UIColor.init(red: 151/255, green: 151/255, blue: 151/255, alpha: 1).cgColor
        self.btnProduct.setTitle("ADDED", for: .normal)
        self.btnProduct.setTitleColor(UIColor(red: 125/255, green: 6/255, blue: 15/255, alpha: 1), for: .normal)
        btnProduct.isUserInteractionEnabled = false
        
    }
    
    @IBAction func addItemButtonDidPush(_ sender: Any) {
        self.addToCart(data: detail!)
    }

    @IBAction func buyProduct(_ sender: Any) {
        ProductListCollection.shared.products.append(detail!)
        let vc = ShoppingCartViewController()
        vc.storeName = storeName
        vc.storeID = storeID
        vc.delegate = self
        
        self.viewButton.isHidden = false
        self.btnProduct.layer.cornerRadius = 5
        self.btnProduct.layer.borderWidth = 1
        self.btnProduct.layer.borderColor = UIColor.init(red: 151/255, green: 151/255, blue: 151/255, alpha: 1).cgColor
        self.btnProduct.setTitle("ADDED", for: .normal)
        self.btnProduct.setTitleColor(UIColor(red: 125/255, green: 6/255, blue: 15/255, alpha: 1), for: .normal)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func fetchSimiliarList() {
        let params = [
            "category_id": detail?.categoryId ?? 0,
            "by_title": "",
            "limit": 10,
            "offset":0,
            "store_id" : storeID ?? 0,
            ] as [String : Any]
        HTTPHelper.shared.requestAPI(url: Constants.ServicesAPI.Product.similiar, param: params, method: HTTPMethodHelper.post) { (success, json) in
            let data = ProductListModelBaseClass(json: json ?? "")
            if data.message == "Success", let datas = data.data {
                self.similiarList = datas
                self.tableView.reloadData()
            } else {
                print(data.displayMessage ?? "")
            }
            self.spinner.stopAnimating()
            self.spinner.isHidden = true
        }
    }
    
    func fetchDetail (){
        let params = [
            "product_id": productID ?? 0,
            "StoreId": storeIDCode ?? "",
            "user_id": userDefault().getUserID(),
            "order_code": userDefault().getOrderCode()
            ] as [String: Any]
        HTTPHelper.shared.requestAPI(url: Constants.ServicesAPI.Product.detail, param: params, method: HTTPMethodHelper.post) { (success, json) in
             self.size = json!["data"][0]["size"][0]["name"].stringValue
            let data = ProductListModelBaseClass(json: json ?? "")
            if data.message == "success", let datas = data.data {
                self.detail = datas[0]
                self.setupView()
                self.tableView.reloadData()
                self.fetchSimiliarList()
            } else {
                print(data.displayMessage ?? "")
            }
            self.tableView.isHidden = false
            self.spinner.stopAnimating()
            self.spinner.isHidden = true
        }
    }
    
    func addToCart(data: ProductListModelData) {
            let alert = JDropDownAlert()
            alert.alertWith("Success", message: "Success add to cart", topLabelColor: UIColor.white, messageLabelColor: UIColor.white, backgroundColor: UIColor(red: 76/255, green: 188/255, blue: 30/255, alpha: 1), image: nil)
//            self.viewButton.isHidden = false
//            self.btnProduct.layer.cornerRadius = 5
//            self.btnProduct.layer.borderWidth = 1
//            self.btnProduct.layer.borderColor = UIColor.init(red: 151/255, green: 151/255, blue: 151/255, alpha: 1).cgColor
//            self.btnProduct.setTitle("ADDED", for: .normal)
//            self.btnProduct.setTitleColor(UIColor(red: 125/255, green: 6/255, blue: 15/255, alpha: 1), for: .normal)
//            return
//        }
        
        ProductListCollection.shared.products.append(data)
        self.viewButton.isHidden = false
        self.btnProduct.layer.cornerRadius = 5
        self.btnProduct.layer.borderWidth = 1
        self.btnProduct.layer.borderColor = UIColor.init(red: 151/255, green: 151/255, blue: 151/255, alpha: 1).cgColor
        self.btnProduct.setTitle("ADDED", for: .normal)
        self.btnProduct.setTitleColor(UIColor(red: 125/255, green: 6/255, blue: 15/255, alpha: 1), for: .normal)
    }
    
    func addToWishlist(_ product: ProductListModelData) {
        if product.isFavourite! {
            let params = [
                "user_id": userDefault().getUserID(),
                "product_id": product.productId ?? 0,
                "token": userDefault().getToken()
                ] as [String: Any]
            HTTPHelper.shared.requestAPI(url: Constants.ServicesAPI.User.deleteWishlist, param: params, method: HTTPMethodHelper.post) { (success, json) in
                let data = ProductListModelBaseClass(json: json ?? "")
                if data.message?.lowercased() == "success" {
                    let index: Int? = self.similiarList.index { $0.productId == product.productId }
                    if index != 0 {
                        self.similiarList[index!].isFavourite = !self.similiarList[index!].isFavourite!
                    }
                    self.tableView.reloadData()
                } else {
                    print(data.displayMessage ?? "")
                }
            }
        } else {
            let params = [
                "user_id": userDefault().getUserID(),
                "product_id": product.productId ?? 0,
                "store_id": storeID ?? 0,
                "token": userDefault().getToken()
                ] as [String: Any]
            HTTPHelper.shared.requestAPI(url: Constants.ServicesAPI.User.addWishlist, param: params, method: HTTPMethodHelper.post) { (success, json) in
                let data = ProductListModelBaseClass(json: json ?? "")
                if data.message?.lowercased() == "success" {
                    let index: Int? = self.similiarList.index { $0.productId == product.productId }
                    if index != 0 {
                        self.similiarList[index!].isFavourite = !self.similiarList[index!].isFavourite!
                    }
                    
                    self.tableView.reloadData()
                } else {
                    print(data.displayMessage ?? "")
                }
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
            return HeaderProductTableViewCell.configure(context: self, tableView: tableView, indexPath: indexPath, object: detail)
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionTableViewCell.identifier, for: indexPath) as! DescriptionTableViewCell
            cell.lblDescription.text = detail?.summary ?? "-"
            cell.lblCountry.text = detail?.subRegion ?? "-"
            cell.lblCategory.text = detail?.categoryName ?? "-"
            cell.lblABV.text = String(detail?.abv ?? 0)
            cell.lblSize.text = self.size ?? "-"
            return cell
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
            cell.lblTitle.text = "SIMILAR PRODUCT"
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

extension DetailProductViewController: ShoppingCartDelegate {
    func removeItem(at index: Int) {
        if index == 0 {
            ProductListCollection.shared.products.removeAll()
        }else {
            ProductListCollection.shared.products.remove(at: index)
        }
        
        viewButton.isHidden = true
        btnAddItem.layer.cornerRadius = 5
        btnAddItem.layer.borderColor = UIColor.init(red: 151/255, green: 151/255, blue: 151/255, alpha: 1).cgColor
        btnAddItem.layer.borderWidth = 1
        btnBuyProduct.layer.cornerRadius = 5
    }
}
