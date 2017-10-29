	//
//  UserDetailViewController.swift
//  hannes_social_community_app
//
//  Created by Hannes van Tonder on 2017/10/29.
//  Copyright © 2017 Hannes van Tonder. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    let apiClient = ApiService()
    var user: User?
    
    let lblUsernName: UILabel = {
        let lblUsernName = UILabel()
        lblUsernName.translatesAutoresizingMaskIntoConstraints = false
        return lblUsernName
    }()
    let lblEmail: UILabel = {
        let lblEmail = UILabel()
        lblEmail.translatesAutoresizingMaskIntoConstraints = false
        return lblEmail
    }()
    lazy var btnFollow: UIButton = {
        let btnFollow = UIButton()
        btnFollow.translatesAutoresizingMaskIntoConstraints = false
        btnFollow.addTarget(self, action: #selector(btnFollowTapped), for: .touchUpInside)
        btnFollow.setTitle("Follow", for: .normal)
        return btnFollow
    }()
    lazy var btnUnFollow: UIButton = {
        let btnUnFollow = UIButton()
        btnUnFollow.translatesAutoresizingMaskIntoConstraints = false
        btnUnFollow.addTarget(self, action: #selector(btnUnFollowTapped), for: .touchUpInside)
        btnUnFollow.setTitle("Unfollow", for: .normal)
        return btnUnFollow
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildView()
        styleView()
        poulateViewWithData()
    }
    
    @objc func btnUnFollowTapped(){
        print("Unfollow tapped")
        if let viewUser = user{
            if let userId = viewUser.id{
                apiClient.unFollowUser(userId: userId, completionHandler: { (dict, error) in
                    if error != nil{
                        print(error!.localizedDescription)
                    }
                    else{
                        print("Unfollowed successfully")
                    }
                })
            }
        }
    }
    
    @objc func btnFollowTapped(){
        print("Follow tapped")
        if let viewUser = user{
            if let userId = viewUser.id{
                apiClient.followUser(userId: userId, completionHandler: { (dict, error) in
                    if error != nil{
                        print(error!.localizedDescription)
                    }
                    else{
                        print("Following successfully")
                    }
                })
            }
        }
    }
    
    func poulateViewWithData(){
        if let userName = user?.name{
            lblUsernName.text = userName
        }
        if let email = user?.username{
            lblEmail.text = email
        }
    }
    
    func buildView(){
        //        Surname label
        self.view.addSubview(lblUsernName)
        lblUsernName.numberOfLines = 0
        lblUsernName.textAlignment = .center
        lblUsernName.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80).isActive = true
        lblUsernName.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        lblUsernName.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 10).isActive = true
        
        //        Email label
        self.view.addSubview(lblEmail)
        lblEmail.numberOfLines = 0
        lblEmail.textAlignment = .center
        lblEmail.topAnchor.constraint(equalTo: lblUsernName.bottomAnchor, constant: 10).isActive = true
        lblEmail.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        lblEmail.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 10).isActive = true
        
        //        Unfollow button
        self.view.addSubview(btnUnFollow)
        btnUnFollow.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20).isActive = true
        btnUnFollow.widthAnchor.constraint(equalToConstant: 240).isActive = true
        btnUnFollow.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btnUnFollow.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        btnUnFollow.styleButton()
        
        //        Follow button
        self.view.addSubview(btnFollow)
        btnFollow.bottomAnchor.constraint(equalTo: btnUnFollow.topAnchor, constant: -10).isActive = true
        btnFollow.widthAnchor.constraint(equalToConstant: 240).isActive = true
        btnFollow.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btnFollow.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        btnFollow.styleButton()
    }
    
    func styleView(){
        self.view.backgroundColor = UIColor.white
    }
}
