//
//  ForgotPasswordViewController.swift
//  Vines
//
//  Created by Calista Bertha on 07/10/18.
//  Copyright © 2018 Calista Bertha. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var btnReset: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupView() {
        btnReset.layer.cornerRadius = 5
    }

    @IBAction func backButtonDidPush(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func resetButtonDidPush(_ sender: Any) {
        
    }
}
