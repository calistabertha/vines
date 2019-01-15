//
//  ProfileSwipeViewController.swift
//  Vines
//
//  Created by Calista Bertha on 09/12/18.
//  Copyright © 2018 Calista Bertha. All rights reserved.
//

import UIKit
protocol ProfileSwipeDelegate : class {
    func dismissView(controller: ProfileSwipeViewController)
}

class ProfileSwipeViewController: UIViewController {
 
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblFullname: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblCopyright: UILabel!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var viewProfile: UIView!
    
    var delegate: ProfileSwipeDelegate?
    var promotionList: [PromotionModelData] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(MenuProfileTableViewCell.nib, forCellReuseIdentifier: MenuProfileTableViewCell.identifier)
        print("profile \(view.frame.origin.y)")
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let dateStr = formatter.string(from: NSDate() as Date)
        lblCopyright.text = "Copyright © \(dateStr) Vines. All rights reserved"
        imgProfile.layer.cornerRadius = imgProfile.layer.frame.height / 2
        viewProfile.layer.cornerRadius = viewProfile.frame.height / 2
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func openProfileButtonDidPush(_ sender: Any) {
        let vc = ProfileViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func dismissViewButtonDidPush(_ sender: Any) {
        delegate?.dismissView(controller: self)
    }
    
}
extension ProfileSwipeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
}

extension ProfileSwipeViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return MenuProfileTableViewCell.configure(context: self, tableView: tableView, indexPath: indexPath, object: promotionList)
    }

}
