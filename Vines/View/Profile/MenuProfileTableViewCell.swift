//
//  MenuProfileTableViewCell.swift
//  Vines
//
//  Created by Calista Bertha on 01/12/18.
//  Copyright © 2018 Calista Bertha. All rights reserved.
//

import UIKit

class MenuProfileTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgMenu: UIImageView!
    @IBOutlet weak var lblMenu: UILabel!
    var selectRow : ((UITableViewCell) -> Void)?
    
    var listMenu = ["Home", "Wishlist", "Promotions", "Retail", "Party Services", "News", "Support", "About"]
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func selectedButtonDidPush(_ sender: Any) {
        selectRow?(self)
    }
}

extension MenuProfileTableViewCell: TableViewCellProtocol {
     static func configure<T>(context: UIViewController, tableView: UITableView, indexPath: IndexPath, object: T) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: MenuProfileTableViewCell.identifier, for: indexPath) as! MenuProfileTableViewCell
        if indexPath.row == 0 {
            cell.imgMenu.image = UIImage(named: "ico-menuactive0")
            cell.lblMenu.textColor = UIColor(red: 125/255, green: 6/255, blue: 15/255, alpha: 1)
        }else{
            cell.imgMenu.image = UIImage(named: "ico-menu\(indexPath.row)")
        }
        
        cell.lblMenu.text = cell.listMenu[indexPath.row]
        
        cell.selectRow = {
            (cells) in
            
            if let ctx = context as? ProfileSwipeViewController {
                ctx.delegate?.dismissView(controller: ctx)
                if indexPath.row == 1 {
                    let vc = WishlistViewController()
                    context.navigationController?.pushViewController(vc, animated: true)
                } else if indexPath.row == 2 {
                    let vc = PromotionsViewController()
                    context.navigationController?.pushViewController(vc, animated: true)
                }
            }
            
            
        }
        return cell
    }
}
