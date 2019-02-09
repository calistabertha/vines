//
//  FeatureProductCollectionViewCell.swift
//  Vines
//
//  Created by Calista Bertha on 09/12/18.
//  Copyright © 2018 Calista Bertha. All rights reserved.
//

import UIKit

class FeatureProductCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var viewShadow: UIView!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var viewAddToCart: UIView!
    @IBOutlet weak var viewDiscount: UIView!
    @IBOutlet weak var lblDiscount: UILabel!
    
    var addToCart : ((UICollectionViewCell) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    @IBAction func addToCart(_ sender: Any) {
        addToCart?(self)
    }
    
}

extension FeatureProductCollectionViewCell : CollectionViewCellProtocol{
    static func configure<T>(context: UIViewController, collectionView: UICollectionView, indexPath: IndexPath, object: T) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeatureProductCollectionViewCell.identifier, for: indexPath) as! FeatureProductCollectionViewCell
        guard let data = object as? ProductListModelData else { return cell }
        cell.viewAddToCart.layer.cornerRadius = cell.viewAddToCart.frame.height / 2
        cell.imgProduct.af_setImage(withURL: URL(string: data.image!)!, placeholderImage: UIImage(named: "placeholder")) { [weak cell] image in
            guard let wc = cell else { return }
            if let img = image.value {
                wc.imgProduct.image = img
            } else {
                wc.imgProduct.image = UIImage(named: "placeholder")
            }
        }
        
//        let botomLayer = CAGradientLayer()
//        botomLayer.frame = cell.viewShadow.bounds;
//        botomLayer.colors = [UIColor.black.withAlphaComponent(1).cgColor, UIColor.white.withAlphaComponent(0.7).cgColor, UIColor.white.withAlphaComponent(0).cgColor ]
//        botomLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
//        botomLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
//        cell.viewShadow.layer.mask = botomLayer
        
        cell.lblName.text = data.name?.uppercased() ?? ""
        cell.lblType.text = data.categoryName ?? ""
        if data.discount == 0 {
            cell.viewDiscount.isHidden = true
        }else {
            cell.viewDiscount.isHidden = false
            cell.lblDiscount.text = "\(data.discount ?? 0) %"
        }
        
        guard let ctx = context as? StoreViewController else {return cell}
        cell.addToCart = {
            (cells) in
            ctx.addToCart(data, isBuyProduct: false)
            
        }
        
        return cell
    }
}

