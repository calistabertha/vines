//
//  LiquorOptionTableViewCell.swift
//  Vines
//
//  Created by Calista Bertha on 07/01/19.
//  Copyright © 2019 Calista Bertha. All rights reserved.
//

import UIKit

class LiquorOptionTableViewCell: UITableViewCell {
    @IBOutlet weak var imgSelected: UIImageView!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var btnCategory: UIButton!
    
    var category = ["Wine", "Beer", "Spirits"]
    var liquorSelected : ((UITableViewCell) -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    @IBAction func liquorButtonDidPush(_ sender: Any) {
        liquorSelected?(self)
    }
    
}

extension LiquorOptionTableViewCell: TableViewCellProtocol {
    static func configure<T>(context: UIViewController, tableView: UITableView, indexPath: IndexPath, object: T) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LiquorOptionTableViewCell.identifier, for: indexPath) as! LiquorOptionTableViewCell
        cell.lblCategory.text = cell.category[indexPath.row]
        
        cell.liquorSelected = {
            (cells) in
            if cell.btnCategory.isSelected {
                cell.imgSelected.image = UIImage(named: "ico-checkbox-active")
                cell.btnCategory.isSelected = false
                print("selected")
            }else{
                cell.imgSelected.image = UIImage(named: "ico-checkbox-inactive")
                cell.btnCategory.isSelected = true
                print("unselected")
            }
            tableView.reloadData()
        }
        
        
        return cell
    }
}
