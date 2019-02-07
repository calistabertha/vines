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
    @IBOutlet weak var lblDiscount: UILabel!
    
    var addToWishlist: ProductClosure?
    var addToCart: ProductClosure?
    var data: ProductListModelData?
    var isFromWishlist: Bool = false
    
    
    @IBAction func cartButtonDidPush(_ sender: Any) {
        if let addToCart = addToCart, let data = data {
            addToCart(data)
        }
    }
    @IBAction func favouriteButtonDidPush(_ sender: Any) {
        if let addToWishlist = addToWishlist, let data = data {
            addToWishlist(data)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

}

extension ProductCollectionViewCell: CollectionViewCellProtocol{
    static func configure<T>(context: UIViewController, collectionView: UICollectionView, indexPath: IndexPath, object: T) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as! ProductCollectionViewCell
        guard let data = object as? ProductListModelData else { return cell }
        
        cell.imgProduct.af_setImage(withURL: URL(string: data.image!)!, placeholderImage: UIImage(named: "placeholder")) { [weak cell] image in
            guard let wc = cell else { return }
            if let img = image.value {
                wc.imgProduct.image = img
            } else {
                wc.imgProduct.image = UIImage(named: "placeholder")
            }
        }
        
        cell.data = data
        cell.lblName.text = data.name ?? ""
        cell.lblType.text = data.categoryName ?? ""
        cell.lblPrice1.text = String(data.discount ?? 0).asRupiah()
        cell.lblPrice2.text = String(data.price ?? 0).asRupiah()
        if data.discount == 0 {
            cell.viewDiscount.isHidden = true
        }else {
            cell.viewDiscount.isHidden = false
            cell.lblDiscount.text = String(data.discount ?? 0).asRupiah()
        }
        
        cell.viewCart.layer.cornerRadius = 10
        return cell
    }
    
    func setupView() {
        if isFromWishlist {
            btnFavorite.setImage(UIImage(named: "ico-buttonfavclicked"), for: .normal)
            btnFavorite.isSelected = true
            lblAction.text = "BUY PRODUCT"
            iconAction.image = UIImage(named: "ico-nav-arrow")
        } else {
            if data?.isFavourite ?? false {
                btnFavorite.setImage(UIImage(named: "ico-buttonfavclicked"), for: .normal)
                btnFavorite.isSelected = true
                lblAction.text = "BUY PRODUCT"
                iconAction.image = UIImage(named: "ico-nav-arrow")
            } else {
                btnFavorite.setImage(UIImage(named: "ico-buttonfav"), for: .normal)
                btnFavorite.isSelected = false
                lblAction.text = "BUY PRODUCT"
                iconAction.image = UIImage(named: "ico-nav-arrow")
            }
        }
    }
}
