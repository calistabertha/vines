//
//  UserDefaults+Extension.swift
//  Vines
//
//  Created by Calista Bertha on 07/10/18.
//  Copyright © 2018 Calista Bertha. All rights reserved.
//

import SwiftyJSON

public func userDefault() -> UserDefaults {
    return UserDefaults.shared
}

extension UserDefaults {
    @objc public static let shared: UserDefaults = UserDefaults.standard
    
    func setUserProfile(json: JSON) -> Void {
        if let data = json.rawString() {
            userDefault().setValue(data, forKey: "USER_PROFILE")
        }
    }
    
    func removeUserProfile() -> Void {
        userDefault().setValue(nil, forKey: "USER_PROFILE")
    }
    
    func getUserProfile() -> UserModel? {
        if let data = userDefault().value(forKey: "USER_PROFILE") as? String {
            let jsonResult = JSON.init(parseJSON: data)
            return UserModel(json: jsonResult)
        }
        return nil
    }
    
    func setToken(token: String) {
        userDefault().setValue(token, forKey: "USER_TOKEN")
    }
    
    func setApiKey(apiKey: String) {
        userDefault().setValue(apiKey, forKey: "API_KEY")
    }
    
    func getApiKey() -> String {
        if let token = userDefault().value(forKey: "API_KEY") as? String {
            return token
        }
        
        return ""
    }
    
    func isDebug() -> Bool {
        return userDefault().bool(forKey: "DEBUG")
    }
    
    func changeEnvironment() {
        userDefault().set(!isDebug(), forKey: "DEBUG")
    }
    
    func setToProd() {
        userDefault().set(false, forKey: "DEBUG")
    }
    
    func getToken() -> String {
        /*if let user = self.getUserProfile() {
         return user.userToken
         }*/
        if let token = userDefault().value(forKey: "USER_TOKEN") as? String {
            return token
        }
        
        return ""
    }
    
    func getRefreshToken() -> String {
        if let user = self.getUserProfile() {
            return user.refreshToken
        }
        
        return ""
    }
    
    func getID() -> String {
        if let user = self.getUserProfile() {
            return user.id
        }
        
        return ""
    }
}
