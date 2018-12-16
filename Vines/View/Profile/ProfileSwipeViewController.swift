//
//  ProfileSwipeViewController.swift
//  Vines
//
//  Created by Calista Bertha on 09/12/18.
//  Copyright © 2018 Calista Bertha. All rights reserved.
//

import UIKit

class ProfileSwipeViewController: UIViewController {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblFullname: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            let xib = MenuProfileTableViewCell.nib
            tableView.register(xib, forCellReuseIdentifier: MenuProfileTableViewCell.identifier)
        }
    }
    @IBOutlet weak var lblCopyright: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupView() {
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func openProfileButtonDidPush(_ sender: Any) {
        print("open edit profile")
    }

}
