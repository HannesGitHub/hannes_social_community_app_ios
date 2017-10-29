//
//  SocialHelper.swift
//  hannes_social_community_app
//
//  Created by Hannes van Tonder on 2017/10/28.
//  Copyright © 2017 Hannes van Tonder. All rights reserved.
//

import Foundation

class SocialHelper{
    
    static func populateUsersFromList(dict: NSDictionary) -> [User]{
        var users: [User] = []
        if let dataArray = dict["data"] as? NSArray?{
            for obj in dataArray!{
                if let innerObj = obj as? NSDictionary{
                    if let userObj = innerObj["user"] as? NSDictionary{
                        users.append(User(dict: userObj))
                    }
                    else if let userObj = innerObj["follower"] as? NSDictionary{
                        users.append(User(dict: userObj))
                    }
                }
            }
        }
        return users
    }
}
