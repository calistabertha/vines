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
        let replaceString = staticPage.replacingOccurrences(of: "<div>", with: "").replacingOccurrences(of: "<b>", with: "<p style=\"text-align:justify; font-family: Roboto-Bold\">").replacingOccurrences(of: "<span>", with: "").replacingOccurrences(of: "<li>", with: "<li style=\"text-align:justify; font-family: Roboto-Regular\">")
        let htmlString = "<p style=\"text-align:justify; font-family: Roboto-Regular\">\(replaceString)</p>"
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
