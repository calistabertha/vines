//
//  Constant.swift
//  Vines
//
//  Created by Calista Bertha on 07/10/18.
//  Copyright © 2018 Calista Bertha. All rights reserved.
//

import Foundation

struct Constants {
    
    struct ServicesAPI {
        static var apiBaseURL: String {
            if userDefault().isDebug() {
                return "http://209.97.165.47:8081/"
            } else {
                return "http://45.64.97.98:8081/"
            }
        }
        
        struct Authentication {
            static let login = "user/authentication"
            static let register = "user/register"
            static let updatePassword = "user/update_password"
        }
        
        struct Store {
            static let list = "store/list"
            static let detail = "store/detail"
        }
        
        struct Promotion {
            static let promotion = "promotions"
        }
        
        struct Product {
            static let list = "product/list"
            static let favourite = "product/favourite"
            static let similiar = "product/similiar"
        }
    
    }
}
