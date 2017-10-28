//
//  HomeViewController.swift
//  hannes_social_community_app
//
//  Created by Hannes van Tonder on 2017/10/28.
//  Copyright © 2017 Hannes van Tonder. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        buildView()
        updateStyling()
        
    }
    
    func buildView(){
        
    }
    
    func updateStyling(){
        self.view.backgroundColor = UIColor.orange
        self.title = "Home"
    }
    
    


}
