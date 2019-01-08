//
//  GeneralInfo.swift
//  Vines
//
//  Created by Calista Bertha on 07/01/19.
//  Copyright © 2019 Calista Bertha. All rights reserved.
//

import UIKit

@objc protocol GeneralInfoTextFieldDelegate {
    func textFieldDidBeginEditing(view: GeneralInfoTextField)
    func textFieldShouldBeginEditing(view: GeneralInfoTextField)
    func textFieldDidEndEditing(view: GeneralInfoTextField)
    func textFieldShouldChangeCharacters(view: GeneralInfoTextField)
}

class GeneralInfoTextField: UIView, Modal {

    var backgroundView = UIView()
    var dialogView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBOutlet weak var viewCard: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBInspectable var nibName:String?
    var delegate: GeneralInfoTextFieldDelegate?
  
    private func setupView() {
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask =
            [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        viewCard = view
        
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
    }
    
    private func setupView(with frame: CGRect) {
        nibName = "HelpsterTextField"
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask =
            [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        viewCard = view
        
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
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
