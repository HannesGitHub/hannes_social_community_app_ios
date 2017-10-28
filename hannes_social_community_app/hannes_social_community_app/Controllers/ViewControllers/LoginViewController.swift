//
//  LoginViewController.swift
//  hannes_social_community_app
//
//  Created by Hannes van Tonder on 2017/10/28.
//  Copyright © 2017 Hannes van Tonder. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    let apiClient = ApiService()
    
    var inputsContainerViewHeightConstraint: NSLayoutConstraint?
    var nameTextFieldHeightAnchor: NSLayoutConstraint?
    var emailTextFieldHeightAnchor: NSLayoutConstraint?
    var passwordTextFieldHeightAnchor: NSLayoutConstraint?
    
    let profileImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "social_icon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let inputContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var btnLoginRegister: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.styleStandardButton()
        button.setTitle("Register", for: .normal)
        button.addTarget(self, action: #selector(handleLoginRegister), for: .touchUpInside)
        return button
    }()
    
    lazy var loginRegisterSegmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Login", "Register"])
        control.translatesAutoresizingMaskIntoConstraints = false
        control.tintColor = UIColor.white
        control.selectedSegmentIndex = 1
        control.addTarget(self, action: #selector(handleLoginRegisterChange), for: .valueChanged)
        return control
    }()
    
    let seporatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.seporatorColor()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let usernameSeporatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.seporatorColor()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let txtName: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Name"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.layoutIfNeeded()
        return tf
    }()
    
    let txtUsername: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Username"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let txtPassword: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isSecureTextEntry = true
        return tf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildView()
        updateStyling()
    }
    
    func updateStyling(){
        self.view.backgroundColor = UIColor.appThemeColor()
    }
    
    @objc func handleLoginRegisterChange(){
        let title = loginRegisterSegmentedControl.titleForSegment(at: loginRegisterSegmentedControl.selectedSegmentIndex)
        btnLoginRegister.setTitle(title, for: .normal)
        
        inputsContainerViewHeightConstraint?.constant = loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 100 : 150
        seporatorView.isHidden = loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? true : false
        
        nameTextFieldHeightAnchor?.isActive = false
        nameTextFieldHeightAnchor = txtName.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 0 : 1/3)
        nameTextFieldHeightAnchor?.isActive = true
        
        emailTextFieldHeightAnchor?.isActive = false
        emailTextFieldHeightAnchor = txtUsername.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        emailTextFieldHeightAnchor?.isActive = true
        
        passwordTextFieldHeightAnchor?.isActive = false
        passwordTextFieldHeightAnchor = txtPassword.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        passwordTextFieldHeightAnchor?.isActive = true
    }
    
    @objc func handleLoginRegister(){
        if loginRegisterSegmentedControl.selectedSegmentIndex == 0{
            handleLogin()
        }
        else{
            handleRegister()
        }
    }
    func handleLogin(){
        guard let username = txtUsername.text, !username.isEmpty, let password = txtPassword.text, !password.isEmpty else{
            return
        }
        apiClient.login(username: username, password: password) { (dict, error) in
            if let response = dict{
                let user = User(dict: response)
                if let userAuthToken = user.authToken{
                    ActiveUserHelper.uuid = userAuthToken
                    self.dismiss(animated: true, completion: nil)
                }else{
                    print("Server did not respond with auth token")
                }
            }else if error != nil{
                print(error!.localizedDescription)
            }
        }
    }
    
    func handleRegister(){
        
        guard let name = txtName.text, !name.isEmpty, let username = txtUsername.text, !username.isEmpty, let password = txtPassword.text, !password.isEmpty else{
            return
        }
        apiClient.register(name: name, username: username, password: password) { (dict, error) in
            if let response = dict{
                let user = User(dict: response)
                if let userAuthToken = user.authToken{
                    ActiveUserHelper.uuid = userAuthToken
                    self.dismiss(animated: true, completion: nil)
                }else{
                    print("Server did not respond with auth token")
                }
            }else if error != nil{
                print(error!.localizedDescription)
            }
        }
    }
    
    func buildView(){
        self.view.addSubview(inputContainerView)
        self.view.addSubview(loginRegisterSegmentedControl)
        
        //Image view
        self.view.addSubview(profileImageView)
        profileImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: loginRegisterSegmentedControl.topAnchor, constant: -12).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        //Segmented control
        loginRegisterSegmentedControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        loginRegisterSegmentedControl.bottomAnchor.constraint(equalTo: inputContainerView.topAnchor, constant: -12).isActive = true
        loginRegisterSegmentedControl.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        loginRegisterSegmentedControl.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        //Inputs container view
        //x, y, width, height
        inputContainerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        inputContainerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        inputContainerView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -24).isActive = true
        inputsContainerViewHeightConstraint = inputContainerView.heightAnchor.constraint(equalToConstant: 150)
        inputsContainerViewHeightConstraint?.isActive = true
        
        //        Login/register button
        self.view.addSubview(btnLoginRegister)
        btnLoginRegister.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        btnLoginRegister.topAnchor.constraint(equalTo: inputContainerView.bottomAnchor, constant: 12).isActive = true
        btnLoginRegister.widthAnchor.constraint(lessThanOrEqualTo: inputContainerView.widthAnchor).isActive = true
        btnLoginRegister.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // Name field
        self.view.addSubview(txtName)
        txtName.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 12).isActive = true
        txtName.topAnchor.constraint(equalTo: inputContainerView.topAnchor).isActive = true
        txtName.widthAnchor.constraint(lessThanOrEqualTo: inputContainerView.widthAnchor).isActive = true
        nameTextFieldHeightAnchor = txtName.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1/3)
        nameTextFieldHeightAnchor?.isActive = true
        
        //Seporator
        self.view.addSubview(seporatorView)
        seporatorView.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor).isActive = true
        seporatorView.topAnchor.constraint(equalTo: txtName.bottomAnchor).isActive = true
        seporatorView.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        seporatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        // Username field
        self.view.addSubview(txtUsername)
        txtUsername.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 12).isActive = true
        txtUsername.topAnchor.constraint(equalTo: txtName.bottomAnchor).isActive = true
        txtUsername.widthAnchor.constraint(lessThanOrEqualTo: inputContainerView.widthAnchor).isActive = true
        emailTextFieldHeightAnchor = txtUsername.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1/3)
        emailTextFieldHeightAnchor?.isActive = true
        
        //Seporator
        self.view.addSubview(usernameSeporatorView)
        usernameSeporatorView.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor).isActive = true
        usernameSeporatorView.topAnchor.constraint(equalTo: txtUsername.bottomAnchor).isActive = true
        usernameSeporatorView.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        usernameSeporatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        // Password field
        self.view.addSubview(txtPassword)
        txtPassword.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 12).isActive = true
        txtPassword.topAnchor.constraint(equalTo: txtUsername.bottomAnchor).isActive = true
        txtPassword.widthAnchor.constraint(lessThanOrEqualTo: inputContainerView.widthAnchor).isActive = true
        passwordTextFieldHeightAnchor = txtPassword.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1/3)
        passwordTextFieldHeightAnchor?.isActive = true
    }
}
