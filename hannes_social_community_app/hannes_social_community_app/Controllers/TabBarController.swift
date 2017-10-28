//
//  TabBarController.swift
//  hannes_social_community_app
//
//  Created by Hannes van Tonder on 2017/10/28.
//  Copyright © 2017 Hannes van Tonder. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create home tab
        let homeTab = HomeViewController()
        let homeTabBarItem = UITabBarItem(title: "News", image: UIImage(named: "defaultImage.png"), selectedImage: UIImage(named: "selectedImage.png"))
        homeTab.tabBarItem = homeTabBarItem
        
        //Create network tab
        let networkTab = NetworkViewController()
        let networkTabBarItem = UITabBarItem(title: "Network", image: UIImage(named: "defaultImage.png"), selectedImage: UIImage(named: "selectedImage.png"))
        networkTab.tabBarItem = networkTabBarItem
        
        //Create users tab
        let usersTab = NetworkViewController()
        let usersTabBarItem = UITabBarItem(title: "Users", image: UIImage(named: "defaultImage.png"), selectedImage: UIImage(named: "selectedImage.png"))
        usersTab.tabBarItem = usersTabBarItem
        
        self.viewControllers = [homeTab, networkTab, usersTab]
    }
    
    // UITabBarControllerDelegate method
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected \(viewController.title ?? "not set")")
    }
}
