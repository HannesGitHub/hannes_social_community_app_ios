//
//  ApiClient.swift
//  hannes_social_community_app
//
//  Created by Hannes van Tonder on 2017/10/28.
//  Copyright © 2017 Hannes van Tonder. All rights reserved.
//

import Foundation
import Alamofire

//var baseUrl = "https://hannes-social-community-app.herokuapp.com/"

var baseUrl = "https://bae412d0.ngrok.io"
var signupUrl = "api/signup"
var signinUrl = "api/login_auth"
var getFollowersUrl = "api/v1/me/followers"
var getFollowingUrl = "api/v1/me/following"
var getAllUsersUrl = "api/v1/users"
var getNewsFeedUrl = "api/v1/me/news_feed"
var followUserUrl = "api/v1/me/follow/"
var unFollowUserUrl = "api/v1/me/unfollow/"

class ApiService{
    
    let headers: HTTPHeaders = [
        "Authorization": "Token token=\(ActiveUserHelper.uuid != nil ?  ActiveUserHelper.uuid! : "")",
        "Content-type": "application/json",
        "Accept": "text/html"
    ]
    
    func register(name: String, username: String, password: String, completionHandler:@escaping (NSDictionary?, NSError?) -> ()){
        let paramaters = [
            "name": name,
            "username": username,
            "password": password
        ]
        baseRequest(methodUrl: signupUrl, .post, paramaters: paramaters, headers: [:]) { (resopnse, error) in
            completionHandler(resopnse, error)
        }
    }
    
    func login(username: String, password: String, completionHandler:@escaping (NSDictionary?, NSError?) -> ()){
        let paramaters = [
            "username": username,
            "password": password
        ]
        baseRequest(methodUrl: signinUrl, .post, paramaters: paramaters, headers: [:]) { (resopnse, error) in
            completionHandler(resopnse, error)
        }
    }
    
    func getFollowers(completionHandler:@escaping (NSDictionary?, NSError?) -> ()){
        baseRequest(methodUrl: getFollowersUrl, .get, paramaters: nil, headers: headers) { (response, error) in
            completionHandler(response, error)
        }
    }
    
    func getFollowing(completionHandler:@escaping (NSDictionary?, NSError?) -> ()){
        baseRequest(methodUrl: getFollowingUrl, .get, paramaters: nil, headers: headers) { (response, error) in
            completionHandler(response, error)
        }
    }
    
    func getAllUsers(completionHandler:@escaping (NSDictionary?, NSError?) -> ()){
        baseRequest(methodUrl: getAllUsersUrl, .get, paramaters: nil, headers: headers) { (response, error) in
            completionHandler(response, error)
        }
    }
    
    func followUser(userId: Int, completionHandler:@escaping (NSDictionary?, NSError?) -> ()){
        let url = "\(followUserUrl)\(userId)"
        baseRequest(methodUrl: url, .get, paramaters: nil, headers: headers) { (response, error) in
            completionHandler(response, error)
        }
    }
    
    func unFollowUser(userId: Int, completionHandler:@escaping (NSDictionary?, NSError?) -> ()){
        let url = "\(unFollowUserUrl)\(userId)"
        baseRequest(methodUrl: url, .get, paramaters: nil, headers: headers) { (response, error) in
            completionHandler(response, error)
        }
    }
    
    func getNewsFeed(completionHandler:@escaping (NSDictionary?, NSError?) -> ()){
        baseRequest(methodUrl: getNewsFeedUrl, .get, paramaters: nil, headers: headers) { (response, error) in
            completionHandler(response, error)
        }
    }
    
    func baseRequest(methodUrl: String, _ method : HTTPMethod, paramaters : [String: Any]?, headers: [String: String], completionHandler:@escaping (NSDictionary?, NSError?) -> ()) {
        let url = baseUrl + methodUrl
        Alamofire.request(url, method: method, parameters: paramaters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    completionHandler(value as? NSDictionary, nil)
                    break
                case .failure(let error):
                    completionHandler(nil, error as NSError)
                    break
                }
        }
    }
}
