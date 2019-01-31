//
//  SupportViewController.swift
//  Vines
//
//  Created by Calista Bertha on 04/01/19.
//  Copyright © 2019 Calista Bertha. All rights reserved.
//

import UIKit

class SupportViewController: VinesViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var termsData: String?
    var privacyData: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchPrivacyPolicy()
        fetchTermsConditions()
        
        generateNavBarWithBackButton(titleString: "SUPPORT", viewController: self, isRightBarButton: false, isNavbarColor: true)
        tableView.register(SupportTableViewCell.nib, forCellReuseIdentifier: SupportTableViewCell.identifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func backButtonDidPush() {
        navigationController?.popViewController(animated: true)
    }
    
    func fetchTermsConditions() {
        let params = [:] as [String : Any]
        HTTPHelper.shared.requestAPI(url: Constants.ServicesAPI.News.terms, param: params, method: HTTPMethodHelper.post) { (success, json) in
            let data = StaticPageModelBaseClass(json: json ?? "")
            if data.message?.lowercased() == "success", let datas = data.data?[safe: 0]?.descriptionValue {
                self.termsData = datas
                self.tableView.reloadData()
            } else {
                print(data.displayMessage ?? "")
            }
        }
    }
    
    func fetchPrivacyPolicy() {
        let params = [:] as [String : Any]
        HTTPHelper.shared.requestAPI(url: Constants.ServicesAPI.News.privacy, param: params, method: HTTPMethodHelper.post) { (success, json) in
            let data = StaticPageModelBaseClass(json: json ?? "")
            if data.message?.lowercased() == "success", let datas = data.data?[safe: 0]?.descriptionValue {
                self.privacyData = datas
                self.tableView.reloadData()
            } else {
                print(data.displayMessage ?? "")
            }
        }
    }
}

extension SupportViewController: UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 88
        }
        return 56
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = ContactUsViewController()
            navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 1 {
            guard let data = privacyData else { return }
            let vc = StaticPageViewController()
            vc.titleString = "PRIVACY POLICY"
            vc.staticPage = data
            navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 2 {
            guard let data = termsData else { return }
            let vc = StaticPageViewController()
            vc.titleString = "TERM & CONDITION"
            vc.staticPage = data
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension SupportViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return SupportTableViewCell.configure(context: self, tableView: tableView, indexPath: indexPath, object: "")
      
    }
}
