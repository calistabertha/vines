//
//  RedeemPointTableViewCell.swift
//  Vines
//
//  Created by Calista Bertha on 19/01/19.
//  Copyright © 2019 Calista Bertha. All rights reserved.
//

import UIKit

class RedeemPointTableViewCell: UITableViewCell {
    @IBOutlet weak var lblPoints: UILabel!
    @IBOutlet weak var btnUsePoint: UIButton!
    var useSelected : ((UITableViewCell) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
 
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
    @IBAction func usePointButtonDidPush(_ sender: Any) {
        useSelected?(self)
    }
}

extension RedeemPointTableViewCell: TableViewCellProtocol{
    static func configure<T>(context: UIViewController, tableView: UITableView, indexPath: IndexPath, object: T) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RedeemPointTableViewCell.identifier, for: indexPath) as! RedeemPointTableViewCell
        
        return cell
    }
}
