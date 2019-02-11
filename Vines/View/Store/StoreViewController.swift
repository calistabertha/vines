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

    var favouriteList: [ProductListModelData] = []
    var productList: [ProductListModelData] = []
    
    var cartList: [ProductListModelData] = []
    
    var collectionItemSize: CGSize = CGSize(width: 0, height: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateNavBarWithBackButton(titleString: storeName ?? "", viewController: self, isRightBarButton: false, isNavbarColor: true)
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionItemSize = calculateSize()
        fetchFavouriteList()
        fetchProductList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    
    override func backButtonDidPush() {
        userDefault().removeObject(forKey: "ORDER_CODE")
        navigationController?.popViewController(animated: true)
    }
    
    func setupView() {
        tableView.register(HeaderStoreTableViewCell.nib, forCellReuseIdentifier: HeaderStoreTableViewCell.identifier)
        tableView.register(FeatureProductTableViewCell.nib, forCellReuseIdentifier: FeatureProductTableViewCell.identifier)
        tableView.register(ProductTableViewCell.nib, forCellReuseIdentifier: ProductTableViewCell.identifier)
        tableView.register(HeaderSectionStoreTableViewCell.nib, forCellReuseIdentifier: HeaderSectionStoreTableViewCell.identifier)
        
        viewCart.layer.cornerRadius = viewCart.layer.frame.width / 2
    }
    
    @IBAction func searchButtonDidPush(_ sender: Any) {
        fetchProductList()
    }
    
    @IBAction func cartButtonDidPush(_ sender: Any) {
        let vc = ShoppingCartViewController()
        vc.storeName = storeName
        vc.productCartList = cartList
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func fetchFavouriteList() {
        let params = [
            "limit": 10,
            "user_id": userDefault().getUserID(),
            "keyword": txtSearch.text ?? ""
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
            "user_id": userDefault().getUserID(),
            "keyword": txtSearch.text ?? ""
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
                    let index: Int? = self.productList.index { $0.productId == product.productId }
                    if index != 0 {
                        self.productList[index!].isFavourite = !self.productList[index!].isFavourite!
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
                "store_id": storeId,
                "token": userDefault().getToken()
                ] as [String: Any]
            HTTPHelper.shared.requestAPI(url: Constants.ServicesAPI.User.addWishlist, param: params, method: HTTPMethodHelper.post) { (success, json) in
                let data = ProductListModelBaseClass(json: json ?? "")
                if data.message?.lowercased() == "success" {
                    let index: Int? = self.productList.index { $0.productId == product.productId }
                    if index != 0 {
                        self.productList[index!].isFavourite = !self.productList[index!].isFavourite!
                    }
                    
                    self.tableView.reloadData()
                } else {
                    print(data.displayMessage ?? "")
                }
            }
        }
    }
    
    func addToCart(_ product: ProductListModelData, isBuyProduct: Bool) {
        if isBuyProduct {
            guard let _ = cartList.first(where: { $0.productId == product.productId }) else {
                cartList.append(product)
                let vc = ShoppingCartViewController()
                vc.storeName = storeName
                vc.storeID = storeId
                vc.productCartList = cartList
                vc.delegate = self
                navigationController?.pushViewController(vc, animated: true)
                return
            }
        }else{
            guard let _ = cartList.first(where: { $0.productId == product.productId }) else {
                cartList.append(product)
                let alert = JDropDownAlert()
                alert.alertWith("Success", message: "Success add to cart", topLabelColor: UIColor.white, messageLabelColor: UIColor.white, backgroundColor: UIColor(red: 76/255, green: 188/255, blue: 30/255, alpha: 1), image: nil)
                return
            }
            
            let alert = JDropDownAlert()
            alert.alertWith("Product exist", message: "Product already added to cart", topLabelColor: UIColor.white, messageLabelColor: UIColor.white, backgroundColor: UIColor(red: 125/255, green: 6/255, blue: 15/255, alpha: 1), image: nil)
            
        }
        
       
//        let params = [
//            "user_id": userDefault().getUserID(),
//            "order_code": userDefault().getOrderCode(),
//            "token": userDefault().getToken(),
//            "list_order": [[
//                "product_id": product.productId ?? 0,
//                "category_id": product.categoryId ?? 0,
//                "price": product.price ?? 0,
//                "code_product": product.code ?? "",
//                "size": "",
//                "discount": product.discount ?? 0,
//                "jumlah_order": 1
//                ]]
//            ] as [String: Any]
//
//        HTTPHelper.shared.requestAPI(url: Constants.ServicesAPI.User.addCart, param: params, method: HTTPMethodHelper.post) { (success, json) in
//            let data = CartModelBaseClass(json: json ?? "")
//            if data.message?.lowercased() == "success" {
//                if isBuyProduct{
//                    let vc = ShoppingCartViewController()
//                    vc.storeName = self.storeName
//                    self.navigationController?.pushViewController(vc, animated: true)
//                }else{
//                    let alert = JDropDownAlert()
//                    alert.alertWith("Success", message: "Success add to cart", topLabelColor: UIColor.white, messageLabelColor: UIColor.white, backgroundColor: UIColor(red: 76/255, green: 188/255, blue: 30/255, alpha: 1), image: nil)
//                }
//
//            } else {
//                let alert = JDropDownAlert()
//                alert.alertWith("Oopss..", message: data.displayMessage, topLabelColor: UIColor.white, messageLabelColor: UIColor.white, backgroundColor: UIColor(red: 125/255, green: 6/255, blue: 15/255, alpha: 1), image: nil)
//                print(data.displayMessage ?? "")
//            }
//        }
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
            cell.size = collectionItemSize
            return cell
        }
        return UITableViewCell()
    }

}

extension StoreViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        fetchProductList()
        textField.resignFirstResponder()
        return true
    }
}

extension StoreViewController: ShoppingCartDelegate {
    func removeItem(at index: Int) {
        cartList.remove(at: index)
    }
}
