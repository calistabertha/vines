//
//  PickupTableViewCell.swift
//  Vines
//
//  Created by Calista Bertha on 19/01/19.
//  Copyright © 2019 Calista Bertha. All rights reserved.
//

import UIKit

class PickupTableViewCell: UITableViewCell {
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblStore: UILabel!
    
    var backSelected : ((UITableViewCell) -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func backButtonDidPush(_ sender: Any) {
        backSelected?(self)
    }
}

extension PickupTableViewCell: TableViewCellProtocol{
    static func configure<T>(context: UIViewController, tableView: UITableView, indexPath: IndexPath, object: T) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PickupTableViewCell.identifier, for: indexPath) as! PickupTableViewCell
      
        return cell
    }
}
