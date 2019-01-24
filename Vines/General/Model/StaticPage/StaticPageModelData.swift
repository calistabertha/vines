//
//  StaticPageModelData.swift
//
//  Created by Patrick Marshall on 22/01/19
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class StaticPageModelData: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let descriptionValue = "description"
    static let page = "page"
    static let title = "title"
    static let summary = "summary"
    static let datecreate = "datecreate"
    static let staticPageId = "static_page_id"
  }

  // MARK: Properties
  public var descriptionValue: String?
  public var page: String?
  public var title: String?
  public var summary: String?
  public var datecreate: String?
  public var staticPageId: Int?

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
    descriptionValue = json[SerializationKeys.descriptionValue].string
    page = json[SerializationKeys.page].string
    title = json[SerializationKeys.title].string
    summary = json[SerializationKeys.summary].string
    datecreate = json[SerializationKeys.datecreate].string
    staticPageId = json[SerializationKeys.staticPageId].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = descriptionValue { dictionary[SerializationKeys.descriptionValue] = value }
    if let value = page { dictionary[SerializationKeys.page] = value }
    if let value = title { dictionary[SerializationKeys.title] = value }
    if let value = summary { dictionary[SerializationKeys.summary] = value }
    if let value = datecreate { dictionary[SerializationKeys.datecreate] = value }
    if let value = staticPageId { dictionary[SerializationKeys.staticPageId] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.descriptionValue = aDecoder.decodeObject(forKey: SerializationKeys.descriptionValue) as? String
    self.page = aDecoder.decodeObject(forKey: SerializationKeys.page) as? String
    self.title = aDecoder.decodeObject(forKey: SerializationKeys.title) as? String
    self.summary = aDecoder.decodeObject(forKey: SerializationKeys.summary) as? String
    self.datecreate = aDecoder.decodeObject(forKey: SerializationKeys.datecreate) as? String
    self.staticPageId = aDecoder.decodeObject(forKey: SerializationKeys.staticPageId) as? Int
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(descriptionValue, forKey: SerializationKeys.descriptionValue)
    aCoder.encode(page, forKey: SerializationKeys.page)
    aCoder.encode(title, forKey: SerializationKeys.title)
    aCoder.encode(summary, forKey: SerializationKeys.summary)
    aCoder.encode(datecreate, forKey: SerializationKeys.datecreate)
    aCoder.encode(staticPageId, forKey: SerializationKeys.staticPageId)
  }

}
