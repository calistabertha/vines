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
    
    func setOrderCode(code: String) {
        userDefault().set(code, forKey: "ORDER_CODE")
        commit()
    }
    
    func setUserCheckout(code: String) {
        userDefault().set(code, forKey: "USER_CHECKOUT")
        commit()
    }
    
    func setUserAddress(address: String) {
        userDefault().set(address, forKey: "DELIVERY_ADDRESS")
        commit()
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
        userDefault().removeObject(forKey: "ORDER_CODE")
        userDefault().removeObject(forKey: "DELIVERY_ADDRESS")
    }
    
    func isLoggedIn() -> Bool {
        return getUserData() != nil
    }
    
    func isAlreadyFirstLaunch() -> Bool {
        return userDefault().bool(forKey: "FIRST_LAUNCH")
    }
    
    func walthroughShowed() -> Bool {
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
    
    func getEmailUser() -> String {
        if let email = getUserData()?.userData?[safe: 0]?.email {
            return email
        }
        return ""
    }
    
    func getOrderCode() -> String {
        if let code = userDefault().value(forKey: "ORDER_CODE") as? String {
            return code
        }
        return ""
    }
    
    func getUserCheckout() -> String {
        if let user = userDefault().value(forKey: "USER_CHECKOUT") as? String {
            return user
        }
        return ""
    }
    
    func getUserAddress() -> String {
        if let address = userDefault().value(forKey: "DELIVERY_ADDRESS") as? String {
            return address
        }
        return ""
    }
}
