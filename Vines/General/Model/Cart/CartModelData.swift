//
//  CartModelData.swift
//  Vines
//
//  Created by Calista Bertha on 03/02/19.
//  Copyright © 2019 Calista Bertha. All rights reserved.
//

import Foundation
/*
 "user_id": 21,
 "order_code": "ECOM_9tUtVyAeBo",
 "category_id": 12,
 "product_id": 51,
 "price": 100000,
 "code_product": "S001-0032",
 "size": "SL123",
 "jumlah_order": 2,
 "name": "Absolut Pears",
 "summary": "A pear variant for the Swedish vodka behemoth and style icon. Try it with a drop of fresh lemon juice, sugar syrup and ice.",
 "category_name": "Vodka",
 "image": "https://vines-indonesia.com/assets/images/product/cakk1aENPf.jpg"
 */
import SwiftyJSON

public final class CartModelData: NSCoding {
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let userID = "user_id"
        static let orderCode = "order_code"
        static let categoryID = "category_id"
        static let productID = "product_id"
        static let price = "price"
        static let codeProduct = "code_product"
        static let size = "size"
        static let jumlahOrder = "jumlah_order"
        static let name = "name"
        static let summary = "summary"
        static let categoryName = "category_name"
        static let image = "image"
    }
    
    // MARK: Properties
    public var userID: Int?
    public var orderCode: String?
    public var categoryID: Int?
    public var productID: Int?
    public var price: Int?
    public var codeProduct: String?
    public var size: String?
    public var jumlahOrder: Int?
    public var name: String?
    public var summary: String?
    public var categoryName: String?
    public var image: String?
    
    // MARK: SwiftyJSON Initializers
    /// Initiates the instance based on the object.
    ///
    /// - parameter object: The object of either Dictionary or Array kind that was passed.
    /// - returns: An initialized instance of the class.
    public convenience init(object: Any) {
        self.init(json: JSON(object))
    }
    
    /// Initiates the instance based on the JSON that was passed.
    ///
    /// - parameter json: JSON object from SwiftyJSON.
    public required init(json: JSON) {
        userID = json[SerializationKeys.userID].int
        orderCode = json[SerializationKeys.orderCode].string
        categoryID = json[SerializationKeys.categoryID].int
        productID = json[SerializationKeys.productID].int
        price = json[SerializationKeys.price].int
        codeProduct = json[SerializationKeys.codeProduct].string
        size = json[SerializationKeys.size].string
        jumlahOrder = json[SerializationKeys.jumlahOrder].int
        name = json[SerializationKeys.name].string
        summary = json[SerializationKeys.summary].string
        categoryName = json[SerializationKeys.categoryName].string
        image = json[SerializationKeys.image].string
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = userID { dictionary[SerializationKeys.userID] = value }
        if let value = orderCode { dictionary[SerializationKeys.orderCode] = value }
        if let value = categoryID { dictionary[SerializationKeys.categoryID] = value }
        if let value = productID { dictionary[SerializationKeys.productID] = value }
        if let value = price { dictionary[SerializationKeys.price] = value }
        if let value = codeProduct { dictionary[SerializationKeys.codeProduct] = value }
        if let value = size { dictionary[SerializationKeys.size] = value }
        if let value = jumlahOrder { dictionary[SerializationKeys.jumlahOrder] = value }
        if let value = name { dictionary[SerializationKeys.name] = value }
        if let value = summary { dictionary[SerializationKeys.summary] = value }
        if let value = categoryName { dictionary[SerializationKeys.categoryName] = value }
        if let value = image { dictionary[SerializationKeys.image] = value }
        
        return dictionary
    }
    
    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.userID = aDecoder.decodeObject(forKey:SerializationKeys.userID) as? Int
        self.orderCode = aDecoder.decodeObject(forKey:SerializationKeys.orderCode) as? String
        self.categoryID = aDecoder.decodeObject(forKey:SerializationKeys.categoryID) as? Int
        self.productID = aDecoder.decodeObject(forKey:SerializationKeys.productID) as? Int
        self.price = aDecoder.decodeObject(forKey:SerializationKeys.price) as? Int
        self.codeProduct = aDecoder.decodeObject(forKey:SerializationKeys.codeProduct) as? String
        self.size = aDecoder.decodeObject(forKey:SerializationKeys.size) as? String
        self.jumlahOrder = aDecoder.decodeObject(forKey:SerializationKeys.jumlahOrder) as? Int
        self.name = aDecoder.decodeObject(forKey:SerializationKeys.name) as? String
        self.summary = aDecoder.decodeObject(forKey:SerializationKeys.summary) as? String
        self.categoryName = aDecoder.decodeObject(forKey:SerializationKeys.categoryName) as? String
        self.image = aDecoder.decodeObject(forKey:SerializationKeys.image) as? String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(userID, forKey: SerializationKeys.userID)
        aCoder.encode(orderCode, forKey: SerializationKeys.orderCode)
        aCoder.encode(categoryID, forKey: SerializationKeys.categoryID)
        aCoder.encode(productID, forKey: SerializationKeys.productID)
        aCoder.encode(price, forKey: SerializationKeys.price)
        aCoder.encode(codeProduct, forKey: SerializationKeys.codeProduct)
        aCoder.encode(size, forKey: SerializationKeys.size)
        aCoder.encode(jumlahOrder, forKey: SerializationKeys.jumlahOrder)
        aCoder.encode(name, forKey: SerializationKeys.name)
        aCoder.encode(summary, forKey: SerializationKeys.summary)
        aCoder.encode(categoryName, forKey: SerializationKeys.categoryName)
        aCoder.encode(image, forKey: SerializationKeys.image)
    }
    
}
