//
//  ProductListModelBaseClass.swift
//
//  Created by Patrick Marshall on 05/01/19
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class ProductListModelBaseClass: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let status = "status"
    static let data = "data"
    static let message = "message"
    static let time = "time"
    static let displayMessage = "display_message"
  }

  // MARK: Properties
  public var status: String?
  public var data: [ProductListModelData]?
  public var message: String?
  public var time: String?
  public var displayMessage: String?

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
    status = json[SerializationKeys.status].string
    if let items = json[SerializationKeys.data].array { data = items.map { ProductListModelData(json: $0) } }
    message = json[SerializationKeys.message].string
    time = json[SerializationKeys.time].string
    displayMessage = json[SerializationKeys.displayMessage].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = status { dictionary[SerializationKeys.status] = value }
    if let value = data { dictionary[SerializationKeys.data] = value.map { $0.dictionaryRepresentation() } }
    if let value = message { dictionary[SerializationKeys.message] = value }
    if let value = time { dictionary[SerializationKeys.time] = value }
    if let value = displayMessage { dictionary[SerializationKeys.displayMessage] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.status = aDecoder.decodeObject(forKey: SerializationKeys.status) as? String
    self.data = aDecoder.decodeObject(forKey: SerializationKeys.data) as? [ProductListModelData]
    self.message = aDecoder.decodeObject(forKey: SerializationKeys.message) as? String
    self.time = aDecoder.decodeObject(forKey: SerializationKeys.time) as? String
    self.displayMessage = aDecoder.decodeObject(forKey: SerializationKeys.displayMessage) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(status, forKey: SerializationKeys.status)
    aCoder.encode(data, forKey: SerializationKeys.data)
    aCoder.encode(message, forKey: SerializationKeys.message)
    aCoder.encode(time, forKey: SerializationKeys.time)
    aCoder.encode(displayMessage, forKey: SerializationKeys.displayMessage)
  }

}
