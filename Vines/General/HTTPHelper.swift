//
//  HTTPHelper.swift
//  Vines
//
//  Created by Calista Bertha on 07/10/18.
//  Copyright © 2018 Calista Bertha. All rights reserved.
//

import Alamofire
import SwiftyJSON

public enum HTTPMethodHelper: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
    
    func toHTTPMethod() -> HTTPMethod {
        switch self { 
        case .get:
            return HTTPMethod.get
        case .post:
            return HTTPMethod.post
        case .put:
            return HTTPMethod.put
        case .delete:
            return HTTPMethod.delete
        default:
            return HTTPMethod.get
        }
    }
}

public enum HTTPCode: String {
    case success = "success"
    case failure = "failed"
    case unreachable = "unreachable"
    case unauthorized = "unauthorized"
}

class HTTPHelper {
    
    static let shared = HTTPHelper()
    
    private let manager: SessionManager
    var showAdsHome = true
    var showAdsProgram = true
    var vcFrom : String!
    
    init() {
        let config = URLSessionConfiguration.default
        
        //Set config if system need some request configuration
        //config.requestCachePolicy = .useProtocolCachePolicy
        // config.timeoutIntervalForRequest = 5
        //config.urlCache = nil
        
        manager = Alamofire.SessionManager(configuration: config)
    }
    
    func requestAPI(url: String, param: [String:Any], method: HTTPMethodHelper, completion: @escaping(_ success: Bool, _ data: JSON?) -> Void) {
        let token = userDefault().getApiKey()
        var urls: URL?
        var urlRequest: URLRequest?
        urls = try? (Constants.ServicesAPI.apiBaseURL + url).asURL()
        urlRequest = URLRequest(url: urls!)
        urlRequest?.httpMethod = method.rawValue
        urlRequest = try? JSONEncoding.default.encode(urlRequest!, with: param)
        
        urlRequest?.addValue(token, forHTTPHeaderField: "apikey")
        
        print("URL API => "+(urlRequest?.url?.absoluteString)!)
        print("Parameter => \(param)")
        
        let req:URLRequest?
        do {
            req = try urlRequest!.asURLRequest()
        } catch  {
            req = nil
        }
        
        manager.request(req!).responseJSON {
            (response) in
            
            self.requestHandler(response: response, url: url, param: param, method: method, completion: completion)
        }
    }
    
    /*
     * Use when upload file to server (JPG)
     */
    func requestFormData(url: String, param: [String : Any], method: HTTPMethodHelper, completion: @escaping(_ success: Bool, _ statusCode: Int, _ data: JSON?) -> Void){
        
       //let token = userDefault().getApiKey()
        
        let header = [
            "Content-Type": "application/x-www-form-urlencoded",
            "apikey": "bd9f1fcdc95abde54fdd46cf3fba93151d435a41"
        ]
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in param {
                if value is String {
                    multipartFormData.append((value as! String).data(using: .utf8)!, withName: key)
                } else {
                    multipartFormData.append((value as! Data), withName: key, fileName: "images.jpg", mimeType: "image/jpeg")
                }
            }
        }, usingThreshold: SessionManager.multipartFormDataEncodingMemoryThreshold,
           to: Constants.ServicesAPI.apiBaseURL + url,
           method: method.toHTTPMethod(),
           headers: header) { (encodingResult) in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    print(response)
                    if let responHeader = response.response?.statusCode {
                        if responHeader >= 400 {
                            completion(false, responHeader, nil)
                        } else {
                            if let json = response.result.value {
                                let data = JSON(json)
                                completion(true, responHeader, data)
                            }
                        }
                    }
                }
            case .failure(let encodingError):
                print(encodingError)
                completion(false, 400, nil)
            }
        }
    }
    
    fileprivate func requestHandler(response: DataResponse<Any>, url: String, param: Parameters?, method: HTTPMethodHelper, completion: @escaping(_ success: Bool, _ data: JSON?) -> Void) {
        if let data = response.result.value {
            let json = JSON(data)
//            if json["status"].stringValue == "EXPIRED_TOKEN" {
//                let params = [
//                 "refresh_token" : UserDefaults.standard.getRefreshToken()
//                 ]
//
//                 let refreshTokenURL = Constants.ServicesAPI.Authentication.refreshToken.baseURL
//
//                 manager.request(refreshTokenURL, method: .post, parameters: params).responseJSON(completionHandler: {
//                 (response) in
//                 guard let datas = response.result.value else {
//                 completion(false, nil)
//                 return
//                 }
//
//                 let refreshJSON = JSON(datas)
//                 let userProfile = UserDefaults.standard.getUserProfile()
//
//                 if let user = userProfile {
//                 user.userToken = refreshJSON["user_token"].stringValue
//                 user.refreshToken = refreshJSON["refresh_token"].stringValue
//
//                 UserDefaults.standard.setUserProfile(json: JSON(user.toJSON))
//                 } else {
//                 completion(false, nil)
//                 }
//
//                 self.requestAPI(url: url, param: param, method: method, completion: completion)
//                 })
//
//                 let dictExpired = [
//                 "is_expired" : true
//                 ]
//
//                 let dictJSON = JSON(dictExpired)
//
//                 completion(false, dictJSON)
//
//                let alert = UIAlertController.init(title: "Your session has been expired. Please login again", message: nil, preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {
//                    (action) in
//                    let storyboard = UIStoryboard(name: Constants.StoryboardReferences.authentication, bundle: nil)
//                    let loginViewController = storyboard.instantiateViewController(withIdentifier: Constants.ViewControllerID.Authentication.signIn) as! SignInViewController
//
//                    (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController = loginViewController
//                    (UIApplication.shared.delegate as! AppDelegate).window?.makeKeyAndVisible()
//                }))
//
//                (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController?.present(alert, animated: false, completion: nil)
//            } else {
//
//            }
            if json["status"].intValue == 200 {
                completion(true, json)
            } else {
                completion(false, json)
            }
        } else {
            completion(false, nil)
        }
    }
    
    func requestMultipart(_ file: Data, url: String, ids: String, completion: @escaping(_ success: Bool, _ data: JSON?) -> Void){
        
        let token = UserDefaults.standard.getToken()
        let header = [
            "content-type": "multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW",
            "cache-control": "no-cache",
            "Access-Token" : token
        ]
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(file, withName: "image", fileName: "user_avatar.jpg", mimeType: "image/jpeg")
            //multipartFormData.append(ids.data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName: "id_user")
        }, usingThreshold: SessionManager.multipartFormDataEncodingMemoryThreshold,
           to: url,
           method: .post,
           headers: header) { (encodingResult) in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    print(response)
                    if let json = response.result.value {
                        let data = JSON(json)
                        completion(true, data)
                    }else{
                        completion(false, nil)
                    }
                }
            case .failure(let encodingError):
                print(encodingError)
                completion(false, nil)
            }
        }
    }
}
