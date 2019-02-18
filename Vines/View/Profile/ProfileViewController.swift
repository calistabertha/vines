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
        generateNavBarWithBackButton(titleString: "PROFILE", viewController: self, isRightBarButton: false, isNavbarColor: true)
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
        vc.userData = userData
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func poinButtonDidPush(_ sender: Any) {
    }
    
    @IBAction func orderButtonDidPush(_ sender: Any) {
        let vc = AllOrderViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func changePasswordButtonDidPush(_ sender: Any) {
        let vc = ChangePasswordViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func rateApplicationButtonDidPush(_ sender: Any) {
    }
    
    @IBAction func logoutButtonDidPush(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: "Do you want to logout?", preferredStyle: UIAlertControllerStyle.alert)
        
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { action in
         userDefault().logout()
            if let bundle = Bundle.main.bundleIdentifier {
                UserDefaults.standard.removePersistentDomain(forName: bundle)
            }
            
            let vc = SignInViewController()
            self.present(vc, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.cancel, handler: nil))
        

        self.present(alert, animated: true, completion: nil )
        
        
        
    }
}
