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
    var orderList: [OrderModelData] = []
    
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
        HTTPHelper.shared.requestAPI(url: Constants.ServicesAPI.Order.list, param: params, method: HTTPMethodHelper.post) { (success, json) in
            let data = OrderModelBaseClass(json: json ?? "")
            if data.message == "success" {
                self.orderList = data.data!
                self.tableView.reloadData()
            } else {
                print(data.displayMessage!)
            }
        }
    }
    
    override func backButtonDidPush() {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func recentOrderButtonDidPush(_ sender: Any) {
        btnRecent.setTitleColor(UIColor(red: 125/255, green: 6/255, blue: 15/255, alpha: 1), for: .normal)
        separatorRecent.backgroundColor = UIColor(red: 125/255, green: 6/255, blue: 15/255, alpha: 1)
        btnHistory.setTitleColor(UIColor(red: 155/255, green: 155/255, blue: 155/255, alpha: 1), for: .normal)
        separatorHistory.backgroundColor = UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 1)
    }
    
    @IBAction func historyOrderButtonDidPush(_ sender: Any) {
        btnHistory.setTitleColor(UIColor(red: 125/255, green: 6/255, blue: 15/255, alpha: 1), for: .normal)
        separatorHistory.backgroundColor = UIColor(red: 125/255, green: 6/255, blue: 15/255, alpha: 1)
        btnRecent.setTitleColor(UIColor(red: 155/255, green: 155/255, blue: 155/255, alpha: 1), for: .normal)
        separatorRecent.backgroundColor = UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 1)
    }
}

extension AllOrderViewController: UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderList.count
    }
    
}

extension AllOrderViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return OrderTableViewCell.configure(context: self, tableView: tableView, indexPath: indexPath, object: orderList)
    }
}
