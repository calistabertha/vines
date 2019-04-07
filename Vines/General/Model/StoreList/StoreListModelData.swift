//
//  StoreListModelData.swift
//
//  Created by Patrick Marshall on 22/11/18
//  Copyright (c) Patrick Marshall. All rights reserved.
//

import Foundation
import SwiftyJSON

public final class StoreListModelData: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let latitude = "latitude"
    static let name = "name"
    static let image = "image"
    static let storeId = "store_id"
    static let storeIDCode = "StoreId"
    static let address = "address"
    static let phone = "phone"
    static let open = "open"
    static let distance = "distance"
    static let close = "close"
    static let longitude = "longitude"
  }

    // MARK: Properties
    public var latitude: Float?
    public var name: String?
    public var image: String?
    public var storeId: Int?
    public var storeIDCode: String?
    public var address: String?
    public var phone: String?
    public var open: String?
    public var distance: Float?
    public var close: String?
    public var longitude: Float?

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
    name = json[SerializationKeys.name].string
    image = json[SerializationKeys.image].string
    storeId = json[SerializationKeys.storeId].int
    storeIDCode = json[SerializationKeys.storeIDCode].string
    address = json[SerializationKeys.address].string
    phone = json[SerializationKeys.phone].string
    open = json[SerializationKeys.open].string
    distance = json[SerializationKeys.distance].float
    close = json[SerializationKeys.close].string
    longitude = json[SerializationKeys.longitude].float
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = latitude { dictionary[SerializationKeys.latitude] = value }
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = image { dictionary[SerializationKeys.image] = value }
    if let value = storeId { dictionary[SerializationKeys.storeId] = value }
    if let value = storeIDCode { dictionary[SerializationKeys.storeIDCode] = value }
    if let value = address { dictionary[SerializationKeys.address] = value }
    if let value = phone { dictionary[SerializationKeys.phone] = value }
    if let value = open { dictionary[SerializationKeys.open] = value }
    if let value = distance { dictionary[SerializationKeys.distance] = value }
    if let value = close { dictionary[SerializationKeys.close] = value }
    if let value = longitude { dictionary[SerializationKeys.longitude] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.latitude = aDecoder.decodeObject(forKey: SerializationKeys.latitude) as? Float
    self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
    self.image = aDecoder.decodeObject(forKey: SerializationKeys.image) as? String
    self.storeId = aDecoder.decodeObject(forKey: SerializationKeys.storeId) as? Int
    self.storeIDCode = aDecoder.decodeObject(forKey: SerializationKeys.storeIDCode) as? String
    self.address = aDecoder.decodeObject(forKey: SerializationKeys.address) as? String
    self.phone = aDecoder.decodeObject(forKey: SerializationKeys.phone) as? String
    self.open = aDecoder.decodeObject(forKey: SerializationKeys.open) as? String
    self.distance = aDecoder.decodeObject(forKey: SerializationKeys.distance) as? Float
    self.close = aDecoder.decodeObject(forKey: SerializationKeys.close) as? String
    self.longitude = aDecoder.decodeObject(forKey: SerializationKeys.longitude) as? Float
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(latitude, forKey: SerializationKeys.latitude)
    aCoder.encode(name, forKey: SerializationKeys.name)
    aCoder.encode(image, forKey: SerializationKeys.image)
    aCoder.encode(storeId, forKey: SerializationKeys.storeId)
    aCoder.encode(storeIDCode, forKey: SerializationKeys.storeIDCode)
    aCoder.encode(address, forKey: SerializationKeys.address)
    aCoder.encode(phone, forKey: SerializationKeys.phone)
    aCoder.encode(open, forKey: SerializationKeys.open)
    aCoder.encode(distance, forKey: SerializationKeys.distance)
    aCoder.encode(close, forKey: SerializationKeys.close)
    aCoder.encode(longitude, forKey: SerializationKeys.longitude)
  }

}
