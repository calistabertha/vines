//
//  FeatureProductTableViewCell.swift
//  Vines
//
//  Created by Calista Bertha on 09/12/18.
//  Copyright © 2018 Calista Bertha. All rights reserved.
//

import UIKit

class FeatureProductTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.register(FeatureProductCollectionViewCell.nib, forCellWithReuseIdentifier: FeatureProductCollectionViewCell.identifier)
            
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    internal var context: UIViewController?
    var list: [ProductListModelData] = []
    var size: CGSize = CGSize(width: 0, height: 0)
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

extension FeatureProductTableViewCell: TableViewCellProtocol {
    static func configure<T>(context: UIViewController, tableView: UITableView, indexPath: IndexPath, object: T) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeatureProductTableViewCell.identifier, for: indexPath) as! FeatureProductTableViewCell
        guard let data = object as? [ProductListModelData] else { return cell }
        cell.context = context
        cell.list = data
        cell.collectionView.reloadData()
        return cell
    }
}

extension FeatureProductTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         guard let ctx = context as? StoreViewController else {return}
        let vc = DetailProductViewController()
        vc.product = list[indexPath.row]
        vc.storeID = ctx.storeId
        vc.storeName = ctx.storeName
        self.context?.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension FeatureProductTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let ctx = self.context {
            let data = list[indexPath.row]
            return FeatureProductCollectionViewCell.configure(context: ctx, collectionView: collectionView, indexPath: indexPath, object: data)
        } else {
            return UICollectionViewCell()
        }
    }
}

extension FeatureProductTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return size
    }
}
