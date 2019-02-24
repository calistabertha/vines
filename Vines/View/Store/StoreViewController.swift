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
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
        }
    }
    @IBOutlet weak var viewCart: UIView!
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var viewFilter: UIView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var storeName: String?
    var storeId: Int = 0
    var storeIDCode: String?
    var nextOffset = 1
    var urlImgStore: String?
    var isFilter = false
    var filtered:[String] = []

    var favouriteList: [ProductListModelData] = []
    var productList : [ProductListModelData] = []
    
    var cartList: [ProductListModelData] = []
    
    var collectionItemSize: CGSize = CGSize(width: 0, height: 0)
    var isFetchProductList = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateNavBarWithBackButton(titleString: storeName ?? "", viewController: self, isRightBarButton: false, isNavbarColor: true)
        spinner.isHidden = true
        setupView()
        fetchFavouriteList()
        fetchProductList(isInit: true, offset: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionItemSize = calculateSize()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    
    override func backButtonDidPush() {
        userDefault().removeObject(forKey: "ORDER_CODE")
        productList = []
        ProductListCollection.shared.products.removeAll()
        navigationController?.popViewController(animated: true)
    }
    
    func setupView() {
        tableView.register(HeaderStoreTableViewCell.nib, forCellReuseIdentifier: HeaderStoreTableViewCell.identifier)
        tableView.register(FeatureProductTableViewCell.nib, forCellReuseIdentifier: FeatureProductTableViewCell.identifier)
        tableView.register(ProductTableViewCell.nib, forCellReuseIdentifier: ProductTableViewCell.identifier)
        tableView.register(HeaderSectionStoreTableViewCell.nib, forCellReuseIdentifier: HeaderSectionStoreTableViewCell.identifier)
        
        viewCart.layer.cornerRadius = viewCart.layer.frame.width / 2
        viewBackground.isHidden = true
        viewFilter.layer.cornerRadius = 14
        viewFilter.layer.shadowColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.5).cgColor
        viewFilter.layer.shadowOpacity = 0.5
        viewFilter.layer.shadowOffset = CGSize(width: 0, height: 2)
        viewFilter.layer.shadowRadius = 1
    }
    
    @IBAction func searchButtonDidPush(_ sender: Any) {
        if txtSearch.text != "" {
            fetchProductList(isInit: true, offset: 1)
        }
        viewBackground.isHidden = true
    }
    
    @IBAction func cartButtonDidPush(_ sender: Any) {
        let vc = ShoppingCartViewController()
        vc.storeName = storeName
        vc.productCartList = cartList
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func filterButtonDidPush(_ sender: Any) {
        let vc = FilterViewController()
        vc.delegate = self
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
    
    func fetchProductList(isInit: Bool, offset: Int, categoryID: Int = 0, country: String = "", priceID: Int = 0) {
        guard !isFetchProductList else {
            return
        }
        
        let params = [
            "store_id": storeId,
            "limit": 10,
            "category_id": categoryID ,
            "offset": offset,
            "user_id": userDefault().getUserID(),
            "keyword": txtSearch.text ?? "",
            "country": country,
            "price": priceID
            ] as [String : Any]
        self.isFetchProductList = true
        HTTPHelper.shared.requestAPI(url: Constants.ServicesAPI.Product.list, param: params, method: HTTPMethodHelper.post) { (success, json) in
            let data = ProductListModelBaseClass(json: json ?? "")
            self.isFetchProductList = false
            if data.message == "Success", let datas = data.data {
                if isInit{
                    self.productList = datas
                    print("counttt \(datas.count) || \(self.productList.count)")
                }else{
                    for value in datas {
                        self.productList.append(value)
                    }
                    self.nextOffset = offset
                     print("counttt \(datas.count) || \(self.productList.count)")
                }
                self.tableView.reloadData()
            } else {
                if data.message == "Failed" {
                    //product not found
                    self.tableView.reloadData()
                }
                print(data.displayMessage ?? "")
            }
            
            self.spinner.isHidden  = true
            self.spinner.stopAnimating()
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
        ProductListCollection.shared.products.append(product)
        if isBuyProduct {
            let vc = ShoppingCartViewController()
            vc.storeName = storeName
            vc.storeID = storeId
            // vc.productCartList = cartList
            vc.delegate = self
            navigationController?.pushViewController(vc, animated: true)
            
//            guard let _ = cartList.first(where: { $0.productId == product.productId }) else {
//                cartList.append(product)
//                let vc = ShoppingCartViewController()
//                vc.storeName = storeName
//                vc.storeID = storeId
//               // vc.productCartList = cartList
//                vc.delegate = self
//                navigationController?.pushViewController(vc, animated: true)
//                return
//            }
        }else{
            guard let _ = ProductListCollection.shared.products.first(where: { $0.productId == product.productId }) else {
                cartList.append(product)
                let alert = JDropDownAlert()
                alert.alertWith("Success", message: "Success add to cart", topLabelColor: UIColor.white, messageLabelColor: UIColor.white, backgroundColor: UIColor(red: 76/255, green: 188/255, blue: 30/255, alpha: 1), image: nil)
                return
            }
            
            let alert = JDropDownAlert()
            alert.alertWith("Product exist", message: "Product already added to cart", topLabelColor: UIColor.white, messageLabelColor: UIColor.white, backgroundColor: UIColor(red: 125/255, green: 6/255, blue: 15/255, alpha: 1), image: nil)
            
        }
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
        }
        else if section == 3 {
            if isFilter{
                return 40
            }else{
                return CGFloat.leastNormalMagnitude
            }
        }
        else{
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 211
        } else if indexPath.section == 1 {
            return collectionItemSize.height
        }else if indexPath.section == 2 {
            return 0
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
        } else if section == 3 {
            if isFilter{
                let cell = tableView.dequeueReusableCell(withIdentifier: HeaderSectionStoreTableViewCell.identifier) as! HeaderSectionStoreTableViewCell
                var stri: String = ""
                for item in filtered {
                    if item == filtered.first {
                        stri = item
                    } else {
                        stri += ", \(item)"
                    }
                }
                let showingTitle = NSMutableAttributedString(string: "Showing filtered results: ", attributes: [.font: UIFont.init(name: "Roboto-Regular", size: 14.0)!, .foregroundColor: UIColor(red: 74 / 255.0, green: 74 / 255.0, blue: 74 / 255.0, alpha: 1.0)])
                let filterString = NSMutableAttributedString(string: "\(stri)", attributes: [.font: UIFont.init(name: "Roboto-Regular", size: 14.0)!, .foregroundColor: UIColor(red: 125 / 255.0, green: 6 / 255.0, blue: 15 / 255.0, alpha: 1.0)])
                showingTitle.append(filterString)
                cell.lblTitle.attributedText = showingTitle
                return cell
            }
            return UIView()
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            return HeaderStoreTableViewCell.configure(context: self, tableView: tableView, indexPath: indexPath, object: self.urlImgStore)
        } else if indexPath.section == 1 {
            let cell = FeatureProductTableViewCell.configure(context: self, tableView: tableView, indexPath: indexPath, object: favouriteList) as! FeatureProductTableViewCell
            cell.size = collectionItemSize
            return cell
        } else if indexPath.section == 3 {
            let cell = ProductTableViewCell.configure(context: self, tableView: tableView, indexPath: indexPath, object: productList) as! ProductTableViewCell
            cell.size = collectionItemSize
            return cell
        }
        return UITableViewCell()
    }

}

extension StoreViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            fetchProductList(isInit: true, offset: 1)
        }
        viewBackground.isHidden = true
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        viewBackground.isHidden = false
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text != "" {
            fetchProductList(isInit: true, offset: 1)
        }
        viewBackground.isHidden = true
    }
}

extension StoreViewController: ShoppingCartDelegate {
    func removeItem(at index: Int) {
        if index == 0 {
            ProductListCollection.shared.products.removeAll()
        }else {
             ProductListCollection.shared.products.remove(at: index)
        }
        //cartList.remove(at: index)
    }
}

extension StoreViewController: FilterDelegate {
    func setFilter(country: String, categoryID: Int, priceID: Int, filter:[String]) {
        isFilter = true
        fetchProductList(isInit: true, offset: nextOffset, categoryID: categoryID, country: country, priceID: priceID)
        filtered = filter
        print("\(country), \(categoryID), \(priceID)")
    }
}

extension StoreViewController: UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height + 44){
            spinner.isHidden = false
            spinner.startAnimating()
            let offset = nextOffset + 1
            fetchProductList(isInit: false, offset: offset)
        }
    }

}
