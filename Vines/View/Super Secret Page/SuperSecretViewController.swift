//
//  SuperSecretViewController.swift
//  Vines
//
//  Created by Patrick Marshall on 17/01/19.
//  Copyright © 2019 Calista Bertha. All rights reserved.
//

import UIKit
import SwiftyJSON

class SuperSecretViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    var list: [ProductListModelData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dict = [
            "product_id": 456,
            "category_id": 19,
            "name": "Kahlua",
            "code": "L002-0020",
            "summary": "Its deep brown colour is attractive and deep. Kahlúa Original Coffee Liqueur offers enticing scents of bittersweet coffee bean and roasted chestnut and multilayered flavours of black coffee and sweet butter.",
            "price": 650000,
            "stock": 0,
            "discount": 0,
            "abv": 20,
            "image": "https://vines-indonesia.com/assets/images/product/egKtH6QQOp.jpg",
            "category_name": "Liqueur",
            "is_favorite": false,
            "datecreate": "0000-00-00 00:00:00"
            ] as [String : Any]
        let json = JSON(dict)
        let product = ProductListModelData(json: json)
        for _ in 1...3 {
            userDefault().addToCart(product: product)
        }
        list = userDefault().getCart()
    }

    @IBAction func addAction(_ sender: Any) {
        userDefault().addToCart(product: list.first!)
        refreshData()
    }
    
    @IBAction func removeAction(_ sender: Any) {
        userDefault().removeCart(productId: list.first!.productId!)
        refreshData()
    }
    
    func refreshData() {
        list = userDefault().getCart()
        var text = ""
        for product in list {
            text += "name: \(product.name!), id: \(product.productId!) \r"
        }
        
        label.text = text
    }
}
