//
//  DeliveryTableViewCell.swift
//  Vines
//
//  Created by Calista Bertha on 19/01/19.
//  Copyright © 2019 Calista Bertha. All rights reserved.
//

import UIKit
@objc protocol DeliveryDelegate: class {
    func backButtonDidPush()
}

class DeliveryTableViewCell: UITableViewCell {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var btnBack: UIButton!
    
    var backSelected : ((UITableViewCell) -> Void)?
    var delegate : DeliveryDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    @IBAction func backButtonDidPush(_ sender: Any) {
        backSelected?(self)
    }
}

extension DeliveryTableViewCell: TableViewCellProtocol{
    static func configure<T>(context: UIViewController, tableView: UITableView, indexPath: IndexPath, object: T) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DeliveryTableViewCell.identifier, for: indexPath) as! DeliveryTableViewCell
        cell.textView.setContentOffset(CGPoint.zero, animated: false)
        
        cell.backSelected = {
            (cells) in
            cell.delegate?.backButtonDidPush()
        }
        return cell
    }
}

extension DeliveryTableViewCell: UITextViewDelegate{
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Your Address"
            textView.textColor = UIColor.lightGray
        }
    }
}
