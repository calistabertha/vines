//
//  LoginModelUserData.swift
//
//  Created by Patrick Marshall on 31/10/18
//  Copyright (c) Bukalapak. All rights reserved.
//

import Foundation
import SwiftyJSON

public final class LoginModelUserData: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let latitude = "latitude"
    static let email = "email"
    static let longitude = "longitude"
    static let point = "point"
    static let password = "password"
  }

  // MARK: Properties
  public var latitude: Float?
  public var email: String?
  public var longitude: Float?
  public var point: Int?
  public var password: String?

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
    longitude = json[SerializationKeys.longitude].float
    point = json[SerializationKeys.point].int
    password = json[SerializationKeys.password].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = latitude { dictionary[SerializationKeys.latitude] = value }
    if let value = email { dictionary[SerializationKeys.email] = value }
    if let value = longitude { dictionary[SerializationKeys.longitude] = value }
    if let value = point { dictionary[SerializationKeys.point] = value }
    if let value = password { dictionary[SerializationKeys.password] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.latitude = aDecoder.decodeObject(forKey: SerializationKeys.latitude) as? Float
    self.email = aDecoder.decodeObject(forKey: SerializationKeys.email) as? String
    self.longitude = aDecoder.decodeObject(forKey: SerializationKeys.longitude) as? Float
    self.point = aDecoder.decodeObject(forKey: SerializationKeys.point) as? Int
    self.password = aDecoder.decodeObject(forKey: SerializationKeys.password) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(latitude, forKey: SerializationKeys.latitude)
    aCoder.encode(email, forKey: SerializationKeys.email)
    aCoder.encode(longitude, forKey: SerializationKeys.longitude)
    aCoder.encode(point, forKey: SerializationKeys.point)
    aCoder.encode(password, forKey: SerializationKeys.password)
  }

}
