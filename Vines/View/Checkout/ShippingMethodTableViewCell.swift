//
//  ShippingMethodTableViewCell.swift
//  Vines
//
//  Created by Calista Bertha on 19/01/19.
//  Copyright © 2019 Calista Bertha. All rights reserved.
//

import UIKit

class ShippingMethodTableViewCell: UITableViewCell {
    @IBOutlet weak var btnDeliver: UIButton!
    @IBOutlet weak var btnPickup: UIButton!
    @IBOutlet weak var btnConfirm: UIButton!
    
    var deliverSelected : ((UITableViewCell) -> Void)?
    var pickupSelected : ((UITableViewCell) -> Void)?
    var confirmSelected : ((UITableViewCell) -> Void)?
    var isDeliver : Bool?
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func deliveryButtonDidPush(_ sender: Any) {
        deliverSelected?(self)
    }
    
    @IBAction func pickupButtonDidPush(_ sender: Any) {
        pickupSelected?(self)
    }
    
    @IBAction func confirmButtonDidPush(_ sender: Any) {
        confirmSelected?(self)
    }
    
}

extension ShippingMethodTableViewCell: TableViewCellProtocol{
    static func configure<T>(context: UIViewController, tableView: UITableView, indexPath: IndexPath, object: T) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ShippingMethodTableViewCell.identifier, for: indexPath) as! ShippingMethodTableViewCell
        cell.btnConfirm.layer.cornerRadius = cell.btnConfirm.frame.height / 2
        cell.deliverSelected = {
            (cells) in
            cell.btnDeliver.setImage(UIImage(named: "ico-radiobutton-active"), for: .normal)
            cell.btnPickup.setImage(UIImage(named: "ico-radiobutton-inactive"), for: .normal)
            cell.isDeliver = true
            tableView.reloadData()
        }
        
        cell.pickupSelected = {
            (cells) in
            cell.btnDeliver.setImage(UIImage(named: "ico-radiobutton-inactive"), for: .normal)
            cell.btnPickup.setImage(UIImage(named: "ico-radiobutton-active"), for: .normal)
            cell.isDeliver = false
            tableView.reloadData()
        }
        
        cell.confirmSelected = {
            (cells) in
           // guard let deliv = cell.isDeliver else {return}
           // cell.delegate?.confirmButtonDidPush(isDeliver: deliv)
        }

        return cell
    }
}
