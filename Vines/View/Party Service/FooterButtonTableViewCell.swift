//
//  FooterButtonTableViewCell.swift
//  Vines
//
//  Created by Calista Bertha on 07/01/19.
//  Copyright © 2019 Calista Bertha. All rights reserved.
//

import UIKit

class FooterButtonTableViewCell: UITableViewCell {

     var solveParty : ((UITableViewCell) -> Void)?
    @IBOutlet weak var btnSolved: UIButton!
   
    override func awakeFromNib() {
        super.awakeFromNib()
 
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
    
    @IBAction func solvePartyButtonDidPush(_ sender: Any) {
        solveParty?(self)
    }
}

extension FooterButtonTableViewCell: TableViewCellProtocol {
    static func configure<T>(context: UIViewController, tableView: UITableView, indexPath: IndexPath, object: T) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FooterButtonTableViewCell.identifier, for: indexPath) as! FooterButtonTableViewCell
        cell.btnSolved.layer.cornerRadius = 5
        
        cell.solveParty = {
             (cells) in
              if let ctx = context as? PartyServiceViewController {
                let vc = SummaryPartyViewController()
                ctx.navigationController?.pushViewController(vc, animated: true)
                print("solve party")
            }
          
        }
        return cell
    }
}
