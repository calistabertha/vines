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
    func goShoppingButtonDidPush()
}

class DetailStoreView: UIView, Modal {
    var backgroundView = UIView()
    var dialogView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var viewCalling: UIView!
    @IBOutlet weak var btnGoShopping: UIButton!
    weak var delegate: DetailStoreViewDelegate?
    
    private func setupView() {
        Bundle.main.loadNibNamed("DetailStoreView", owner: self, options: nil)
        self.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.addSubview(contentView)
        layoutIfNeeded()
        
        btnClose.layer.cornerRadius = btnClose.frame.size.height / 2
        viewCalling.layer.cornerRadius = viewCalling.frame.width / 2
        viewCalling.layer.borderWidth = 2
        viewCalling.layer.borderColor = UIColor(red: 125/255.0, green: 6/255.0, blue: 15/255.0, alpha: 1).cgColor
        btnGoShopping.layer.cornerRadius = 5
    }
    
    @IBAction func closeButtonDidPush(_ sender: Any) {
        delegate?.closeButtonDidPush(self)
    }
    
    @IBAction func goShoppingButtonDidPush(_ sender: Any) {
        delegate?.goShoppingButtonDidPush()
    }
}
