//
//  PromotionModelData.swift
//
//  Created by Patrick Marshall on 28/12/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class PromotionModelData: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let summary = "summary"
    static let status = "status"
    static let promotionCode = "promotion_code"
    static let image = "image"
    static let datecreate = "datecreate"
    static let title = "title"
    static let promotionId = "promotion_id"
  }

  // MARK: Properties
  public var summary: String?
  public var status: Int?
  public var promotionCode: String?
  public var image: String?
  public var datecreate: String?
  public var title: String?
  public var promotionId: Int?

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
    summary = json[SerializationKeys.summary].string
    status = json[SerializationKeys.status].int
    promotionCode = json[SerializationKeys.promotionCode].string
    image = json[SerializationKeys.image].string
    datecreate = json[SerializationKeys.datecreate].string
    title = json[SerializationKeys.title].string
    promotionId = json[SerializationKeys.promotionId].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = summary { dictionary[SerializationKeys.summary] = value }
    if let value = status { dictionary[SerializationKeys.status] = value }
    if let value = promotionCode { dictionary[SerializationKeys.promotionCode] = value }
    if let value = image { dictionary[SerializationKeys.image] = value }
    if let value = datecreate { dictionary[SerializationKeys.datecreate] = value }
    if let value = title { dictionary[SerializationKeys.title] = value }
    if let value = promotionId { dictionary[SerializationKeys.promotionId] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.summary = aDecoder.decodeObject(forKey: SerializationKeys.summary) as? String
    self.status = aDecoder.decodeObject(forKey: SerializationKeys.status) as? Int
    self.promotionCode = aDecoder.decodeObject(forKey: SerializationKeys.promotionCode) as? String
    self.image = aDecoder.decodeObject(forKey: SerializationKeys.image) as? String
    self.datecreate = aDecoder.decodeObject(forKey: SerializationKeys.datecreate) as? String
    self.title = aDecoder.decodeObject(forKey: SerializationKeys.title) as? String
    self.promotionId = aDecoder.decodeObject(forKey: SerializationKeys.promotionId) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(summary, forKey: SerializationKeys.summary)
    aCoder.encode(status, forKey: SerializationKeys.status)
    aCoder.encode(promotionCode, forKey: SerializationKeys.promotionCode)
    aCoder.encode(image, forKey: SerializationKeys.image)
    aCoder.encode(datecreate, forKey: SerializationKeys.datecreate)
    aCoder.encode(title, forKey: SerializationKeys.title)
    aCoder.encode(promotionId, forKey: SerializationKeys.promotionId)
  }

}
