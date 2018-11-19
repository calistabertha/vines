//
//  DetailProductViewController.swift
//  Vines
//
//  Created by Calista Bertha on 31/10/18.
//  Copyright © 2018 Calista Bertha. All rights reserved.
//

import UIKit

class DetailProductViewController: VinesViewController {

    var productName: String = "WINE"
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func setupView() {
         generateNavBarWithBackButton(titleString: productName, viewController: self, isRightBarButton: true)
    }
    
    override func backButtonDidPush() {
        navigationController?.popViewController(animated: true)
    }


}
