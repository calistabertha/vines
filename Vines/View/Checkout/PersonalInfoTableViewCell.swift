//
//  PersonalInfoTableViewCell.swift
//  Vines
//
//  Created by Calista Bertha on 19/01/19.
//  Copyright © 2019 Calista Bertha. All rights reserved.
//

import UIKit

class PersonalInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var btnRemember: UIButton!
    
    var rememberSelected : ((UITableViewCell) -> Void)?
    var isRemember = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func rememberMe(_ sender: Any) {
        rememberSelected?(self)
    }
}

extension PersonalInfoTableViewCell: TableViewCellProtocol{
    static func configure<T>(context: UIViewController, tableView: UITableView, indexPath: IndexPath, object: T) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PersonalInfoTableViewCell.identifier, for: indexPath) as! PersonalInfoTableViewCell
        
        cell.rememberSelected = {
            (cells) in
            if cell.btnRemember.isSelected {
                cell.btnRemember.isSelected = false
                cell.btnRemember.setImage(UIImage(named: "ico-checkbox-active"), for: .normal)
                cell.isRemember = true
                print("selected")
            }else{
                cell.btnRemember.setImage(UIImage(named: "ico-checkbox-inactive"), for: .normal)
                cell.btnRemember.isSelected = true
                cell.isRemember = false
                print("unselected")
            }
            tableView.reloadData()
        }
        
        return cell
    }
}
