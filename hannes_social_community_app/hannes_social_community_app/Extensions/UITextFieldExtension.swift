//
//  UITextFieldExtension.swift
//  hannes_social_community_app
//
//  Created by Hannes van Tonder on 2017/10/29.
//  Copyright © 2017 Hannes van Tonder. All rights reserved.
//

import UIKit

extension UITextField{
    func styleDefaultTextField(){
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.appThemeColor().cgColor
    }
}
