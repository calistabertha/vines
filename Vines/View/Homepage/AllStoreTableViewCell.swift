//
//  AllStore2TableViewCell.swift
//  Vines
//
//  Created by Calista Bertha on 21/10/18.
//  Copyright © 2018 Calista Bertha. All rights reserved.
//

import UIKit
import AlamofireImage

class AllStoreTableViewCell: UITableViewCell {
    @IBOutlet weak var imgStore: UIImageView!
    @IBOutlet weak var lblStore: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var viewCalling: UIView!
    @IBOutlet weak var btnCalling: UIButton!
    @IBOutlet weak var viewCard: UIView!
    @IBOutlet weak var btnDetail: UIButton!
    
    var openDetail : ((UITableViewCell) -> Void)?
    var callingButton : ((UITableViewCell) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func openDetailButtonDidPush(_ sender: Any) {
        openDetail?(self)
    }
    
    @IBAction func callingButtonDidPush(_ sender: Any) {
        callingButton?(self)
    }
}

extension AllStoreTableViewCell: TableViewCellProtocol {
    static func configure<T>(context: UIViewController, tableView: UITableView, indexPath: IndexPath, object: T) -> UITableViewCell {
        let data = object as! StoreListModelData
        let cell = tableView.dequeueReusableCell(withIdentifier: AllStoreTableViewCell.identifier, for: indexPath) as! AllStoreTableViewCell
        cell.imgStore.af_setImage(withURL: URL(string: data.image!)!)
        cell.lblStore.text = data.name!
        cell.lblTime.text = data.open!
        cell.lblAddress.text = data.address!
        
        cell.viewCalling.layer.cornerRadius = cell.viewCalling.frame.width / 2
        cell.viewCalling.layer.borderWidth = 2
        cell.viewCalling.layer.borderColor = UIColor(red: 125/255.0, green: 6/255.0, blue: 15/255.0, alpha: 1).cgColor
        cell.viewCard.backgroundColor = UIColor.white
        
        cell.callingButton = {
            (cells) in
            guard let number = URL(string: "tel://" + data.phone!) else { return }
            UIApplication.shared.open(number)
        }
        
        return cell
    }
}
