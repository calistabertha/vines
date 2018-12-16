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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

extension MenuProfileTableViewCell: TableViewCellProtocol {
     static func configure<T>(context: UIViewController, tableView: UITableView, indexPath: IndexPath, object: T) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: MenuProfileTableViewCell.identifier, for: indexPath) as! MenuProfileTableViewCell
        
        return cell
    }
}
