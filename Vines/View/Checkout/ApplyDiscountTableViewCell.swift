//
//  ApplyDiscountTableViewCell.swift
//  Vines
//
//  Created by Calista Bertha on 21/01/19.
//  Copyright © 2019 Calista Bertha. All rights reserved.
//

import UIKit

class ApplyDiscountTableViewCell: UITableViewCell {

    @IBOutlet weak var lblCode: UILabel!
    
    var closeSelected : ((UITableViewCell) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func closeButtonDidPush(_ sender: Any) {
        closeSelected?(self)
    }
}

extension ApplyDiscountTableViewCell: TableViewCellProtocol{
    static func configure<T>(context: UIViewController, tableView: UITableView, indexPath: IndexPath, object: T) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ApplyDiscountTableViewCell.identifier, for: indexPath) as! ApplyDiscountTableViewCell
        
        return cell
    }
    
}
