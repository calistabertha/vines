//
//  SummaryPartyViewController.swift
//  Vines
//
//  Created by Calista Bertha on 07/01/19.
//  Copyright © 2019 Calista Bertha. All rights reserved.
//

import UIKit

class SummaryPartyViewController: VinesViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateNavBarWithBackButton(titleString: "PARTY SERVICE", viewController: self, isRightBarButton: false)
        tableView.register(SummaryPersonalInfoTableViewCell.nib, forCellReuseIdentifier: SummaryPersonalInfoTableViewCell.identifier)
        tableView.register(LiquorSelectionTableViewCell.nib, forCellReuseIdentifier: LiquorSelectionTableViewCell.identifier)
        tableView.register(HeaderSectionStoreTableViewCell.nib, forCellReuseIdentifier: HeaderSectionStoreTableViewCell.identifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    override func backButtonDidPush() {
        navigationController?.popViewController(animated: true)
    }

}

extension SummaryPartyViewController: UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return CGFloat.leastNormalMagnitude
        }else{
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 411
        }
        return 198
    }

}

extension SummaryPartyViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            return SummaryPersonalInfoTableViewCell.configure(context: self, tableView: tableView, indexPath: indexPath, object: "")
        }else{
            return LiquorSelectionTableViewCell.configure(context: self, tableView: tableView, indexPath: indexPath, object: "")
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: HeaderSectionStoreTableViewCell.identifier) as! HeaderSectionStoreTableViewCell
            cell.lblTitle.text = "LIQUOR SELECTION"
            cell.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
            return cell
            
        }
        
        return UIView()
    }
}
