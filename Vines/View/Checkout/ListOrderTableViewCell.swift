//
//  ListOrderTableViewCell.swift
//  Vines
//
//  Created by Calista Bertha on 19/01/19.
//  Copyright © 2019 Calista Bertha. All rights reserved.
//

import UIKit

class ListOrderTableViewCell: UITableViewCell {

    @IBOutlet weak var stackView: UIStackView!
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupOrderList(list: [CartModelData]) {
        stackView.subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        
        for (index, list) in list.enumerated() {
            let view = ListOrder()
            view.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(view)
            view.clipsToBounds = true
            view.heightAnchor.constraint(equalToConstant: 50).isActive = true
            
            view.lblName.text = list.name
            view.lblTotal.text = "\(list.jumlahOrder ?? 0)" + " pcs"
            view.lblPrice.text = String(list.price ?? 0).asRupiah()
          
        }
    }
    
}

extension ListOrderTableViewCell: TableViewCellProtocol{
    static func configure<T>(context: UIViewController, tableView: UITableView, indexPath: IndexPath, object: T) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListOrderTableViewCell.identifier, for: indexPath) as! ListOrderTableViewCell
        
        return cell
    }
}
