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
        generateNavBarWithBackButton(titleString: "ALL STORE", viewController: self)
        viewDropDown.layer.cornerRadius = viewDropDown.frame.width / 2
        tableView.rowHeight = UITableViewAutomaticDimension
    }
}

extension AllStoreViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}

extension AllStoreViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return AllStoreTableViewCell.configure(context: self, tableView: tableView, indexPath: indexPath, object: "")
    }
}
