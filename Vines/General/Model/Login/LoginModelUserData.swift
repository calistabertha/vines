//
//  LoginModelUserData.swift
//
//  Created by Patrick Marshall on 15/01/19
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class LoginModelUserData: NSObject, NSCoding {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let latitude = "latitude"
        static let email = "email"
        static let dateJoin = "date_join"
        static let password = "password"
        static let fullname = "fullname"
        static let idProfile = "id_profile"
        static let userId = "user_id"
        static let longitude = "longitude"
        static let point = "point"
        static let foto = "foto"
        static let phone = "phone"
        static let dob = "dob"
    }
    
    // MARK: Properties
    public var latitude: Float?
    public var email: String?
    public var dateJoin: String?
    public var password: String?
    public var fullname: String?
    public var idProfile: String?
    public var userId: Int?
    public var longitude: Float?
    public var point: Int?
    public var foto: String?
    public var phone: String?
    public var dob : String?
    
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
        latitude = json[SerializationKeys.latitude].float
        email = json[SerializationKeys.email].string
        dateJoin = json[SerializationKeys.dateJoin].string
        password = json[SerializationKeys.password].string
        fullname = json[SerializationKeys.fullname].string
        idProfile = json[SerializationKeys.idProfile].string
        userId = json[SerializationKeys.userId].int
        longitude = json[SerializationKeys.longitude].float
        point = json[SerializationKeys.point].int
        foto = json[SerializationKeys.foto].string
        phone = json[SerializationKeys.phone].string
        dob = json[SerializationKeys.dob].string
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = latitude { dictionary[SerializationKeys.latitude] = value }
        if let value = email { dictionary[SerializationKeys.email] = value }
        if let value = dateJoin { dictionary[SerializationKeys.dateJoin] = value }
        if let value = password { dictionary[SerializationKeys.password] = value }
        if let value = fullname { dictionary[SerializationKeys.fullname] = value }
        if let value = idProfile { dictionary[SerializationKeys.idProfile] = value }
        if let value = userId { dictionary[SerializationKeys.userId] = value }
        if let value = longitude { dictionary[SerializationKeys.longitude] = value }
        if let value = point { dictionary[SerializationKeys.point] = value }
        if let value = foto { dictionary[SerializationKeys.foto] = value }
        if let value = phone { dictionary[SerializationKeys.phone] = value }
        if let value = dob { dictionary[SerializationKeys.dob] = value }
        return dictionary
    }
    
    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.latitude = aDecoder.decodeObject(forKey: SerializationKeys.latitude) as? Float
        self.email = aDecoder.decodeObject(forKey: SerializationKeys.email) as? String
        self.dateJoin = aDecoder.decodeObject(forKey: SerializationKeys.dateJoin) as? String
        self.password = aDecoder.decodeObject(forKey: SerializationKeys.password) as? String
        self.fullname = aDecoder.decodeObject(forKey: SerializationKeys.fullname) as? String
        self.idProfile = aDecoder.decodeObject(forKey: SerializationKeys.idProfile) as? String
        self.userId = aDecoder.decodeObject(forKey: SerializationKeys.userId) as? Int
        self.longitude = aDecoder.decodeObject(forKey: SerializationKeys.longitude) as? Float
        self.point = aDecoder.decodeObject(forKey: SerializationKeys.point) as? Int
        self.foto = aDecoder.decodeObject(forKey: SerializationKeys.foto) as? String
        self.phone = aDecoder.decodeObject(forKey: SerializationKeys.phone) as? String
        self.dob = aDecoder.decodeObject(forKey: SerializationKeys.dob) as? String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(latitude, forKey: SerializationKeys.latitude)
        aCoder.encode(email, forKey: SerializationKeys.email)
        aCoder.encode(dateJoin, forKey: SerializationKeys.dateJoin)
        aCoder.encode(password, forKey: SerializationKeys.password)
        aCoder.encode(fullname, forKey: SerializationKeys.fullname)
        aCoder.encode(idProfile, forKey: SerializationKeys.idProfile)
        aCoder.encode(userId, forKey: SerializationKeys.userId)
        aCoder.encode(longitude, forKey: SerializationKeys.longitude)
        aCoder.encode(point, forKey: SerializationKeys.point)
        aCoder.encode(foto, forKey: SerializationKeys.foto)
        aCoder.encode(phone, forKey: SerializationKeys.phone)
        aCoder.encode(dob, forKey: SerializationKeys.dob)
    }
    
}
