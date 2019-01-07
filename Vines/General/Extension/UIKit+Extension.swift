//
//  UIKit+Extension.swift
//  Vines
//
//  Created by Calista Bertha on 27/12/18.
//  Copyright © 2018 Calista Bertha. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {

    func as1ptImage() -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        setFill()
        UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return image
    }
}

extension UIAlertController {
    public static func yesOrNoAlert(_ vc: UIViewController,
                                    title: String? = nil,
                                    message: String? = nil,
                                    okButtonTitle: String = "Ya",
                                    noButtonTitle: String? = "Tidak",
                                    no: VoidClosure? = nil,
                                    yes: VoidClosure? = nil) {
        
        let alertVC: UIAlertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        if let noTitle = noButtonTitle {
            alertVC.addAction(
                UIAlertAction(
                    title: noTitle,
                    style: .default,
                    handler: { _ in
                        no?()
                }
                )
            )
        }
        
        alertVC.addAction(
            UIAlertAction(
                title: okButtonTitle,
                style: .destructive,
                handler: { _ in
                    yes?()
            }
            )
        )
        
        let alertWindow: UIWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.rootViewController = UIViewController()
        alertWindow.windowLevel = UIWindowLevelAlert + 1
        alertWindow.makeKeyAndVisible()
        alertWindow.rootViewController?.present(
            alertVC,
            animated: true,
            completion: nil
        )
    }
}
