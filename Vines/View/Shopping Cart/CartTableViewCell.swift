//
//  CartTableViewCell.swift
//  Vines
//
//  Created by Calista Bertha on 15/01/19.
//  Copyright © 2019 Calista Bertha. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblNameProduct: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var viewCount: UIView!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var btnMinus: UIButton!
    
    var delete : ((UITableViewCell) -> Void)?
    var minus : ((UITableViewCell) -> Void)?
    var plus : ((UITableViewCell) -> Void)?
    
    private var testCount = 1
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    
    }
    
    @IBAction func deleteButtonDidPush(_ sender: Any) {
        delete?(self)
    }
    
    @IBAction func minButtonDidPush(_ sender: Any) {
        minus?(self)
    }
    
    @IBAction func plusButtonDidPush(_ sender: Any) {
        plus?(self)
    }
}

extension CartTableViewCell: TableViewCellProtocol{
    static func configure<T>(context: UIViewController, tableView: UITableView, indexPath: IndexPath, object: T) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: CartTableViewCell.identifier, for: indexPath) as! CartTableViewCell
        cell.viewCount.layer.cornerRadius = cell.viewCount.frame.width / 2
        
        cell.delete = {
            (cells) in
            //hit api
            //if success {
                UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseInOut, animations: {
                    cell.center = CGPoint(x: -(cell.frame.width), y: (cell.frame.height)/2)
                }, completion: { (finished) in
                    let ctx = context as? StoreViewController
                   // ctx?.continueItems.remove(at: indexPath.row)
                    tableView.reloadData()
                    
                })
          //  }
        }
        
        cell.minus = {
            (cells) in
            if cell.testCount == 1 {
                cell.btnMinus.alpha = 0.5
                cell.btnMinus.isUserInteractionEnabled = false
                return
            }
            
            cell.testCount -= 1
            cell.lblCount.text = "\(cell.testCount)"
        }
        
        cell.plus = {
            (cells) in
            if cell.testCount > 1 {
                cell.btnMinus.alpha = 1
                cell.btnMinus.isUserInteractionEnabled = true
            }
            
            cell.testCount += 1
            cell.lblCount.text = "\(cell.testCount)"
        }
        return cell
    }
    
}
