//
//  UserModel.swift
//  Vines
//
//  Created by Calista Bertha on 07/10/18.
//  Copyright © 2018 Calista Bertha. All rights reserved.
//

import SwiftyJSON

class UserModel {
    var id: String
    var name: String
    var email: String
    var rememberToken: String
    var birthdate: String
    var gender: String
    var profilePicture: String
    var phoneNumber: String
    var socialMediaID: String
    var avatar: String
    var registerFrom: String
    var verified: String
    var created: String
    var updated: String
    var userToken: String
    var refreshToken: String
    
    init(id: String, name: String, email: String, rememberToken: String, birthdate: String, gender: String, profilePicture: String, phoneNumber: String, socialMediaID: String, avatar: String, registerFrom: String, verified: String, created: String, updated: String, userToken: String, refreshToken: String) {
        self.id = id
        self.name = name
        self.email = email
        self.rememberToken = rememberToken
        self.birthdate = birthdate
        self.gender = gender
        self.profilePicture = profilePicture
        self.phoneNumber = phoneNumber
        self.socialMediaID = socialMediaID
        self.avatar = avatar
        self.registerFrom = registerFrom
        self.verified = verified
        self.created = created
        self.updated = updated
        self.userToken = userToken
        self.refreshToken = refreshToken
    }
    
    convenience init(json: JSON) {
        let id = json["id"].stringValue
        let name = json["name"].stringValue
        let email = json["email"].stringValue
        let rememberToken = json["remember_token"].stringValue
        let birthdate = json["birthdate"].stringValue
        let gender = json["gender"].stringValue
        let profilePicture = json["profile_picture"].stringValue
        let phoneNumber = json["phone_number"].stringValue
        let socialMediaID = json["social_media_id"].stringValue
        let avatar = json["avatar"].stringValue
        let registerFrom = json["register_from"].stringValue
        let verified = json["verified_at"].stringValue
        let created = json["created_at"].stringValue
        let updated = json["updated_at"].stringValue
        let userToken = json["user_token"].stringValue
        let refreshToken = json["refresh_token"].stringValue
        
        self.init(id: id, name: name, email: email, rememberToken: rememberToken, birthdate: birthdate, gender: gender, profilePicture: profilePicture, phoneNumber: phoneNumber, socialMediaID: socialMediaID, avatar: avatar, registerFrom: registerFrom, verified: verified, created: created, updated: updated, userToken: userToken, refreshToken: refreshToken)
    }
    
    var toJSON: Dictionary<String, Any> {
        return [
            "id" : self.id,
            "name" : self.name,
            "email" : self.email,
            "remember_token" : self.rememberToken,
            "birthdate" : self.birthdate,
            "gender" : self.gender,
            "profile_picture" : self.profilePicture,
            "social_media_id" : self.socialMediaID,
            "avatar" : self.avatar,
            "register_form" : self.registerFrom,
            "verified_at" : self.verified,
            "created_at" : self.created,
            "updated_at" : self.updated,
            "user_token" : self.userToken,
            "refresh_token" : self.refreshToken
        ]
    }
}
