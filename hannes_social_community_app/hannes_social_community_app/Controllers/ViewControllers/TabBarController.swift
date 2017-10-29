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
        perform(#selector(checkIfUserIsLoggedIn), with: nil, afterDelay: 0)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        buildView()
    }
    
    @objc func checkIfUserIsLoggedIn(){
        if ActiveUserHelper.uuid == nil{
            handleLogOut()
        }
    }
    
    func buildView(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogOut))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Post", style: .plain, target: self, action: #selector(openPostController))
        
        // Create home tab
        let homeTab = HomeViewController()
        let homeTabBarItem = UITabBarItem(title: "News", image: UIImage(named: "news"), selectedImage: UIImage(named: "selectedImage.png"))
        homeTab.tabBarItem = homeTabBarItem
        
        //Create network tab
        let networkTab = NetworkViewController()
        let networkTabBarItem = UITabBarItem(title: "Network", image: UIImage(named: "network"), selectedImage: UIImage(named: "selectedImage.png"))
        networkTab.tabBarItem = networkTabBarItem
        
        //Create users tab
        let usersTab = UsersViewController()
        let usersTabBarItem = UITabBarItem(title: "Users", image: UIImage(named: "users"), selectedImage: UIImage(named: "selectedImage.png"))
        usersTab.tabBarItem = usersTabBarItem
        
        self.viewControllers = [homeTab, networkTab, usersTab]
    }
    
    @objc func openPostController(){
        let postController = PostViewController()
        self.navigationController?.pushViewController(postController, animated: true)
    }
    
    @objc func handleLogOut(){
        ActiveUserHelper.uuid = nil
        let loginController = LoginViewController()
        self.present(loginController, animated: true, completion: nil)
    }
}

extension TabBarController{
    // UITabBarControllerDelegate method
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected \(viewController.title ?? "not set")")
    }
}
