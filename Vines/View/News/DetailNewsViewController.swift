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
    @IBOutlet weak var tableView: UITableView!
    var titleNav: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(WebViewTableViewCell.nib, forCellReuseIdentifier: WebViewTableViewCell.identifier)
        generateNavBarWithBackButton(titleString: titleNav ?? "", viewController: self, isRightBarButton: false)
        
    }
    
    override func backButtonDidPush() {
        navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     
    }
  
}

extension DetailNewsViewController: UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}

extension DetailNewsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return WebViewTableViewCell.configure(context: self, tableView: tableView, indexPath: indexPath, object: "")
    }
}
