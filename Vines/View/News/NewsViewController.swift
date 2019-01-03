//
//  NewsViewController.swift
//  Vines
//
//  Created by Calista Bertha on 28/12/18.
//  Copyright © 2018 Calista Bertha. All rights reserved.
//

import UIKit

class NewsViewController: VinesViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(NewsTableViewCell.nib, forCellReuseIdentifier: NewsTableViewCell.identifier)
        generateNavBarWithBackButton(titleString: "NEWS", viewController: self, isRightBarButton: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    override func backButtonDidPush() {
        navigationController?.popViewController(animated: true)
    }
}

extension NewsViewController: UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailNewsViewController()
        vc.titleNav = "TITLE"
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension NewsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return NewsTableViewCell.configure(context: self, tableView: tableView, indexPath: indexPath, object: "")
    }
}
