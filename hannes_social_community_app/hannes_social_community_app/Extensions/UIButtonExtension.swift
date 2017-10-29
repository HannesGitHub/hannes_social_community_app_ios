//
//  UIButtonExtension.swift
//  hannes_social_community_app
//
//  Created by Hannes van Tonder on 2017/10/28.
//  Copyright © 2017 Hannes van Tonder. All rights reserved.
//

import UIKit

extension UIButton{
    func styleStandardButton(){
        self.backgroundColor = UIColor.appThemeColor()
    }
    
    func styleButton(){
        self.backgroundColor = UIColor.appThemeColor()
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.appThemeColor().cgColor
        self.setTitleColor(UIColor.white, for: .normal)
        self.titleEdgeInsets = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
    }
}
