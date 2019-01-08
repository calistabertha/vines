//
//  GeneralInformationTableViewCell.swift
//  Vines
//
//  Created by Calista Bertha on 04/01/19.
//  Copyright © 2019 Calista Bertha. All rights reserved.
//

import UIKit

class GeneralInformationTableViewCell: UITableViewCell {

    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

extension GeneralInformationTableViewCell: TableViewCellProtocol {
    static func configure<T>(context: UIViewController, tableView: UITableView, indexPath: IndexPath, object: T) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GeneralInformationTableViewCell.identifier, for: indexPath) as! GeneralInformationTableViewCell
        
        
        return cell
    }
}

extension GeneralInformationTableViewCell: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
