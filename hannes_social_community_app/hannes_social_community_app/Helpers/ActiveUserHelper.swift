//
//  ActiveUserHelper.swift
//  hannes_social_community_app
//
//  Created by Hannes van Tonder on 2017/10/28.
//  Copyright © 2017 Hannes van Tonder. All rights reserved.
//

import Foundation

class ActiveUserHelper{
    
    static var uuid: String?{
        get{
            return UserDefaults.standard.value(forKey: "user_uid") as? String ?? nil
        }
        set{
            UserDefaults.standard.setValue(newValue, forKey: "user_uid")
        }
    }
    
}
