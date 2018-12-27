//
//  PromotionTableViewCell.swift
//  Vines
//
//  Created by Calista Bertha on 27/12/18.
//  Copyright © 2018 Calista Bertha. All rights reserved.
//

import UIKit

class PromotionTableViewCell: UITableViewCell {
    @IBOutlet weak var imgPromotion: UIImageView!
    @IBOutlet weak var viewCard: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

     
    }
    
}

extension PromotionTableViewCell: TableViewCellProtocol {
    static func configure<T>(context: UIViewController, tableView: UITableView, indexPath: IndexPath, object: T) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PromotionTableViewCell.identifier, for: indexPath) as! PromotionTableViewCell
        cell.viewCard.layer.cornerRadius = 5
        cell.viewCard.layer.shadowColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.5).cgColor
        cell.viewCard.layer.shadowOpacity = 0.5
        cell.viewCard.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.viewCard.layer.shadowRadius = 5
        return cell
    }
}
