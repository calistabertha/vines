//
//  OrderTableViewCell.swift
//  Vines
//
//  Created by Calista Bertha on 29/01/19.
//  Copyright © 2019 Calista Bertha. All rights reserved.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    @IBOutlet weak var lblInvoiceNumber: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var viewOrder: UIView!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblStore: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

extension OrderTableViewCell: TableViewCellProtocol {
    static func configure<T>(context: UIViewController, tableView: UITableView, indexPath: IndexPath, object: T) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderTableViewCell.identifier, for: indexPath) as! OrderTableViewCell
         guard let data = object as? [OrderModelData] else { return cell }
        let totalOrder = String(data[indexPath.row].totalOrder ?? 0).asRupiah()
        cell.viewOrder.layer.cornerRadius = 5
        cell.lblInvoiceNumber.text = String(data[indexPath.row].storeId ?? 0)
        cell.lblDate.text = "Date: \(data[indexPath.row].datecreate?.getDateString() ?? "") / Total: \(totalOrder)"
        if data[indexPath.row].paymentStatus == "Waiting Payment" {
            cell.lblStatus.text = "READY TO PICKUP"
        }
        
        cell.lblStore.text = data[indexPath.row].name?.uppercased()
        cell.lblAddress.text = data[indexPath.row].storeAddress
        return cell
    }
}
