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
        static let apiBaseURL =  "http://209.97.165.47:8081/"
        
        struct Authentication {
            static let login = "user/authentication"
            static let register = "user/register"
            static let updatePassword = "user/update_password"
        }
    
    }
    
    struct StoryboardReferences {
        static let authentication = "Authentication"
        static let home = "Home"
        
    }
    
    struct ViewControllerID {
        struct Authentication {
            static let signIn = "SignInViewController"
            static let signUp = "SignUpViewController"
            static let forgot = "ForgotPasswordViewController"
        }
        
        struct Homepage {
            static let home = "HomeViewController"
            static let allStore = "AllStoreViewController"
        }
        
    }
}
