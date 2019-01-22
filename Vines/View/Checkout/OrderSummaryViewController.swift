//
//  OrderSummaryViewController.swift
//  Vines
//
//  Created by Calista Bertha on 19/01/19.
//  Copyright © 2019 Calista Bertha. All rights reserved.
//

import UIKit

class OrderSummaryViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnNext: UIButton!
    
    var isCodeApplied = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ListOrderTableViewCell.nib, forCellReuseIdentifier: ListOrderTableViewCell.identifier)
        tableView.register(DiscountCodeTableViewCell.nib, forCellReuseIdentifier: DiscountCodeTableViewCell.identifier)
        tableView.register(ApplyDiscountTableViewCell.nib, forCellReuseIdentifier: ApplyDiscountTableViewCell.identifier)
        tableView.register(SummaryTableViewCell.nib, forCellReuseIdentifier: SummaryTableViewCell.identifier)
        btnNext.layer.cornerRadius = 5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     
    }
    
    @IBAction func nextButtonDidPush(_ sender: Any) {
    }
}

extension OrderSummaryViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 237
        } else if indexPath.row == 1 {
            if isCodeApplied {
                return 194
            }else{
                return 163
            }
        }else if indexPath.row == 2 {
            return 215
        }
        
        return 0
    }
}

extension OrderSummaryViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ListOrderTableViewCell.identifier, for: indexPath) as! ListOrderTableViewCell
            return cell
        }else if indexPath.row == 1 {
            if isCodeApplied{
                let cell = tableView.dequeueReusableCell(withIdentifier: ApplyDiscountTableViewCell.identifier, for: indexPath) as! ApplyDiscountTableViewCell
                return cell
            }else {
                let cell = tableView.dequeueReusableCell(withIdentifier: DiscountCodeTableViewCell.identifier, for: indexPath) as! DiscountCodeTableViewCell
                return cell
            }
        }else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SummaryTableViewCell.identifier, for: indexPath) as! SummaryTableViewCell
            return cell
        }
        return UITableViewCell()
        
    }
}
