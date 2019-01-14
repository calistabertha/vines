//
//  ProductCollectionViewCell.swift
//  Vines
//
//  Created by Calista Bertha on 09/12/18.
//  Copyright © 2018 Calista Bertha. All rights reserved.
//

import UIKit
import AlamofireImage

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
        guard let data = object as? ProductListModelData else { return cell }
        
        // still wrong cz no wishlist value
        if data.code == "wishlist" {
            cell.btnFavorite.setImage(UIImage(named: "ico-buttonfavclicked"), for: .normal)
            cell.btnFavorite.isSelected = true
            cell.lblAction.text = "BUY PRODUCT"
            cell.iconAction.image = UIImage(named: "ico-nav-arrow")
        }
        
        cell.imgProduct.af_setImage(withURL: URL(string: data.image!)!, placeholderImage: UIImage(named: "placeholder")) { [weak cell] image in
            guard let wc = cell else { return }
            if let img = image.value {
                wc.imgProduct.image = img
            } else {
                wc.imgProduct.image = UIImage(named: "placeholder")
            }
        }
        
        cell.lblName.text = data.name ?? ""
        cell.lblType.text = data.categoryName ?? ""
        cell.lblPrice1.text = String(data.discount ?? 0).asRupiah()
        cell.lblPrice2.text = String(data.price ?? 0).asRupiah()
        
        cell.viewCart.layer.cornerRadius = 10
        return cell
    }
    
    
}
