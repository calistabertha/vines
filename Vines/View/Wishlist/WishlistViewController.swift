//
//  WishlistViewController.swift
//  Vines
//
//  Created by Calista Bertha on 26/12/18.
//  Copyright © 2018 Calista Bertha. All rights reserved.
//

import UIKit

class WishlistViewController: VinesViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.register(ProductCollectionViewCell.nib, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
            
            collectionView.dataSource = self
            collectionView.delegate  = self
        }
    }
    
    @IBOutlet weak var viewContinueShop: UIView!
    @IBOutlet weak var viewEmpty: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateNavBarWithBackButton(titleString: "WISHLIST", viewController: self, isRightBarButton: false)
        viewContinueShop.layer.cornerRadius = viewContinueShop.frame.height / 2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    override func backButtonDidPush() {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func continueShoppingButtonDidPush(_ sender: Any) {
        
    }
    
}

extension WishlistViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailProductViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension WishlistViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return ProductCollectionViewCell.configure(context: self, collectionView: collectionView, indexPath: indexPath, object: "wishlist")
       
    }
    
}

extension WishlistViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/2 - 10, height: collectionView.frame.size.height/2 + 5)
    }
}

