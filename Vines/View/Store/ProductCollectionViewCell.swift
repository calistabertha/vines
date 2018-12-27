//
//  ProductCollectionViewCell.swift
//  Vines
//
//  Created by Calista Bertha on 09/12/18.
//  Copyright © 2018 Calista Bertha. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var viewDiscount: UIView!
    @IBOutlet weak var btnFavorite: UIButton!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice1: UILabel!
    @IBOutlet weak var lblPrice2: UILabel!
    @IBOutlet weak var viewCart: UIView!
    @IBOutlet weak var lblAction: UILabel!
    @IBOutlet weak var iconAction: UIImageView!
    
    
    @IBAction func cartButtonDidPush(_ sender: Any) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

}

extension ProductCollectionViewCell: CollectionViewCellProtocol{
    static func configure<T>(context: UIViewController, collectionView: UICollectionView, indexPath: IndexPath, object: T) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as! ProductCollectionViewCell
        guard let data = object as? String else { return cell }
        
        if data == "wishlist" {
            cell.btnFavorite.setImage(UIImage(named: "ico-buttonfavclicked"), for: .normal)
            cell.btnFavorite.isSelected = true
            cell.lblAction.text = "BUY PRODUCT"
            cell.iconAction.image = UIImage(named: "ico-nav-arrow")
        }
        
        cell.viewCart.layer.cornerRadius = 10
        return cell
    }
    
    
}
