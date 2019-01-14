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
    var strings = "The campaign is inspired by the Bacardi-owned brand’s “obsession with\r\n doing things twice to make them better” – a tribute to its \r\ndouble-ageing process.\r\nRunning until the end of 2019, the new television advert debuted in \r\nthe US yesterday (22 October) and will roll out across Spain, Puerto \r\nRico, the Dominican Republic and Lebanon, among other countries. It will\r\n also feature print, digital, social and out-of-home executions.\r\n<br><br>The campaign re-launch is part of Dewar’s wider strategy to drive \r\ngrowth across its entire portfolio, with a “renewed focus on \r\ninnovation”.\r\nThe brand will also focus on its Dewar’s 12, Dewar’s 15 and Dewar’s \r\n18 expressions, with the aim of doubling distribution in the next year.\r\nScottish actor Iain Glen serves as the narrator for the television \r\nspot, telling the tale of a man named Neville Neville who is dedicated \r\nto doing things twice.\r\n“Live True is a bold embodiment of Dewar’s as a brand,” said Adam Oakley, global vice president, Dewar’s.\r\n“<br><br>This campaign is just the beginning [of] robust global efforts to \r\nlift the veil off not just Dewar’s, but the Scotch whisky category as a \r\nwhole, showing the craftsmanship and approachability behind this storied\r\n spirit.”\r\n<span>Brian Cox, vice president of Dewar’s in North America, added: “This \r\nis the first globally integrated campaign in five years, and with that \r\nthe business is doubling down on Dewar’s by revamping the brand’s \r\nmerchandising programme, fuelling the growth of its premium marques, and\r\n reshaping its on-premise experiential and sampling strategy.”<br><br>(source: </span><a target=\"_blank\" rel=\"nofollow\" href=\"https://www.thespiritsbusiness.com/2018/10/dewars-invests-15m-in-live-true-campaign/\">https://www.thespiritsbusiness.com/2018/10/dewars-invests-15m-in-live-true-campaign/</a>)"
    
    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        generateNavBarWithBackButton(titleString: titleNav ?? "", viewController: self, isRightBarButton: false)
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
