//
//  HeaderSectionStoreTableViewCell.swift
//  Vines
//
//  Created by Calista Bertha on 13/12/18.
//  Copyright © 2018 Calista Bertha. All rights reserved.
//

import UIKit

class HeaderSectionStoreTableViewCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
 
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

extension HeaderSectionStoreTableViewCell: TableViewCellProtocol {
    static func configure<T>(context: UIViewController, tableView: UITableView, indexPath: IndexPath, object: T) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HeaderSectionStoreTableViewCell.identifier, for: indexPath) as! HeaderSectionStoreTableViewCell
        
        
        return cell
    }
}
