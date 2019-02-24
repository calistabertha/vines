//
//  TotalCartTableViewCell.swift
//  Vines
//
//  Created by Calista Bertha on 15/01/19.
//  Copyright © 2019 Calista Bertha. All rights reserved.
//

import UIKit

class TotalCartTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var btnPayment: UIButton!
    
    var payment : ((UITableViewCell) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
    
    @IBAction func paymentButtonDidPush(_ sender: Any) {
        payment?(self)
    }
}

extension TotalCartTableViewCell: TableViewCellProtocol{
    static func configure<T>(context: UIViewController, tableView: UITableView, indexPath: IndexPath, object: T) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TotalCartTableViewCell.identifier, for: indexPath) as! TotalCartTableViewCell
        cell.btnPayment.layer.cornerRadius = 5
        guard let data = object as? [ProductListModelData] else {return cell}
        let totalPrice = String(data
            .map { (productData: ProductListModelData) -> Int in
                guard let price = productData.price else { return 0 }
                return productData.quantity * price
            }
            .reduce(0, +))
            .asRupiah()
        cell.lblTotal.text = totalPrice
        
        cell.payment = {
            (cells) in
            
            let serialQueue = DispatchQueue(label: "atc-serial-queue")
            
            serialQueue.sync {
                for productData in data {
                    let params = [
                        "user_id": userDefault().getUserID(),
                        "order_code": userDefault().getOrderCode(),
                        "token": userDefault().getToken(),
                        "list_order": [[
                            "product_id": productData.productId ?? 0,
                            "category_id": productData.categoryId ?? 0,
                            "price": productData.price ?? 0,
                            "code_product": productData.code ?? "",
                            "size": "",
                            "discount": productData.discount ?? 0,
                            "jumlah_order": productData.quantity
                            ]]
                        ] as [String: Any]
                    
                    HTTPHelper.shared.requestAPI(url: Constants.ServicesAPI.User.addCart, param: params, method: HTTPMethodHelper.post) { (success, json) in
                        let data = CartModelBaseClass(json: json ?? "")
                        if data.message?.lowercased() == "success" {
             
                        } else {
                            let alert = JDropDownAlert()
                            alert.alertWith("Oopss..", message: data.displayMessage, topLabelColor: UIColor.white, messageLabelColor: UIColor.white, backgroundColor: UIColor(red: 125/255, green: 6/255, blue: 15/255, alpha: 1), image: nil)
                            print(data.displayMessage ?? "")
                        }
                    }
                }
            }
            
            serialQueue.sync {
                guard let ctx = context as? ShoppingCartViewController else {return}
                let vc = ParentCheckoutViewController()
                vc.storeName = ctx.storeName
                vc.storeID = ctx.storeID
                ctx.navigationController?.pushViewController(vc, animated: true)
            }
        }
        return cell
    }
    
}
