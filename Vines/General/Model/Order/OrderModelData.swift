//
//  OrderModelData.swift
//  Vines
//
//  Created by Calista Bertha on 29/01/19.
//  Copyright © 2019 Calista Bertha. All rights reserved.
//

import Foundation
import SwiftyJSON

public final class OrderModelData: NSCoding {
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let orderId = "order_id"
        static let userId = "user_id"
        static let deliveryAddresss = "delivery_address"
        static let address = "address"
        static let latitude = "latitude"
        static let longitude = "longitude"
        static let storeId = "store_id"
        static let orderCode = "order_code"
        static let paymentMethod = "payment_method"
        static let totalOrder = "total_order"
        static let point = "point"
        static let usePoint = "use_point"
        static let paymentStatus = "payment_status"
        static let statusCode = "status_code"
        static let transactionId = "transaction_id"
        static let statusMessage = "status_message"
        static let promotionCode = "promotion_code"
        static let view = "view"
        static let datecreate = "datecreate"
        static let name = "name"
        static let storeAddress = "store_address"
    }
    
    // MARK: Properties
    public var orderId: Int?
    public var userId: Int?
    public var deliveryAddresss: String?
    public var address: String?
    public var latitude: Float?
    public var longitude: Float?
    public var storeId: Int?
    public var orderCode: String?
    public var paymentMethod: String?
    public var totalOrder: Int?
    public var point: Int?
    public var usePoint: Int?
    public var paymentStatus: String?
    public var statusCode: String?
    public var transactionId: String?
    public var statusMessage: String?
    public var promotionCode: String?
    public var view: String?
    public var datecreate: String?
    public var name: String?
    public var storeAddress: String?
    
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
        orderId = json[SerializationKeys.orderId].int
        userId = json[SerializationKeys.userId].int
        deliveryAddresss = json[SerializationKeys.deliveryAddresss].string
        address = json[SerializationKeys.address].string
        latitude = json[SerializationKeys.latitude].float
        longitude = json[SerializationKeys.longitude].float
        storeId = json[SerializationKeys.storeId].int
        orderCode = json[SerializationKeys.orderCode].string
        paymentMethod = json[SerializationKeys.paymentMethod].string
        totalOrder = json[SerializationKeys.totalOrder].int
        point = json[SerializationKeys.point].int
        usePoint = json[SerializationKeys.usePoint].int
        paymentStatus = json[SerializationKeys.paymentStatus].string
        statusCode = json[SerializationKeys.statusCode].string
        transactionId = json[SerializationKeys.transactionId].string
        statusMessage = json[SerializationKeys.statusMessage].string
        promotionCode = json[SerializationKeys.promotionCode].string
        view = json[SerializationKeys.view].string
        datecreate = json[SerializationKeys.datecreate].string
        name = json[SerializationKeys.name].string
        storeAddress = json[SerializationKeys.storeAddress].string
        
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = orderId { dictionary[SerializationKeys.orderId] = value }
        if let value = userId { dictionary[SerializationKeys.userId] = value }
        if let value = deliveryAddresss { dictionary[SerializationKeys.deliveryAddresss] = value }
        if let value = address { dictionary[SerializationKeys.address] = value }
        if let value = latitude { dictionary[SerializationKeys.latitude] = value }
        if let value = longitude { dictionary[SerializationKeys.longitude] = value }
        if let value = storeId { dictionary[SerializationKeys.storeId] = value }
        if let value = orderCode { dictionary[SerializationKeys.orderCode] = value }
        if let value = paymentMethod { dictionary[SerializationKeys.paymentMethod] = value }
        if let value = totalOrder { dictionary[SerializationKeys.totalOrder] = value }
        if let value = point { dictionary[SerializationKeys.point] = value }
        if let value = usePoint { dictionary[SerializationKeys.usePoint] = value }
        if let value = paymentStatus { dictionary[SerializationKeys.paymentStatus] = value }
        if let value = statusCode { dictionary[SerializationKeys.statusCode] = value }
        if let value = transactionId { dictionary[SerializationKeys.transactionId] = value }
        if let value = statusMessage { dictionary[SerializationKeys.statusMessage] = value }
        if let value = promotionCode { dictionary[SerializationKeys.promotionCode] = value }
        if let value = view { dictionary[SerializationKeys.view] = value }
        if let value = datecreate { dictionary[SerializationKeys.datecreate] = value }
        if let value = name { dictionary[SerializationKeys.name] = value }
        if let value = storeAddress { dictionary[SerializationKeys.storeAddress] = value }
        return dictionary
    }
    
    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.orderId = aDecoder.decodeObject(forKey:SerializationKeys.orderId) as? Int
        self.userId = aDecoder.decodeObject(forKey:SerializationKeys.userId) as? Int
        self.deliveryAddresss = aDecoder.decodeObject(forKey:SerializationKeys.deliveryAddresss) as? String
        self.address = aDecoder.decodeObject(forKey:SerializationKeys.address) as? String
        self.latitude = aDecoder.decodeObject(forKey:SerializationKeys.latitude) as? Float
        self.longitude = aDecoder.decodeObject(forKey:SerializationKeys.longitude) as? Float
        self.storeId = aDecoder.decodeObject(forKey:SerializationKeys.storeId) as? Int
        self.orderCode = aDecoder.decodeObject(forKey:SerializationKeys.orderCode) as? String
        self.paymentMethod = aDecoder.decodeObject(forKey:SerializationKeys.paymentMethod) as? String
        self.totalOrder = aDecoder.decodeObject(forKey:SerializationKeys.totalOrder) as? Int
        self.point = aDecoder.decodeObject(forKey:SerializationKeys.point) as? Int
        self.usePoint = aDecoder.decodeObject(forKey:SerializationKeys.usePoint) as? Int
        self.paymentStatus = aDecoder.decodeObject(forKey:SerializationKeys.paymentStatus) as? String
        self.statusCode = aDecoder.decodeObject(forKey:SerializationKeys.statusCode) as? String
        self.transactionId = aDecoder.decodeObject(forKey:SerializationKeys.transactionId) as? String
        self.statusMessage = aDecoder.decodeObject(forKey:SerializationKeys.statusMessage) as? String
        self.promotionCode = aDecoder.decodeObject(forKey:SerializationKeys.promotionCode) as? String
        self.view = aDecoder.decodeObject(forKey:SerializationKeys.view) as? String
        self.datecreate = aDecoder.decodeObject(forKey: SerializationKeys.datecreate) as? String
        self.name = aDecoder.decodeObject(forKey:SerializationKeys.name) as? String
        self.storeAddress = aDecoder.decodeObject(forKey:SerializationKeys.storeAddress) as? String
        
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(orderId, forKey: SerializationKeys.orderId)
        aCoder.encode(userId, forKey: SerializationKeys.userId)
        aCoder.encode(deliveryAddresss, forKey: SerializationKeys.deliveryAddresss)
        aCoder.encode(address, forKey: SerializationKeys.address)
        aCoder.encode(latitude, forKey: SerializationKeys.latitude)
        aCoder.encode(longitude, forKey: SerializationKeys.longitude)
        aCoder.encode(storeId, forKey: SerializationKeys.storeId)
        aCoder.encode(orderCode, forKey: SerializationKeys.orderCode)
        aCoder.encode(paymentMethod, forKey: SerializationKeys.paymentMethod)
        aCoder.encode(totalOrder, forKey: SerializationKeys.totalOrder)
        aCoder.encode(point, forKey: SerializationKeys.point)
        aCoder.encode(usePoint, forKey: SerializationKeys.usePoint)
        aCoder.encode(paymentStatus, forKey: SerializationKeys.paymentStatus)
        aCoder.encode(statusCode, forKey: SerializationKeys.statusCode)
        aCoder.encode(transactionId, forKey: SerializationKeys.transactionId)
        aCoder.encode(statusMessage, forKey: SerializationKeys.statusMessage)
        aCoder.encode(promotionCode, forKey: SerializationKeys.promotionCode)
        aCoder.encode(view, forKey: SerializationKeys.view)
        aCoder.encode(datecreate, forKey: SerializationKeys.datecreate)
        aCoder.encode(name, forKey: SerializationKeys.name)
        aCoder.encode(storeAddress, forKey: SerializationKeys.storeAddress)
    }
    
}
