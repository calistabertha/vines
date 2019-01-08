//
//  PersonalInfoTextField.swift
//  Vines
//
//  Created by Calista Bertha on 07/01/19.
//  Copyright © 2019 Calista Bertha. All rights reserved.
//

import UIKit

@objc protocol PersonalInfoTextFieldDelegate {
    func textFieldDidBeginEditing(view: PersonalInfoTextField)
    func textFieldShouldBeginEditing(view: PersonalInfoTextField)
    func textFieldDidEndEditing(view: PersonalInfoTextField)
    func textFieldShouldChangeCharacters(view: PersonalInfoTextField)
}

@IBDesignable
class PersonalInfoTextField: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView(with: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
        viewCard?.prepareForInterfaceBuilder()
    }
    
    @IBOutlet weak var viewCard: UIView!
    @IBOutlet weak var txtFirstname: UITextField!
    @IBOutlet weak var txtLastname: UITextField!
    @IBInspectable var nibName:String?
    var delegate: PersonalInfoTextFieldDelegate?
    
    private func setupView() {
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask =
            [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        viewCard = view
   
        txtFirstname.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
    }
    
    private func setupView(with frame: CGRect) {
        nibName = "HelpsterTextField"
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask =
            [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        viewCard = view
        
        txtFirstname.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
    }
    
    func loadViewFromNib() -> UIView! {
        guard let nibName = nibName else { return nil }
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(
            withOwner: self,
            options: nil).first as? UIView
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        delegate?.textFieldShouldChangeCharacters(view: self)
    }
}
