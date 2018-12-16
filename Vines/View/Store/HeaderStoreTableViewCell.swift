//
//  HeaderStoreTableViewCell.swift
//  Vines
//
//  Created by Calista Bertha on 09/12/18.
//  Copyright © 2018 Calista Bertha. All rights reserved.
//

import UIKit

class HeaderStoreTableViewCell: UITableViewCell {

    @IBOutlet weak var imgHeader: UIImageView!
    @IBOutlet weak var viewDiscount: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}

extension HeaderStoreTableViewCell: TableViewCellProtocol {
    static func configure<T>(context: UIViewController, tableView: UITableView, indexPath: IndexPath, object: T) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HeaderStoreTableViewCell.identifier, for: indexPath) as! HeaderStoreTableViewCell
        
        
        return cell
    }
}
