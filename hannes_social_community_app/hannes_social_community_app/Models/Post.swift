//
//  Post.swift
//  hannes_social_community_app
//
//  Created by Hannes van Tonder on 2017/10/28.
//  Copyright © 2017 Hannes van Tonder. All rights reserved.
//

import UIKit

class Post: NSObject {
    var id: Int?
    var title: String?
    var createdAt: Date?
    var updatedAt: Date?
    var message: String?
    var userId: Int?
    
    init(dict: NSDictionary){
        if let createdAt = dict["created_at"] as? String{
            self.createdAt = Date.railsStringToDate(dateString: createdAt)
        }
        if let updatedAt = dict["updated_at"] as? String{
            self.updatedAt = Date.railsStringToDate(dateString: updatedAt)
        }
        if let id = dict["id"] as? Int{
            self.id = id
        }
        if let title = dict["title"] as? String{
            self.title = title
        }
        if let message = dict["message"] as? String{
            self.message = message
        }
    }
}
