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
    var storeId: Int = 0

    // Still dummy data
    var favouriteList: [ProductListModelData] = []
    // If you want to test responsive, you could change item count inside this below array.
    // Hope everything is fine wkwk
//    var specialOfferList: [Any] = [0,0,0,0,0,0,0,0,0]
    var productList: [ProductListModelData] = []
    
    var collectionItemSize: CGSize = CGSize(width: 0, height: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateNavBarWithBackButton(titleString: storeName ?? "", viewController: self, isRightBarButton: false)
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionItemSize = calculateSize()
        // fetchData
        fetchFavouriteList()
        fetchProductList()
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
    
    @IBAction func cartButtonDidPush(_ sender: Any) {
        let vc = ShoppingCartViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func fetchFavouriteList() {
        let params = [
            "limit": 10,
            "user_id": userDefault().getUserID()
            ] as [String : Any]
        HTTPHelper.shared.requestAPI(url: Constants.ServicesAPI.Product.favourite, param: params, method: HTTPMethodHelper.post) { (success, json) in
            let data = ProductListModelBaseClass(json: json ?? "")
            if data.message == "Success", let datas = data.data {
                self.favouriteList = datas
                self.tableView.reloadData()
            } else {
                print(data.displayMessage ?? "")
            }
        }
    }
    
    func fetchProductList() {
        let params = [
            "store_id": storeId,
            "limit": 10,
            "category_id": "",
            "offset": 0,
            "user_id": userDefault().getUserID()
            ] as [String : Any]
        HTTPHelper.shared.requestAPI(url: Constants.ServicesAPI.Product.list, param: params, method: HTTPMethodHelper.post) { (success, json) in
            let data = ProductListModelBaseClass(json: json ?? "")
            if data.message == "Success", let datas = data.data {
                self.productList = datas
                self.tableView.reloadData()
            } else {
                print(data.displayMessage ?? "")
            }
        }
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
                    let index = self.productList.index { $0.productId == product.productId } ?? 0
                    self.productList[index].isFavourite = !self.productList[index].isFavourite!
//                    self.tableView.reloadSections(IndexSet(arrayLiteral: 2), with: .none)
                    self.tableView.reloadData()
                } else {
                    print(data.displayMessage ?? "")
                }
            }
        } else {
            let params = [
                "user_id": userDefault().getUserID(),
                "product_id": product.productId ?? 0,
                "store_id": storeId,
                "token": userDefault().getToken()
                ] as [String: Any]
            HTTPHelper.shared.requestAPI(url: Constants.ServicesAPI.User.addWishlist, param: params, method: HTTPMethodHelper.post) { (success, json) in
                let data = ProductListModelBaseClass(json: json ?? "")
                if data.message?.lowercased() == "success" {
                    let index = self.productList.index { $0.productId == product.productId } ?? 0
                    self.productList[index].isFavourite = !self.productList[index].isFavourite!
//                    self.tableView.reloadSections(IndexSet(arrayLiteral: 2), with: .none)
                    self.tableView.reloadData()
                } else {
                    print(data.displayMessage ?? "")
                }
            }
        }
    }
}

extension StoreViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
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
        } else {
            return (collectionItemSize.height * CGFloat(halfCeil(productList.count)))
        }
    }
}

extension StoreViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: HeaderSectionStoreTableViewCell.identifier) as! HeaderSectionStoreTableViewCell
            cell.lblTitle.text = "FAVOURITE PRODUCT"
            return cell
        } else if section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: HeaderSectionStoreTableViewCell.identifier) as! HeaderSectionStoreTableViewCell
            cell.lblTitle.text = "ALL PRODUCT"
            return cell
        }
        
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            return HeaderStoreTableViewCell.configure(context: self, tableView: tableView, indexPath: indexPath, object: "")
        } else if indexPath.section == 1 {
            let cell = FeatureProductTableViewCell.configure(context: self, tableView: tableView, indexPath: indexPath, object: favouriteList) as! FeatureProductTableViewCell
            cell.size = collectionItemSize
            return cell
        } else if indexPath.section == 2 {
            let cell = ProductTableViewCell.configure(context: self, tableView: tableView, indexPath: indexPath, object: productList) as! ProductTableViewCell
//            cell.addToCart = { [weak self] int in
//                guard let ws = self else { return }
//                ws.addToCart(int)
//            }
            cell.addToWishlist = { [weak self] product in
                guard let ws = self else { return }
                ws.addToWishlist(product)
            }
            cell.size = collectionItemSize
            return cell
        }
        return UITableViewCell()
    }

}

