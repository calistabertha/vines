//
//  DetailNewsViewController.swift
//  Vines
//
//  Created by Calista Bertha on 28/12/18.
//  Copyright © 2018 Calista Bertha. All rights reserved.
//

import UIKit

class DetailNewsViewController: VinesViewController {
    @IBOutlet weak var imgNews: UIImageView!
    var titleNav: String?
    var imgURL: String?
    var strings = ""
    
    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        generateNavBarWithBackButton(titleString: titleNav ?? "", viewController: self, isRightBarButton: false, isNavbarColor: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let htmlString = "<p style=\"text-align:justify\">\(strings)</p>"
        webView.loadHTMLString(htmlString, baseURL: nil)
        webView.scrollView.showsVerticalScrollIndicator = false
        
        imgNews.af_setImage(withURL: URL(string: imgURL ?? "")!, placeholderImage: UIImage(named: "placeholder")) { [weak self] image in
            guard let ws = self else { return }
            if let img = image.value {
                ws.imgNews.image = img
            } else {
                ws.imgNews.image = UIImage(named: "placeholder")
            }
        }
    }
    
    override func backButtonDidPush() {
        navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     
    }
  
}
