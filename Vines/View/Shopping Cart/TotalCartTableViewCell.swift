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
        guard let data = object as? [Int] else {return cell}
        cell.lblTotal.text = String(data.reduce(0, +)).asRupiah()
        /*
         let multiples = [...]
         sum = multiples.reduce(0, +)
         
         let arr = [1,2,3,4,5,6,7,8,9,10]
         var sumedArr = arr.reduce(0, combine: {$0 + $1})
         */
        cell.payment = {
            (cells) in
            guard let ctx = context as? ShoppingCartViewController else {return}
            let vc = ParentCheckoutViewController()
            vc.storeName = ctx.storeName
            ctx.navigationController?.pushViewController(vc, animated: true)
        }
        return cell
    }
    
}
