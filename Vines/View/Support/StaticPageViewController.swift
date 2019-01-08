//
//  StaticPageViewController.swift
//  Vines
//
//  Created by Calista Bertha on 05/01/19.
//  Copyright © 2019 Calista Bertha. All rights reserved.
//

import UIKit

class StaticPageViewController: VinesViewController {

    @IBOutlet weak var webView: UIWebView!
    var titleString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateNavBarWithBackButton(titleString: titleString ?? "" , viewController: self, isRightBarButton: false)
    }

    override func backButtonDidPush() {
        navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}
