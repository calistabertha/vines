//
//  ProductTableViewCell.swift
//  Vines
//
//  Created by Calista Bertha on 09/12/18.
//  Copyright © 2018 Calista Bertha. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.register(ProductCollectionViewCell.nib, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
            
            collectionView.dataSource = self
            collectionView.delegate  = self
            collectionView.isScrollEnabled = false
        }
    }
    
    internal var context: UIViewController?
    var list: [ProductListModelData] = []
    var size: CGSize = CGSize(width: 0, height: 0)
    var addToCart: ProductClosure?
    var addToWishlist: ProductClosure?
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

extension ProductTableViewCell: TableViewCellProtocol {
    static func configure<T>(context: UIViewController, tableView: UITableView, indexPath: IndexPath, object: T) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier, for: indexPath) as! ProductTableViewCell
        guard let data = object as? [ProductListModelData] else { return cell }
        cell.list = data
        cell.context = context
        cell.collectionView.reloadData()
        return cell
    }
}

extension ProductTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailProductViewController()
        vc.product = list[indexPath.row]
        self.context?.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ProductTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let ctx = self.context {
            let data = list[indexPath.row]
            let cell = ProductCollectionViewCell.configure(context: ctx, collectionView: collectionView, indexPath: indexPath, object: data) as! ProductCollectionViewCell
            cell.setupView()
            cell.addToCart = addToCart
            cell.addToWishlist = addToWishlist
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
}

extension ProductTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return size
    }
}
