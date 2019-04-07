//
//  DiscountCodeTableViewCell.swift
//  Vines
//
//  Created by Calista Bertha on 19/01/19.
//  Copyright © 2019 Calista Bertha. All rights reserved.
//

import UIKit

class DiscountCodeTableViewCell: UITableViewCell {
    @IBOutlet weak var txtCode: UITextField!
    @IBOutlet weak var btnApply: UIButton!
    
    var applySelected : ((UITableViewCell) -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func applyButtonDidPush(_ sender: Any) {
        applySelected?(self)
    }
    
}

extension DiscountCodeTableViewCell: TableViewCellProtocol{
    static func configure<T>(context: UIViewController, tableView: UITableView, indexPath: IndexPath, object: T) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DiscountCodeTableViewCell.identifier, for: indexPath) as! DiscountCodeTableViewCell
        guard let ctx = context as? OrderSummaryViewController else {return cell}
        if ctx.discountCode != nil {
            cell.txtCode.text = ctx.discountCode
        }else{
            cell.txtCode.text = ""
        }
        cell.btnApply.layer.cornerRadius = cell.btnApply.frame.height / 2
        cell.applySelected = {
            (cells) in
            ctx.isCodeApplied = true
            ctx.discountCode = cell.txtCode.text
            ctx.tableView.reloadData()
            
        }
        return cell
    }
}

