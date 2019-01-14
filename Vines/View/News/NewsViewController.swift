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
    
    var newsList: [NewsModelData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(NewsTableViewCell.nib, forCellReuseIdentifier: NewsTableViewCell.identifier)
        generateNavBarWithBackButton(titleString: "NEWS", viewController: self, isRightBarButton: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchNews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    override func backButtonDidPush() {
        navigationController?.popViewController(animated: true)
    }
    
    func fetchNews() {
        let params = [
            "limit": "10",
            "offset": "0"
            ] as [String : Any]
        HTTPHelper.shared.requestAPI(url: Constants.ServicesAPI.News.news, param: params, method: HTTPMethodHelper.post) { (success, json) in
            let data = NewsModelBaseClass(json: json!)
            if data.message == "success" {
                self.newsList = data.data!
                self.tableView.reloadData()
            } else {
                print(data.displayMessage!)
            }
        }
    }
}

extension NewsViewController: UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailNewsViewController()
        guard let data = newsList[safe: indexPath.row] else { return }
        vc.titleNav = data.title ?? ""
        vc.strings = data.descriptionValue ?? ""
        vc.imgURL = data.image ?? ""
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension NewsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return NewsTableViewCell.configure(context: self, tableView: tableView, indexPath: indexPath, object: newsList)
    }
}
