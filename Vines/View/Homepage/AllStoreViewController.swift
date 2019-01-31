//
//  AllStoreViewController.swift
//  Vines
//
//  Created by Calista Bertha on 09/12/18.
//  Copyright © 2018 Calista Bertha. All rights reserved.
//

import UIKit
import CoreLocation

class AllStoreViewController: VinesViewController {
    @IBOutlet weak var viewDropDown: UIView!
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            let xib = AllStoreTableViewCell.nib
            tableView.register(xib, forCellReuseIdentifier: AllStoreTableViewCell.identifier)
        }
    }
    
    var location: CLLocation = CLLocation(latitude: 106.818477, longitude: -6.282391)
    var storeList:[StoreListModelData] = []
    var stores: StoreListModelData?
    var detail: DetailStoreView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchStore()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    private func setupView() {
        generateNavBarWithBackButton(titleString: "ALL STORE", viewController: self, isRightBarButton: false, isNavbarColor: true)
        viewDropDown.layer.cornerRadius = viewDropDown.frame.width / 2
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    private func fetchStore() {
        let params = [
            "longitude": "106.8694690",//self.location.coordinate.longitude,
            "latitude": "-6.2732980" //self.location.coordinate.latitude
            ] as [String : Any]
        HTTPHelper.shared.requestAPI(url: Constants.ServicesAPI.Store.list, param: params, method: HTTPMethodHelper.post) { (success, json) in
            let data = StoreListModelBaseClass(json: json ?? "")
            if data.message?.lowercased() == "success" {
                self.storeList = data.data!
                self.tableView.reloadData()
            } else {
                print(data.displayMessage ?? "")
            }
        }
    }
    
    override func backButtonDidPush() {
        navigationController?.popViewController(animated: true)
        if detail != nil {
            detail?.dismiss(animated: true)
        }
    }
    
}

extension AllStoreViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.storeList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension AllStoreViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AllStoreTableViewCell.configure(context: self, tableView: tableView, indexPath: indexPath, object: storeList[safe: indexPath.row]) as! AllStoreTableViewCell
        cell.delegate = self
        return cell
    }

}

extension AllStoreViewController: DetailStoreDelegate {
    func openDetail(store: StoreListModelData) {
        guard let navigationHeight = navigationController?.navigationBar.frame.height else { return }
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let rect = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height + statusBarHeight + navigationHeight)
        let detailView = DetailStoreView.init(frame: rect)
        detailView.data = store
        detailView.setupViewData()
        detail = detailView
        detailView.delegate = self
        detailView.show(animated: true)
    }
    
    func callingNumber(phoneNumber: String) {
        guard let number = URL(string: "tel://" + phoneNumber) else { return }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(number)
        } else {
            // Fallback on earlier versions
        }
    }
}

extension AllStoreViewController: DetailStoreViewDelegate{
    func closeButtonDidPush(_ view: DetailStoreView) {
        view.dismiss(animated: true)
    }
    
    func goShoppingButtonDidPush(_ view: DetailStoreView) {
        view.dismiss(animated: true)
        let vc = StoreViewController()
        vc.storeId = view.data?.storeId ?? 0
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func callingButtonDidPush(phoneNumber: String) {
        guard let number = URL(string: "tel://" + phoneNumber) else { return }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(number)
        } else {
            // Fallback on earlier versions
        }
    }
    
}
