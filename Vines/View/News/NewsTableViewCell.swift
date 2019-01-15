//
//  NewsTableViewCell.swift
//  Vines
//
//  Created by Calista Bertha on 28/12/18.
//  Copyright © 2018 Calista Bertha. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    @IBOutlet weak var imgNews: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var viewReadMore: UIView!
    var strings = "Palicierit, quide te nonte consulin desil haleses sulicav"
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

extension NewsTableViewCell: TableViewCellProtocol {
    static func configure<T>(context: UIViewController, tableView: UITableView, indexPath: IndexPath, object: T) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as! NewsTableViewCell
        guard let data = object as? [NewsModelData] else { return cell }
        cell.lblTitle.text = data[indexPath.row].title?.htmlToString
        cell.imgNews.af_setImage(withURL: URL(string: data[indexPath.row].image ?? "")!, placeholderImage: UIImage(named: "placeholder")) { [weak cell] image in
            guard let ws = cell else { return }
            if let img = image.value {
                ws.imgNews.image = img
            } else {
                ws.imgNews.image = UIImage(named: "placeholder")
            }
        }
        cell.viewReadMore.layer.cornerRadius = cell.viewReadMore.frame.height / 2
        cell.lblTitle.sizeToFit()
        return cell
    }
}
