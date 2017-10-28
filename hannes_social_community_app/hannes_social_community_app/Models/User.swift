//
//  User.swift
//  hannes_social_community_app
//
//  Created by Hannes van Tonder on 2017/10/28.
//  Copyright © 2017 Hannes van Tonder. All rights reserved.
//

import UIKit

class User: NSObject {
    var id: Int?
    var authToken: String?
    var createdAt: Date?
    var updatedAt: Date?
    var name: String?
    var surname: String?
    var username: String?
    
    init(dict: NSDictionary){
        
        if let userData = dict["data"] as? NSDictionary{
            if let authToken = userData["auth_token"] as? String{
                self.authToken = authToken
            }
            if let createdAt = dict["created_at"] as? String{
                self.createdAt = Date.railsStringToDate(dateString: createdAt)
            }
            if let updatedAt = dict["updated_at"] as? String{
                self.updatedAt = Date.railsStringToDate(dateString: updatedAt)
            }
            if let id = dict["id"] as? Int{
                self.id = id
            }
            if let name = dict["name"] as? String{
                self.name = name
            }
            if let surname = dict["surname"] as? String{
                self.surname = surname
            }
            if let username = dict["username"] as? String{
                self.username = username
            }
        }
    }
}
