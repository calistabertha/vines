//
//  AllStoreTableViewCell.swift
//  Vines
//
//  Created by Calista Bertha on 20/10/18.
//  Copyright © 2018 Calista Bertha. All rights reserved.
//

import UIKit

class AllStoreTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
extension AllStoreTableViewCell: TableViewCellProtocol{
    static func configure<T>(context: UIViewController, tableView: UITableView, indexPath: IndexPath, object: T) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AllStoreTableViewCell.identifier, for: indexPath) as! AllStoreTableViewCell
        
        return cell
    }
    
    
}
