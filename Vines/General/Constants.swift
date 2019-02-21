//
//  Constant.swift
//  Vines
//
//  Created by Calista Bertha on 07/10/18.
//  Copyright © 2018 Calista Bertha. All rights reserved.
//

import Foundation

struct Constants {
    
    struct ServicesAPI {
        static var apiBaseURL: String {
            if userDefault().isDebug() {
                return "http://209.97.165.47:8081/"
            } else {
                return "http://45.64.97.98:8081/"
            }
        }
        
        struct User {
            static let login = "user/authentication"
            static let register = "user/register"
            static let updatePassword = "user/update_password"
            static let wishlist = "user/wishlist"
            static let addWishlist = "user/add_wishlist"
            static let deleteWishlist = "user/delete_wishlist"
            static let addCart = "order/temporary"
            static let deleteCart = "delete_temporary"
            static let orderCode = "get_ordercode"
            static let listCart = "list_temporary"
        }
        
        struct Store {
            static let list = "store/list"
            static let detail = "store/detail"
        }
        
        struct Promotion {
            static let promotion = "promotions"
        }
        
        struct Product {
            static let list = "product/list"
            static let favourite = "product/favourite"
            static let similiar = "product/similiar"
            static let detail = "product/detail"
        }
    
        struct News {
            static let list = "news"
            static let terms = "term_conditions"
            static let privacy = "privacy_policy"
        }
        
        struct Order {
            static let list = "user/current_order"
        }
        
        struct Party {
            static let submit = "party_service"
            static let package = "select_package"
        }
    }
}
