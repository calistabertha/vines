//
//  LiquorSelectionTableViewCell.swift
//  Vines
//
//  Created by Calista Bertha on 05/01/19.
//  Copyright © 2019 Calista Bertha. All rights reserved.
//

import UIKit

class LiquorSelectionTableViewCell: UITableViewCell {

    @IBOutlet weak var viewResult: UIView!
    @IBOutlet weak var viewEdit: UIView!
    @IBOutlet weak var imgLiquor: UIImageView!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPriceBefore: UILabel!
    @IBOutlet weak var lblCountEdit: UILabel!
    @IBOutlet weak var lblCountResult: UILabel!
    @IBOutlet weak var lblPriceTotal: UILabel!
    @IBOutlet weak var lblPriceEdit: UILabel!
    @IBOutlet weak var viewDiscount: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    @IBAction func minButtonDidPush(_ sender: Any) {
    }
    
    @IBAction func maxButtonDidPush(_ sender: Any) {
    }
    
}

extension LiquorSelectionTableViewCell: TableViewCellProtocol {
    static func configure<T>(context: UIViewController, tableView: UITableView, indexPath: IndexPath, object: T) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LiquorSelectionTableViewCell.identifier, for: indexPath) as! LiquorSelectionTableViewCell
        
        
        return cell
    }
}
