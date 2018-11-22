//
//  AllStoreViewController.swift
//  Vines
//
//  Created by Calista Bertha on 20/10/18.
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
        generateNavBarWithBackButton(titleString: "ALL STORE", viewController: self, isRightBarButton: false)
        viewDropDown.layer.cornerRadius = viewDropDown.frame.width / 2
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    private func fetchStore() {
        let params = [
            "longitude": self.location.coordinate.longitude,
            "latitude": self.location.coordinate.latitude
        ]
        HTTPHelper.shared.requestAPI(url: Constants.ServicesAPI.Store.list, param: params, method: HTTPMethodHelper.post) { (success, json) in
            let data = StoreListModelBaseClass(json: json!)
            if data.message == "success" {
                self.storeList = data.data!
                self.tableView.reloadData()
            } else {
                print(data.displayMessage!)
            }
        }
    }
    
    override func backButtonDidPush() {
        navigationController?.popViewController(animated: true)
    }
}

extension AllStoreViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.storeList.count
    }
}

extension AllStoreViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return AllStoreTableViewCell.configure(context: self, tableView: tableView, indexPath: indexPath, object: self.storeList[safe: indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailView = DetailStoreView.init(frame: view.frame)
        detailView.delegate = self
        view.addSubview(detailView)

//        let storyboard = UIStoryboard(name: Constants.StoryboardReferences.detail, bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: Constants.ViewControllerID.Detail.detail)
//        navigationController?.pushViewController(vc, animated: true)
    }
}

extension AllStoreViewController: DetailStoreViewDelegate{
    func closeButtonDidPush(_ view: DetailStoreView) {
        view.dismiss(animated: true)
    }
    
    func goShoppingButtonDidPush() {
        
    }
    
    
}
