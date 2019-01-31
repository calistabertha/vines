//
//  AllOrderViewController.swift
//  Vines
//
//  Created by Calista Bertha on 29/01/19.
//  Copyright © 2019 Calista Bertha. All rights reserved.
//

import UIKit
protocol AllOderDelegate: class {
    func recentButtonDidPush()
    func historyButtonDidPush()
}

class AllOrderViewController: VinesViewController {
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var btnRecent: UIButton!
    @IBOutlet weak var btnHistory: UIButton!
    @IBOutlet weak var separatorRecent: UIView!
    @IBOutlet weak var separatorHistory: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var delegate: AllOderDelegate?
    var recentOrderList: [OrderModelData] = []
    var historyOrderList: [OrderModelData] = []
    
    var isRecentOrder: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchOrder()
        tableView.register(OrderTableViewCell.nib, forCellReuseIdentifier: OrderTableViewCell.identifier)
        generateNavBarWithBackButton(titleString: "ALL ORDERS", viewController: self, isRightBarButton: false, isNavbarColor: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    
    func fetchOrder() {
        let params = [
            "limit": "10",
            "offset": "0",
            "user_id": userDefault().getUserID(),
            "token": userDefault().getToken()
            
            ] as [String : Any]
        HTTPHelper.shared.requestAPI(url: Constants.ServicesAPI.Order.list, param: params, method: HTTPMethodHelper.post) { [weak self] (success, json) in
            let data = OrderModelBaseClass(json: json ?? "")
            if data.message == "success" {
                for item in data.data ?? [] {
                    if item.paymentStatus == "Waiting Payment" {
                        self?.recentOrderList.append(item)
                    } else {
                        self?.historyOrderList.append(item)
                    }
                }
                self?.tableView.reloadData()
            } else {
                print(data.displayMessage ?? "")
            }
        }
    }
    
    override func backButtonDidPush() {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func recentOrderButtonDidPush(_ sender: Any) {
        isRecentOrder = true
        tableView.reloadData()
        btnRecent.setTitleColor(UIColor(red: 125/255, green: 6/255, blue: 15/255, alpha: 1), for: .normal)
        separatorRecent.backgroundColor = UIColor(red: 125/255, green: 6/255, blue: 15/255, alpha: 1)
        btnHistory.setTitleColor(UIColor(red: 155/255, green: 155/255, blue: 155/255, alpha: 1), for: .normal)
        separatorHistory.backgroundColor = UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 1)
    }
    
    @IBAction func historyOrderButtonDidPush(_ sender: Any) {
        isRecentOrder = false
        tableView.reloadData()
        btnHistory.setTitleColor(UIColor(red: 125/255, green: 6/255, blue: 15/255, alpha: 1), for: .normal)
        separatorHistory.backgroundColor = UIColor(red: 125/255, green: 6/255, blue: 15/255, alpha: 1)
        btnRecent.setTitleColor(UIColor(red: 155/255, green: 155/255, blue: 155/255, alpha: 1), for: .normal)
        separatorRecent.backgroundColor = UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 1)
    }
}

extension AllOrderViewController: UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if isRecentOrder {
                return recentOrderList.count
            } else {
                return 0
            }
        } else {
            if isRecentOrder {
                return 0
            } else {
                return historyOrderList.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

extension AllOrderViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            return OrderTableViewCell.configure(context: self, tableView: tableView, indexPath: indexPath, object: recentOrderList)
        } else {
            return OrderTableViewCell.configure(context: self, tableView: tableView, indexPath: indexPath, object: historyOrderList)
        }
    }
}
