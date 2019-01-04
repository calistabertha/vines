//
//  PromotionsViewController.swift
//  Vines
//
//  Created by Calista Bertha on 27/12/18.
//  Copyright © 2018 Calista Bertha. All rights reserved.
//

import UIKit

class PromotionsViewController: VinesViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        generateNavBarWithBackButton(titleString: "PROMOTIONS", viewController: self, isRightBarButton: false)
        tableView.register(PromotionTableViewCell.nib, forCellReuseIdentifier: PromotionTableViewCell.identifier)
        tableView.register(HeaderSectionStoreTableViewCell.nib, forCellReuseIdentifier: HeaderSectionStoreTableViewCell.identifier)
        tableView.register(HeaderStoreTableViewCell.nib, forCellReuseIdentifier: HeaderStoreTableViewCell.identifier)
    }
    
    var promotionList: [PromotionModelData] = []

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    override func backButtonDidPush() {
        navigationController?.popViewController(animated: true)
    }
}

extension PromotionsViewController: UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return self.promotionList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 0 //211
        }
        return 201
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return CGFloat.leastNormalMagnitude
        }else{
            return 0 //40
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let vc = DetailPromoViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension PromotionsViewController: UITableViewDataSource{
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        if section == 1 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: HeaderSectionStoreTableViewCell.identifier) as! HeaderSectionStoreTableViewCell
//            cell.lblTitle.text = "PROMO"
//            return cell
//
//        }
//
//        return UIView()
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
//            return HeaderStoreTableViewCell.configure(context: self, tableView: tableView, indexPath: indexPath, object: "")
            return UITableViewCell()
        } else if indexPath.section == 1 {
            return PromotionTableViewCell.configure(context: self, tableView: tableView, indexPath: indexPath, object: promotionList)
        }
        
        return UITableViewCell()
    }
}
