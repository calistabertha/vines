//
//  ProfileViewController.swift
//  Vines
//
//  Created by Calista Bertha on 15/01/19.
//  Copyright © 2019 Calista Bertha. All rights reserved.
//

import UIKit
import AlamofireImage

class ProfileViewController: VinesViewController {
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmailAddress: UILabel!
    @IBOutlet weak var lblPhoneNumber: UILabel!
    @IBOutlet weak var lblPoints: UILabel!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var viewPoints: UIView!
    @IBOutlet weak var viewOrder: UIView!
    
    var userData: LoginModelUserData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateNavBarWithBackButton(titleString: "PROFILE", viewController: self, isRightBarButton: false)
        viewOrder.layer.cornerRadius = viewOrder.frame.height / 2
        viewPoints.layer.cornerRadius = viewPoints.frame.height / 2
        btnEdit.layer.cornerRadius = btnEdit.frame.height / 2
        imgProfile.layer.cornerRadius = imgProfile.frame.height / 2
        imgProfile.clipsToBounds = true
        imgProfile.contentMode = .scaleAspectFill
        setupProfile()
    }
    
    func setupProfile() {
        guard let data = userDefault().getUserData()?.userData?[safe: 0] else { return }
        userData = data
        
        imgProfile.af_setImage(withURL: URL(string: userData?.foto ?? "")!, placeholderImage: UIImage(named: "placeholder")) { [weak self] image in
            guard let ws = self else { return }
            if let img = image.value {
                ws.imgProfile.image = img
            } else {
                ws.imgProfile.image = UIImage(named: "placeholder")
            }
        }
        lblName.text = userData?.fullname ?? ""
        lblEmailAddress.text = userData?.email ?? ""
        lblPoints.text = "\(userData?.point ?? 0) points"
//        lblPhoneNumber.text = userData.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    override func backButtonDidPush() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func editButtonDidPush(_ sender: Any) {
        let vc = EditProfileViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func poinButtonDidPush(_ sender: Any) {
    }
    
    @IBAction func orderButtonDidPush(_ sender: Any) {
    }
    
    @IBAction func changePasswordButtonDidPush(_ sender: Any) {
        let vc = ChangePasswordViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func supportButtonDidPush(_ sender: Any) {
    }
    
    @IBAction func rateApplicationButtonDidPush(_ sender: Any) {
    }
    
}
