//
//  ShoppingCartViewController.swift
//  Vines
//
//  Created by Calista Bertha on 15/01/19.
//  Copyright © 2019 Calista Bertha. All rights reserved.
//

import UIKit

public protocol ShoppingCartDelegate: class {
    func removeItem(at index: Int)
}

class ShoppingCartViewController: VinesViewController {
    @IBOutlet weak var tableView: UITableView!
    var productCartList: [ProductListModelData] = []
//    var cartList: [CartModelData] = []
//    var countPrice: [Int] = []
    var storeName: String?
    var storeID: Int?
    weak var delegate: ShoppingCartDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        fetchCartList()
        generateNavBarWithBackButton(titleString: "SHOPPING CART", viewController: self, isRightBarButton: false, isNavbarColor: true)
        tableView.register(CartTableViewCell.nib, forCellReuseIdentifier: CartTableViewCell.identifier)
        tableView.register(TotalCartTableViewCell.nib, forCellReuseIdentifier: TotalCartTableViewCell.identifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func backButtonDidPush() {
        navigationController?.popViewController(animated: true)
    }
    
//    func fetchCartList() {
//        let params = [
//            "token": userDefault().getToken(),
//            "user_id": userDefault().getUserID(),
//            "order_code": userDefault().getOrderCode()
//            ] as [String : Any]
//
//        HTTPHelper.shared.requestAPI(url: Constants.ServicesAPI.User.listCart, param: params, method: HTTPMethodHelper.post) { (success, json) in
//            let data = CartModelBaseClass(json: json ?? "")
//            if data.message == "success", let datas = data.data {
//                self.cartList = datas
//                self.tableView.reloadData()
//
//                for item in data.data ?? [] {
//                    self.countPrice.append(item.price ?? 0)
//                }
//            } else {
//                print(data.displayMessage ?? "")
//            }
//        }
//    }
    
}

extension ShoppingCartViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return productCartList.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 210
        } else {
            return 183
        }
    }
}

extension ShoppingCartViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            return CartTableViewCell.configure(context: self, tableView: tableView, indexPath: indexPath, object: productCartList[indexPath.row])
        } else if indexPath.section == 1 {
           return TotalCartTableViewCell.configure(context: self, tableView: tableView, indexPath: indexPath, object: productCartList)
        }
        return UITableViewCell()
    }
    
}
