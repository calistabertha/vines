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
        
        cell.context = context
        print("context \(context)")
        /*
         guard let data = object as? FeedModel else { return cell }
         
         cell.similarData.append(data)
         
         */
        return cell
    }
}

extension FeatureProductTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailProductViewController()
        self.context?.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension FeatureProductTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4 //data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       // let data = similarData[indexPath.row]
        
        if let ctx = self.context {
            return FeatureProductCollectionViewCell.configure(context: ctx, collectionView: collectionView, indexPath: indexPath, object: "")
        } else {
            return UICollectionViewCell()
        }
    }
}

extension FeatureProductTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/3, height: collectionView.frame.size.height)
    }
}
