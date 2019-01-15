//
//  NewsModelData.swift
//
//  Created by Patrick Marshall on 14/01/19
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class NewsModelData: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let summary = "summary"
    static let descriptionValue = "description"
    static let title = "title"
    static let newsId = "news_id"
    static let image = "image"
    static let datecreate = "datecreate"
  }

  // MARK: Properties
  public var summary: String?
  public var descriptionValue: String?
  public var title: String?
  public var newsId: Int?
  public var image: String?
  public var datecreate: String?

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
    descriptionValue = json[SerializationKeys.descriptionValue].string
    title = json[SerializationKeys.title].string
    newsId = json[SerializationKeys.newsId].int
    image = json[SerializationKeys.image].string
    datecreate = json[SerializationKeys.datecreate].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = summary { dictionary[SerializationKeys.summary] = value }
    if let value = descriptionValue { dictionary[SerializationKeys.descriptionValue] = value }
    if let value = title { dictionary[SerializationKeys.title] = value }
    if let value = newsId { dictionary[SerializationKeys.newsId] = value }
    if let value = image { dictionary[SerializationKeys.image] = value }
    if let value = datecreate { dictionary[SerializationKeys.datecreate] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.summary = aDecoder.decodeObject(forKey: SerializationKeys.summary) as? String
    self.descriptionValue = aDecoder.decodeObject(forKey: SerializationKeys.descriptionValue) as? String
    self.title = aDecoder.decodeObject(forKey: SerializationKeys.title) as? String
    self.newsId = aDecoder.decodeObject(forKey: SerializationKeys.newsId) as? Int
    self.image = aDecoder.decodeObject(forKey: SerializationKeys.image) as? String
    self.datecreate = aDecoder.decodeObject(forKey: SerializationKeys.datecreate) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(summary, forKey: SerializationKeys.summary)
    aCoder.encode(descriptionValue, forKey: SerializationKeys.descriptionValue)
    aCoder.encode(title, forKey: SerializationKeys.title)
    aCoder.encode(newsId, forKey: SerializationKeys.newsId)
    aCoder.encode(image, forKey: SerializationKeys.image)
    aCoder.encode(datecreate, forKey: SerializationKeys.datecreate)
  }

}
