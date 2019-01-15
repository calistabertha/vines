//
//  SuccessEditing.swift
//  Vines
//
//  Created by Calista Bertha on 15/01/19.
//  Copyright © 2019 Calista Bertha. All rights reserved.
//

import UIKit
@objc protocol SuccessEditingViewDelegate {
    func continueButtonDidPush(sender: UIButton, view: SuccessEditing)
}


class SuccessEditing: UIView, Modal {
    var backgroundView = UIView()
    var dialogView = UIView()
    
    enum SuccessType {
        case profile
        case password
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    @IBInspectable var nibName:String?{
        return "SuccessEditing"
    }
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imgSuccess: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
    @IBOutlet weak var btnContinue: UIButton!
    var delegate: SuccessEditingViewDelegate?
    
    private func setupView() {
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask =
            [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        contentView = view
        dialogView = contentView
        
        btnContinue.layer.cornerRadius = 15
    }
    
    func loadViewFromNib() -> UIView! {
        guard let nibName = nibName else { return nil }
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(
            withOwner: self,
            options: nil).first as? UIView
    }
    
    func successType(type: SuccessType){
        switch type {
        case .profile:
            imgSuccess.image = UIImage.init(named: "img-alert-account")
            lblTitle.text = "PROFILE UPDATED"
            lblSubtitle.text = "Your profile has been updated"
            
        case .password:
            imgSuccess.image = UIImage.init(named: "img-alert-email")
            lblTitle.text = "CHECK YOUR EMAIL"
            lblSubtitle.text = "Please check your email to verify your new password"
            
        }
    }
    
    @IBAction func continueButtonDidPush(_ sender: UIButton) {
        delegate?.continueButtonDidPush(sender: sender, view: self)
    }
}
