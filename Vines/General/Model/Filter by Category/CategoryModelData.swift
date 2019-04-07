//
//  CategoryModelData.swift
//  Vines
//
//  Created by Calista Bertha on 22/02/19.
//  Copyright © 2019 Calista Bertha. All rights reserved.
//

import Foundation
import SwiftyJSON

public final class CategoryModelData: NSCoding {
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let categoryID = "category_id"
        static let parentID = "parent_id"
        static let name = "name"
        static let dateCreate = "datecreate"
    }
    
    // MARK: Properties
    public var categoryID: Int?
    public var parentID: String?
    public var name: String?
    public var dateCreate: String?
    
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
        categoryID = json[SerializationKeys.categoryID].int
        parentID = json[SerializationKeys.parentID].string
        name = json[SerializationKeys.name].string
        dateCreate = json[SerializationKeys.dateCreate].string
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = categoryID { dictionary[SerializationKeys.categoryID] = value }
        if let value = parentID { dictionary[SerializationKeys.parentID] = value }
        if let value = name { dictionary[SerializationKeys.name] = value }
        if let value = dateCreate { dictionary[SerializationKeys.dateCreate] = value }
        
        return dictionary
    }
    
    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.categoryID = aDecoder.decodeObject(forKey:SerializationKeys.categoryID) as? Int
        self.parentID = aDecoder.decodeObject(forKey:SerializationKeys.parentID) as? String
        self.name = aDecoder.decodeObject(forKey:SerializationKeys.name) as? String
        self.dateCreate = aDecoder.decodeObject(forKey:SerializationKeys.dateCreate) as? String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(categoryID, forKey: SerializationKeys.categoryID)
        aCoder.encode(parentID, forKey: SerializationKeys.parentID)
        aCoder.encode(name, forKey: SerializationKeys.name)
        aCoder.encode(dateCreate, forKey: SerializationKeys.dateCreate)
    }
}
