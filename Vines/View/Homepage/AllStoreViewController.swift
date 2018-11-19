//
//  AllStoreViewController.swift
//  Vines
//
//  Created by Calista Bertha on 20/10/18.
//  Copyright © 2018 Calista Bertha. All rights reserved.
//

import UIKit

class AllStoreViewController: VinesViewController {
    @IBOutlet weak var viewDropDown: UIView!
    @IBOutlet weak var tableView: UITableView!{
        didSet{
                let xib = AllStoreTableViewCell.nib
                tableView.register(xib, forCellReuseIdentifier: AllStoreTableViewCell.identifier)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    private func setupView() {
        generateNavBarWithBackButton(titleString: "ALL STORE", viewController: self, isRightBarButton: false)
        viewDropDown.layer.cornerRadius = viewDropDown.frame.width / 2
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func backButtonDidPush() {
        navigationController?.popViewController(animated: true)
    }
}

extension AllStoreViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
}

extension AllStoreViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return AllStoreTableViewCell.configure(context: self, tableView: tableView, indexPath: indexPath, object: "")
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
