//
//  CartTableViewCell.swift
//  Vines
//
//  Created by Calista Bertha on 15/01/19.
//  Copyright © 2019 Calista Bertha. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblNameProduct: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var viewCount: UIView!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var btnMinus: UIButton!
    
    var delete : ((UITableViewCell) -> Void)?
    var minus : ((UITableViewCell) -> Void)?
    var plus : ((UITableViewCell) -> Void)?
    
    private var testCount = 1
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    
    }
    
    @IBAction func deleteButtonDidPush(_ sender: Any) {
        delete?(self)
    }
    
    @IBAction func minButtonDidPush(_ sender: Any) {
        minus?(self)
    }
    
    @IBAction func plusButtonDidPush(_ sender: Any) {
        plus?(self)
    }
}

extension CartTableViewCell: TableViewCellProtocol{
    static func configure<T>(context: UIViewController, tableView: UITableView, indexPath: IndexPath, object: T) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: CartTableViewCell.identifier, for: indexPath) as! CartTableViewCell
        guard let data = object as? CartModelData else { return cell }
         let ctx = context as? ShoppingCartViewController
        cell.lblType.text = data.categoryName ?? ""
        cell.imgProduct.af_setImage(withURL: URL(string: data.image!)!, placeholderImage: UIImage(named: "placeholder")) { [weak cell] image in
            guard let wc = cell else { return }
            if let img = image.value {
                wc.imgProduct.image = img
            } else {
                wc.imgProduct.image = UIImage(named: "placeholder")
            }
        }
        cell.lblNameProduct.text = data.name ?? ""
        cell.lblPrice.text = String(data.price ?? 0).asRupiah()
        cell.viewCount.layer.cornerRadius = cell.viewCount.frame.width / 2
        cell.lblCount.text = "\(cell.testCount)"
//        cell.btnMinus.alpha = 0.5
//        cell.btnMinus.isUserInteractionEnabled = false
        
        cell.delete = {
            (cells) in
            let params = [
                "token": userDefault().getToken(),
                "product_id": data.productID ?? 0,
                "order_code": userDefault().getOrderCode()
                ] as [String : Any]
            
            HTTPHelper.shared.requestAPI(url: Constants.ServicesAPI.User.deleteCart, param: params, method: HTTPMethodHelper.post) { (success, json) in
             
                if json!["message"] == "success" {
                    let alert = JDropDownAlert()
                    alert.alertWith("Success", message: "Remove from cart", topLabelColor: UIColor.white, messageLabelColor: UIColor.white, backgroundColor: UIColor(red: 76/255, green: 188/255, blue: 30/255, alpha: 1), image: nil)
                    UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseInOut, animations: {
                        cell.center = CGPoint(x: -(cell.frame.width), y: (cell.frame.height)/2)
                    }, completion: { (finished) in
                        ctx?.cartList.remove(at: indexPath.row)
                       ctx?.countPrice.remove(at: indexPath.row)
                        tableView.reloadData()
                    })
                } else {
                    print(json!["display_message"] )
                }
            }
      
        }
        
        cell.minus = {
            (cells) in
            if cell.testCount < 1 {
//                cell.btnMinus.alpha = 0.5
//                cell.btnMinus.isUserInteractionEnabled = false
                return
            }
            
            cell.testCount -= 1
            cell.lblCount.text = "\(cell.testCount)"
            let price = cell.testCount * data.price!
            cell.lblPrice.text = String(price).asRupiah()
            ctx?.countPrice.append(-data.price!)
            tableView.reloadData()
        }
        
        cell.plus = {
            (cells) in
            if cell.testCount + 1 > 1 {
                cell.btnMinus.alpha = 1
                cell.btnMinus.isUserInteractionEnabled = true
            }
            
            cell.testCount += 1
            cell.lblCount.text = "\(cell.testCount)"
            let price = cell.testCount * data.price!
            cell.lblPrice.text = String(price).asRupiah()
            ctx?.countPrice.append(data.price!)
            tableView.reloadData()
        }
        return cell
    }
    
}
