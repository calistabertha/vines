//
//  BannerView.swift
//  BukalapakHome
//
//  Created by Patrick Marshall on 16/07/18.
//  Copyright © 2018 Patrick Marshall. All rights reserved.
//

import UIKit

class BannerView: UIView {
    @IBOutlet weak var bannerImage: UIImageView!
    
    public class func instantiateFromNib() -> BannerView {
        return UINib(nibName: "BannerView", bundle: nil).instantiate(withOwner: nil, options: [:])[0] as! BannerView
    }
}
