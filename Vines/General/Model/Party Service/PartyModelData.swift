//
//  PartyModelData.swift
//  Vines
//
//  Created by Calista Bertha on 18/02/19.
//  Copyright © 2019 Calista Bertha. All rights reserved.
//

import Foundation
import SwiftyJSON

public final class PartyModelData: NSCoding {
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let packageID = "package_id"
        static let packageName = "package_name"
        static let image = "image"
    }
    
    // MARK: Properties
    public var packageID: Int?
    public var packageName: String?
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
        packageID = json[SerializationKeys.packageID].int
        packageName = json[SerializationKeys.packageName].string
        image = json[SerializationKeys.image].string
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = packageID { dictionary[SerializationKeys.packageID] = value }
        if let value = packageName { dictionary[SerializationKeys.packageName] = value }
        if let value = image { dictionary[SerializationKeys.image] = value }
        
        return dictionary
    }
    
    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.packageID = aDecoder.decodeObject(forKey:SerializationKeys.packageID) as? Int
        self.packageName = aDecoder.decodeObject(forKey:SerializationKeys.packageName) as? String
        self.image = aDecoder.decodeObject(forKey:SerializationKeys.image) as? String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(packageID, forKey: SerializationKeys.packageID)
        aCoder.encode(packageName, forKey: SerializationKeys.packageName)
        aCoder.encode(image, forKey: SerializationKeys.image)
    }
}
