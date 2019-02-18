//
//  DetailStore.swift
//  Vines
//
//  Created by Calista Bertha on 31/10/18.
//  Copyright © 2018 Calista Bertha. All rights reserved.
//

import UIKit
@objc protocol DetailStoreViewDelegate: class {
    func closeButtonDidPush(_ view: DetailStoreView)
    func goShoppingButtonDidPush(_ view: DetailStoreView)
    func callingButtonDidPush(phoneNumber: String)
}

class DetailStoreView: UIView, Modal {
    var backgroundView = UIView()
    var dialogView = UIView()
    var data: StoreListModelData?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBInspectable var nibName:String?{
        return "DetailStoreView"
    }

    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var viewCalling: UIView!
    @IBOutlet weak var btnGoShopping: UIButton!
    @IBOutlet weak var imgStore: UIImageView!
    @IBOutlet weak var lblStoreName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblTimeOpen: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    weak var delegate: DetailStoreViewDelegate?
    
    private func setupView() {
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask =
            [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
        contentView = view
        layoutIfNeeded()
        
        btnClose.layer.cornerRadius = btnClose.frame.size.height / 2
        viewCalling.layer.cornerRadius = viewCalling.frame.width / 2
        viewCalling.layer.borderWidth = 2
        viewCalling.layer.borderColor = UIColor(red: 125/255.0, green: 6/255.0, blue: 15/255.0, alpha: 1).cgColor
        btnGoShopping.layer.cornerRadius = 5
        spinner.isHidden = true
    }
    
    func setupViewData() {
        imgStore.af_setImage(withURL: URL(string: data?.image ?? "")!)
        lblStoreName.text = data?.name ?? ""
        lblTimeOpen.text = data?.open ?? ""
        lblAddress.text = data?.address ?? ""
    }
    
    func loadViewFromNib() -> UIView! {
        guard let nibName = nibName else { return nil }
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(
            withOwner: self,
            options: nil).first as? UIView
    }
    
    @IBAction func callingButtonDidPush(_ sender: Any) {
        delegate?.callingButtonDidPush(phoneNumber: data?.phone ?? "")
    }
    
    @IBAction func closeButtonDidPush(_ sender: Any) {
        delegate?.closeButtonDidPush(self)
    }
    
    @IBAction func goShoppingButtonDidPush(_ sender: UIButton) {
        sender.setTitle("", for: .normal)
        self.spinner.isHidden = false
        self.spinner.startAnimating()
        delegate?.goShoppingButtonDidPush(self)
    }
}
