//
//  PostViewController.swift
//  hannes_social_community_app
//
//  Created by Hannes van Tonder on 2017/10/29.
//  Copyright © 2017 Hannes van Tonder. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {
    
    var apiClient = ApiService()
    var userId: Int?
    
    let lblTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Post title"
        return label
    }()
    let lblMessage: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Post body"
        return label
    }()
    let txtTitle: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    let txtViewPost: UITextView = {
        let txtView = UITextView()
        txtView.translatesAutoresizingMaskIntoConstraints = false
        return txtView
    }()
    lazy var btnPost: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(doPost), for: .touchUpInside)
        button.styleButton()
        button.setTitle("Post", for: .normal)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildView()
        styleView()
    }
    
    @objc func doPost(){
        guard let postTitle = txtTitle.text, !postTitle.isEmpty, let postBody = txtViewPost.text, !postBody.isEmpty else{
            return
        }
        apiClient.createPost(title: postTitle, postText: postBody) { (dict, error) in
            if error != nil{
                print(error!.localizedDescription)
            }
            else{
                print("Post created successfully")
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func styleView(){
        self.view.backgroundColor = UIColor.white
    }
    
    func buildView(){
        //        Post title label
        self.view.addSubview(lblTitle)
        lblTitle.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80).isActive = true
        lblTitle.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        
        //        Post tile text field
        self.view.addSubview(txtTitle)
        txtTitle.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        txtTitle.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true
        txtTitle.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 10).isActive = true
        txtTitle.heightAnchor.constraint(equalToConstant: 30).isActive = true
        txtTitle.styleDefaultTextField()
        
        //Post title message field
        self.view.addSubview(lblMessage)
        lblMessage.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        lblMessage.topAnchor.constraint(equalTo: txtTitle.bottomAnchor, constant: 10).isActive = true
        
        //        Post body text field
        self.view.addSubview(txtViewPost)
        txtViewPost.topAnchor.constraint(equalTo: lblMessage.bottomAnchor, constant: 10).isActive = true
        txtViewPost.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        txtViewPost.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true
        txtViewPost.heightAnchor.constraint(equalToConstant: 200).isActive = true
        txtViewPost.styleDefaultTextView()
        
        self.view.addSubview(btnPost)
        btnPost.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        btnPost.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true
        btnPost.topAnchor.constraint(equalTo: txtViewPost.bottomAnchor, constant: 10).isActive = true
        btnPost.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
