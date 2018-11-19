//
//  VinesViewController.swift
//  Vines
//
//  Created by Calista Bertha on 20/10/18.
//  Copyright © 2018 Calista Bertha. All rights reserved.
//

import UIKit

class VinesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func generateNavBarWithBackButton(titleString: String, viewController: VinesViewController, isRightBarButton: Bool) {
        for view in navigationController?.navigationBar.subviews ?? [UIView]() {
            if view.tag == 100 {
                view.removeFromSuperview()
            }
        }
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barTintColor = UIColor.white
        UIApplication.shared.isStatusBarHidden = false
        let titleLabel = UILabel(frame: CGRect.zero)
        titleLabel.text = titleString
        titleLabel.font = UIFont.init(name: "RobotoCondensed-Bold", size: 16.0)
        titleLabel.textColor = UIColor(red: 125/255.0, green: 6/255.0, blue: 15/255.0, alpha: 1.0)
        titleLabel.sizeToFit()
     
        navigationController?.visibleViewController?.navigationItem.titleView = titleLabel
        navigationController?.navigationBar.tintColor = UIColor.init(red: 67/255.0, green: 83/255.0, blue: 96/255.0, alpha: 1.0)
        
        let imageBack = UIImage.init(named: "ico-nav-arrowleft")
        let backButton = UIBarButtonItem.init(image: imageBack, style: .plain, target: viewController, action: #selector(backButtonDidPush))
        navigationController?.visibleViewController?.navigationItem.leftBarButtonItem = backButton
        
        if isRightBarButton{
            let imageCart = UIImage.init(named: "ico-nav-arrowleft")
            let cartButton = UIBarButtonItem.init(image: imageCart, style: .plain, target: viewController, action: #selector(cartButtonDidPush))
            navigationController?.visibleViewController?.navigationItem.rightBarButtonItem = cartButton
        }
    }

    @objc func backButtonDidPush() {}
    
    @objc func cartButtonDidPush() {}
}
