//
//  SizeModelData.swift
//  Vines
//
//  Created by Calista Bertha on 09/02/19.
//  Copyright © 2019 Calista Bertha. All rights reserved.
//

import Foundation
import SwiftyJSON

public final class SizeModelData: NSObject, NSCoding {
    private struct SerializationKeys {
        static let name = "name"
        static let code = "code"
        static let price = "price"
        static let stock = "stock"
    }
    
    // MARK: Properties
    public var name: String?
    public var code: String?
    public var price: Int?
    public var stock: Int?
    
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
        name = json[SerializationKeys.name].string
        code = json[SerializationKeys.code].string
        price = json[SerializationKeys.price].int
        stock = json[SerializationKeys.stock].int
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = name { dictionary[SerializationKeys.name] = value }
        if let value = code { dictionary[SerializationKeys.code] = value }
        if let value = price { dictionary[SerializationKeys.price] = value }
        if let value = stock { dictionary[SerializationKeys.stock] = value }
        return dictionary
    }
    
    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
        self.code = aDecoder.decodeObject(forKey: SerializationKeys.code) as? String
        self.price = aDecoder.decodeObject(forKey: SerializationKeys.price) as? Int
        self.stock = aDecoder.decodeObject(forKey: SerializationKeys.stock) as? Int
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: SerializationKeys.name)
        aCoder.encode(code, forKey: SerializationKeys.code)
        aCoder.encode(price, forKey: SerializationKeys.price)
        aCoder.encode(stock, forKey: SerializationKeys.stock)
    }
}
