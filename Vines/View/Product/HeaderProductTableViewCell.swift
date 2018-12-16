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
    
     var addToFavorite : ((UITableViewCell) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func favoriteButtonDidPush(_ sender: Any) {
         addToFavorite?(self)
    }
}

extension HeaderProductTableViewCell: TableViewCellProtocol {
    static func configure<T>(context: UIViewController, tableView: UITableView, indexPath: IndexPath, object: T) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HeaderProductTableViewCell.identifier, for: indexPath) as! HeaderProductTableViewCell
        
        cell.addToFavorite = {
            (cells) in
            cell.btnFavorite.setImage(UIImage(named: "ico-buttonfavclicked"), for: .normal)
        }
        
        return cell
    }
}
