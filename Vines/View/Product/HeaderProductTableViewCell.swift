//
//  HeaderProductTableViewCell.swift
//  Vines
//
//  Created by Calista Bertha on 14/12/18.
//  Copyright © 2018 Calista Bertha. All rights reserved.
//

import UIKit

class HeaderProductTableViewCell: UITableViewCell {
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var viewDiscount: UIView!
    @IBOutlet weak var lblDiscount: UILabel!
    @IBOutlet weak var lblStock: UILabel!
    @IBOutlet weak var lblPriceAfter: UILabel!
    @IBOutlet weak var lblPriceBefore: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var btnFavorite: UIButton!
    
     var addToWishlist : ((UITableViewCell) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func favoriteButtonDidPush(_ sender: Any) {
         addToWishlist?(self)
    }
}

extension HeaderProductTableViewCell: TableViewCellProtocol {
    static func configure<T>(context: UIViewController, tableView: UITableView, indexPath: IndexPath, object: T) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HeaderProductTableViewCell.identifier, for: indexPath) as! HeaderProductTableViewCell
        let attributeString = NSMutableAttributedString(string: cell.lblPriceBefore.text ?? "")
        attributeString.addAttribute(NSAttributedStringKey.strikethroughStyle,
                                     value: NSUnderlineStyle.styleSingle.rawValue,
                                     range: NSMakeRange(0, attributeString.length))
        cell.lblPriceBefore.attributedText = attributeString
        
        if cell.btnFavorite.isSelected{
            cell.btnFavorite.setImage(UIImage(named: "ico-buttonfavclicked"), for: .normal)
            cell.btnFavorite.isSelected = false
        }else {
            cell.btnFavorite.setImage(UIImage(named: "ico-buttonfav"), for: .normal)
            cell.btnFavorite.isSelected = true
        }
        
        cell.addToWishlist = {
            (cells) in
            cell.btnFavorite.setImage(UIImage(named: "ico-buttonfavclicked"), for: .normal)
            tableView.reloadData()
        }
        
        return cell
    }
}
