//
//  ProductListModelData.swift
//
//  Created by Patrick Marshall on 05/01/19
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class ProductListModelData: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let summary = "summary"
    static let productId = "product_id"
    static let wishlistId = "wishlist_id"
    static let storeId = "store_id"
    static let storeName = "store_name"
    static let isFavourite = "is_favorite"
    static let name = "name"
    static let datecreate = "datecreate"
    static let discount = "discount"
    static let abv = "abv"
    static let image = "image"
    static let categoryId = "category_id"
    static let categoryName = "category_name"
    static let stock = "stock"
    static let price = "price"
    static let subRegion = "sub_region"
    static let code = "code"
  }

  // MARK: Properties
  public var summary: String?
  public var productId: Int?
  public var wishlistId: Int?
  public var storeId: Int?
  public var storeName: String?
  public var isFavourite: Bool?
  public var name: String?
  public var datecreate: String?
  public var discount: Int?
  public var abv: String?
  public var image: String?
  public var categoryId: Int?
  public var categoryName: String?
  public var stock: Int?
  public var price: Int?
  public var subRegion: String?
  public var code: String?


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
    productId = json[SerializationKeys.productId].int
    wishlistId = json[SerializationKeys.wishlistId].int
    storeId = json[SerializationKeys.storeId].int
    storeName = json[SerializationKeys.storeName].string
    isFavourite = json[SerializationKeys.isFavourite].bool
    name = json[SerializationKeys.name].string
    datecreate = json[SerializationKeys.datecreate].string
    discount = json[SerializationKeys.discount].int
    abv = json[SerializationKeys.abv].string
    image = json[SerializationKeys.image].string
    categoryId = json[SerializationKeys.categoryId].int
    categoryName = json[SerializationKeys.categoryName].string
    stock = json[SerializationKeys.stock].int
    price = json[SerializationKeys.price].int
    subRegion = json[SerializationKeys.subRegion].string
    code = json[SerializationKeys.code].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = summary { dictionary[SerializationKeys.summary] = value }
    if let value = productId { dictionary[SerializationKeys.productId] = value }
    if let value = wishlistId { dictionary[SerializationKeys.wishlistId] = value }
    if let value = storeId { dictionary[SerializationKeys.storeId] = value }
    if let value = storeName { dictionary[SerializationKeys.storeName] = value }
    if let value = isFavourite { dictionary[SerializationKeys.isFavourite] = value }
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = datecreate { dictionary[SerializationKeys.datecreate] = value }
    if let value = discount { dictionary[SerializationKeys.discount] = value }
    if let value = abv { dictionary[SerializationKeys.abv] = value }
    if let value = image { dictionary[SerializationKeys.image] = value }
    if let value = categoryId { dictionary[SerializationKeys.categoryId] = value }
    if let value = categoryName { dictionary[SerializationKeys.categoryName] = value }
    if let value = stock { dictionary[SerializationKeys.stock] = value }
    if let value = price { dictionary[SerializationKeys.price] = value }
    if let value = subRegion { dictionary[SerializationKeys.subRegion] = value }
    if let value = code { dictionary[SerializationKeys.code] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.summary = aDecoder.decodeObject(forKey: SerializationKeys.summary) as? String
    self.productId = aDecoder.decodeObject(forKey: SerializationKeys.productId) as? Int
    self.wishlistId = aDecoder.decodeObject(forKey: SerializationKeys.wishlistId) as? Int
    self.storeId = aDecoder.decodeObject(forKey: SerializationKeys.storeId) as? Int
    self.storeName = aDecoder.decodeObject(forKey: SerializationKeys.storeName) as? String
    self.isFavourite = aDecoder.decodeObject(forKey: SerializationKeys.isFavourite) as? Bool
    self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
    self.datecreate = aDecoder.decodeObject(forKey: SerializationKeys.datecreate) as? String
    self.discount = aDecoder.decodeObject(forKey: SerializationKeys.discount) as? Int
    self.abv = aDecoder.decodeObject(forKey: SerializationKeys.abv) as? String
    self.image = aDecoder.decodeObject(forKey: SerializationKeys.image) as? String
    self.categoryId = aDecoder.decodeObject(forKey: SerializationKeys.categoryId) as? Int
    self.categoryName = aDecoder.decodeObject(forKey: SerializationKeys.categoryName) as? String
    self.stock = aDecoder.decodeObject(forKey: SerializationKeys.stock) as? Int
    self.price = aDecoder.decodeObject(forKey: SerializationKeys.price) as? Int
    self.subRegion = aDecoder.decodeObject(forKey: SerializationKeys.subRegion) as? String
    self.code = aDecoder.decodeObject(forKey: SerializationKeys.code) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(summary, forKey: SerializationKeys.summary)
    aCoder.encode(storeId, forKey: SerializationKeys.storeId)
    aCoder.encode(wishlistId, forKey: SerializationKeys.wishlistId)
    aCoder.encode(storeName, forKey: SerializationKeys.storeName)
    aCoder.encode(isFavourite, forKey: SerializationKeys.isFavourite)
    aCoder.encode(productId, forKey: SerializationKeys.productId)
    aCoder.encode(name, forKey: SerializationKeys.name)
    aCoder.encode(datecreate, forKey: SerializationKeys.datecreate)
    aCoder.encode(discount, forKey: SerializationKeys.discount)
    aCoder.encode(abv, forKey: SerializationKeys.abv)
    aCoder.encode(image, forKey: SerializationKeys.image)
    aCoder.encode(categoryId, forKey: SerializationKeys.categoryId)
    aCoder.encode(categoryName, forKey: SerializationKeys.categoryName)
    aCoder.encode(stock, forKey: SerializationKeys.stock)
    aCoder.encode(price, forKey: SerializationKeys.price)
    aCoder.encode(subRegion, forKey: SerializationKeys.subRegion)
    aCoder.encode(code, forKey: SerializationKeys.code)
  }

}
