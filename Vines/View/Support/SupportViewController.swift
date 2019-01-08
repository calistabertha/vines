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
    override func viewDidLoad() {
        super.viewDidLoad()
        generateNavBarWithBackButton(titleString: "SUPPORT", viewController: self, isRightBarButton: false)
        tableView.register(SupportTableViewCell.nib, forCellReuseIdentifier: SupportTableViewCell.identifier)
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func backButtonDidPush() {
        navigationController?.popViewController(animated: true)
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
            let vc = StaticPageViewController()
            vc.titleString = "PRIVACY POLICY"
            navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 2 {
            let vc = StaticPageViewController()
            vc.titleString = "TERM & CONDITION"
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension SupportViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return SupportTableViewCell.configure(context: self, tableView: tableView, indexPath: indexPath, object: "")
      
    }
}
