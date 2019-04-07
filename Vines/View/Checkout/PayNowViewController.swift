//
//  PayNowViewController.swift
//  Vines
//
//  Created by Calista Bertha on 12/03/19.
//  Copyright © 2019 Calista Bertha. All rights reserved.
//

import UIKit

class PayNowViewController: VinesViewController {

    @IBOutlet weak var webView: UIWebView!
    var URLString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateNavBarWithBackButton(titleString: "PAYMENT", viewController: self, isRightBarButton: false, isNavbarColor: true)
        let urlString = URL.init(string: URLString)
        let urlRequest = URLRequest.init(url: urlString!)
        webView.loadRequest(urlRequest)
        webView.scrollView.bounces = false
       
    }

    override func backButtonDidPush() {
        navigationController?.popViewController(animated: true)
    }
}
