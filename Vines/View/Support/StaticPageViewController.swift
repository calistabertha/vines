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
    var staticPage: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateNavBarWithBackButton(titleString: titleString ?? "" , viewController: self, isRightBarButton: false, isNavbarColor: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let htmlString = "<p style=\"text-align:justify\">\(staticPage)</p>"
        webView.loadHTMLString(htmlString, baseURL: nil)
        webView.scrollView.showsVerticalScrollIndicator = false
    }

    override func backButtonDidPush() {
        navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}
