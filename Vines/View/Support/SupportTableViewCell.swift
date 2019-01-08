//
//  SupportTableViewCell.swift
//  Vines
//
//  Created by Calista Bertha on 04/01/19.
//  Copyright © 2019 Calista Bertha. All rights reserved.
//

import UIKit

class SupportTableViewCell: UITableViewCell {

    @IBOutlet weak var viewCard: UIView!
    @IBOutlet weak var lblMenu: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
  
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

     
    }
    
}

extension SupportTableViewCell: TableViewCellProtocol {
    static func configure<T>(context: UIViewController, tableView: UITableView, indexPath: IndexPath, object: T) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SupportTableViewCell.identifier, for: indexPath) as! SupportTableViewCell
        cell.viewCard.layer.shadowColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.5).cgColor
        cell.viewCard.layer.shadowOpacity = 0.5
        cell.viewCard.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.viewCard.layer.shadowRadius = 1
        
        if indexPath.row == 0 {
            cell.lblMenu.text = "CONTACT US"
        }else if indexPath.row == 1 {
            cell.lblMenu.text = "PRIVACY POLICY"
        }else if indexPath.row == 2 {
            cell.lblMenu.text = "TERM & CONDITION"
        }
        
        return cell
    }
}
