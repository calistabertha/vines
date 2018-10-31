//
//  ResponseModel.swift
//  Vines
//
//  Created by Calista Bertha on 07/10/18.
//  Copyright © 2018 Calista Bertha. All rights reserved.
//

import SwiftyJSON

class ResponseModel {
    var code: Int
    var type: String
    var message: String
    var status: String
    var data: JSON?
    
    init(code: Int, type: String, message: String, status: String, data: JSON?) {
        self.code = code
        self.type = type
        self.message = message
        self.status = status
        self.data = data
    }
    
    convenience init(without data: JSON) {
        let code = data["code"].intValue
        let type = data["type"].stringValue
        
        var messageJSON = data["message"]
        var message = ""
        if messageJSON.type == Type.dictionary {
            for (_, subJSON) : (String, JSON) in messageJSON {
                if let msg = subJSON.arrayValue.first?.stringValue {
                    message = msg
                    break
                }
            }
        } else {
            message = messageJSON.stringValue
        }
        
        let status = data["status"].stringValue
        
        self.init(code: code, type: type, message: message, status: status, data: nil)
    }
    
    convenience init(with data: JSON) {
        let code = data["code"].intValue
        let type = data["type"].stringValue
        
        var messageJSON = data["message"]
        var message = ""
        if messageJSON.type == Type.dictionary {
            for (_, subJSON) : (String, JSON) in messageJSON {
                if let msg = subJSON.arrayValue.first?.stringValue {
                    message = msg
                    break
                }
            }
        } else {
            message = messageJSON.stringValue
        }
        
        let status = data["status"].stringValue
        let datas = data["data"]
        
        self.init(code: code, type: type, message: message, status: status, data: datas)
    }
}
