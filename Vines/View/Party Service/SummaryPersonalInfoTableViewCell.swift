//
//  SummaryPersonalInfoTableViewCell.swift
//  Vines
//
//  Created by Calista Bertha on 07/01/19.
//  Copyright © 2019 Calista Bertha. All rights reserved.
//

import UIKit

class SummaryPersonalInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblTotalGuest: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    var edit : ((UITableViewCell) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    @IBAction func editButtonDidPush(_ sender: Any) {
        edit?(self)
    }
    
}

extension SummaryPersonalInfoTableViewCell: TableViewCellProtocol {
    static func configure<T>(context: UIViewController, tableView: UITableView, indexPath: IndexPath, object: T) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SummaryPersonalInfoTableViewCell.identifier, for: indexPath) as! SummaryPersonalInfoTableViewCell
        cell.btnEdit.layer.cornerRadius = cell.btnEdit.frame.height / 2
        
        cell.edit = {
            (cells) in
            context.navigationController?.popViewController(animated: true)
            print("edited")
        }
        return cell
    }
}

