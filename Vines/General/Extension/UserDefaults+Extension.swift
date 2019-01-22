//
//  UserDefaults+Extension.swift
//  Vines
//
//  Created by Calista Bertha on 07/10/18.
//  Copyright © 2018 Calista Bertha. All rights reserved.
//

import SwiftyJSON
import UIKit

public func userDefault() -> UserDefaults {
    return UserDefaults.shared
}

class Products: NSObject {
    let product: [ProductListModelData]
    
    init(product: [ProductListModelData]) {
        self.product = product
    }
}

extension UserDefaults {
    @objc public static let shared: UserDefaults = UserDefaults.standard
    
    func commit() {
        userDefault().synchronize()
    }
    
    func saveObject(key:String ,value:AnyObject){
        let data = NSKeyedArchiver.archivedData(withRootObject: value)
        userDefault().set(data, forKey: key)
        commit()
    }
    
    func firstLaunch() {
        userDefault().set(true, forKey: "FIRST_LAUNCH")
        commit()
    }
    
    func saveUser(user: LoginModelData) {
        saveObject(key: "USER_DATA", value: user)
        commit()
    }
    
    func setToken(token: String) {
        userDefault().set(token, forKey: "USER_TOKEN")
        commit()
    }
    
    func setUserID(userID: Int) {
        userDefault().set(userID, forKey: "USER_ID")
        commit()
    }
    
    func setApiKey(apiKey: String) {
        userDefault().set(apiKey, forKey: "API_KEY")
        commit()
    }
    
    func changeEnvironment() {
        userDefault().set(!isDebug(), forKey: "DEBUG")
        commit()
    }
    
    func setToProd() {
        userDefault().set(false, forKey: "DEBUG")
        commit()
    }
    
    func walthroughShowed(_ bool: Bool) {
        userDefault().set(bool, forKey: "WALTHROUGH")
    }

    func addToCart(product: ProductListModelData) {
        var list = getCart()
        list.append(product)
        let json = JSON(list)
        print(json)
//        saveObject(key: "CART_LIST", value: products)
    }
    
    func removeCart(productId: Int) {
        var list = getCart()
        let index: Int? = list.index { $0.productId == productId }
        if index != nil {
            list.remove(at: index!)
        }
    }
    
    func logout() {
        userDefault().removeObject(forKey: "USER_DATA")
        userDefault().removeObject(forKey: "USER_ID")
        userDefault().removeObject(forKey: "USER_TOKEN")
    }
    
    func isLoggedIn() -> Bool {
        return getUserData() != nil
    }
    
    func isAlreadyFirstLaunch() -> Bool {
        return userDefault().bool(forKey: "FIRST_LAUNCH")
    }
    
    func showWalthrough() -> Bool {
        return userDefault().bool(forKey: "WALTHROUGH")
    }
    
    func isDebug() -> Bool {
        return userDefault().bool(forKey: "DEBUG")
    }
    
    func getApiKey() -> String {
        if let apiKey = userDefault().value(forKey: "API_KEY") as? String {
            return apiKey
        }
        return ""
    }
    
    func getObject(key:String)->AnyObject?{
        if let data = userDefault().object(forKey: key) as? NSData {
            let obj = NSKeyedUnarchiver.unarchiveObject(with: data as Data)!
            return obj as AnyObject?
        }
        return nil
    }
    
    func getToken() -> String {
        if let token = userDefault().value(forKey: "USER_TOKEN") as? String {
            return token
        }
        return ""
    }
    
    func getUserID() -> Int {
        return userDefault().integer(forKey: "USER_ID")
    }
    
    func getCart() -> [ProductListModelData] {
    guard let cartList = userDefault().array(forKey: "CART_LIST") as? [ProductListModelData] else { return [] }
        return cartList
    }
    
    func getUserData() -> LoginModelData? {
        if let result = getObject(key: "USER_DATA") as? LoginModelData {
            return result
        }
        return nil
    }
}
