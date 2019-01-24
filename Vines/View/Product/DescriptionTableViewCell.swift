//
//  DescriptionTableViewCell.swift
//  Vines
//
//  Created by Calista Bertha on 15/12/18.
//  Copyright © 2018 Calista Bertha. All rights reserved.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell {

    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblABV: UILabel!
    @IBOutlet weak var lblSize: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

extension DescriptionTableViewCell: TableViewCellProtocol {
    static func configure<T>(context: UIViewController, tableView: UITableView, indexPath: IndexPath, object: T) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionTableViewCell.identifier, for: indexPath) as! DescriptionTableViewCell
        guard let data = object as? ProductListModelData else { return cell }
        cell.lblDescription.text = data.summary ?? "-"
        cell.lblCountry.text = data.subRegion ?? "-"
        cell.lblCategory.text = data.categoryName ?? "-"
        cell.lblABV.text = data.abv ?? "-"
        cell.lblSize.text = data.name ?? "-"
        return cell
    }
}
