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
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var viewContinueShop: UIView!
    @IBOutlet weak var viewEmpty: UIView!
    
    var list: [ProductListModelData] = []
    var storeName: String?
    var storeID: Int?
    var collectionItemSize: CGSize = CGSize(width: 0, height: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateNavBarWithBackButton(titleString: "WISHLIST", viewController: self, isRightBarButton: false, isNavbarColor: true)
        viewContinueShop.layer.cornerRadius = viewContinueShop.frame.height / 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        spinner.startAnimating()
        collectionItemSize = calculateSize()
        fetchWishlist()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    override func backButtonDidPush() {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func continueShoppingButtonDidPush(_ sender: Any) {
        
    }
    
    func fetchWishlist() {
        let params = [
            "limit": 10,
            "user_id": userDefault().getUserID(),
            "offset": 0,
            "token": userDefault().getToken()
            ] as [String : Any]
        HTTPHelper.shared.requestAPI(url: Constants.ServicesAPI.User.wishlist, param: params, method: HTTPMethodHelper.post) { (success, json) in
            let data = ProductListModelBaseClass(json: json ?? "")
            if data.message?.lowercased() == "success", let datas = data.data {
                self.list = datas
                self.collectionView.reloadData()
                if self.list.count > 0 {
                    self.viewEmpty.isHidden = true
                }else {
                    self.viewEmpty.isHidden = false
                }
            } else {
                print(data.displayMessage ?? "")
            }
            self.spinner.stopAnimating()
            self.spinner.isHidden = true
        }
    }
    
    func removeWishlist(_ product: ProductListModelData) {
        let params = [
            "user_id": userDefault().getUserID(),
            "product_id": product.productId ?? 0,
            "token": userDefault().getToken()
            ] as [String: Any]
        HTTPHelper.shared.requestAPI(url: Constants.ServicesAPI.User.deleteWishlist, param: params, method: HTTPMethodHelper.post) { (success, json) in
            let data = ProductListModelBaseClass(json: json ?? "")
            if data.message?.lowercased() == "success" {
                let index: Int? = self.list.index { $0.productId == product.productId }
                if index != nil {
                    self.list.remove(at: index!)
                }
                self.collectionView.reloadData()
            } else {
                print(data.displayMessage ?? "")
            }
        }
    }
    
    func buyProduct(_ product: ProductListModelData) {
        ProductListCollection.shared.products.append(product)
        let vc = ShoppingCartViewController()
        vc.storeName = product.storeName
        vc.storeID = product.storeId
        //vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension WishlistViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailProductViewController()
        vc.productID = list[indexPath.row].productId
        //vc.storeIDCode = ctx.storeIDCode
        vc.storeName = list[indexPath.row].storeName
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension WishlistViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = list[indexPath.row]
        let cell = ProductCollectionViewCell.configure(context: self, collectionView: collectionView, indexPath: indexPath, object: data) as! ProductCollectionViewCell
        cell.isFromWishlist = true
        cell.setupView()
        cell.addToCart = { [weak self] int in
            guard let ws = self else { return }
            ws.buyProduct(data)
        }
        cell.addToWishlist = { [weak self] data in
            guard let ws = self else { return }
            ws.removeWishlist(data)
        }
        return cell
       
    }
    
}

extension WishlistViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionItemSize
    }
}

