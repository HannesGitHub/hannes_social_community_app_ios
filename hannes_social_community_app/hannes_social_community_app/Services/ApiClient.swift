//
//  ApiClient.swift
//  hannes_social_community_app
//
//  Created by Hannes van Tonder on 2017/10/28.
//  Copyright © 2017 Hannes van Tonder. All rights reserved.
//

import Foundation
import Alamofire

var baseUrl = "https://hannes-social-community-app.herokuapp.com/"

class ApiService{
    let headers: HTTPHeaders = [
        "Authorization": "Token token=\(ActiveUserHelper.uuid)",
        "Content-type": "application/json",
        "Accept": "text/html"
    ]

    func register(name: String, username: String, password: String, completionHandler:@escaping (NSDictionary?, NSError?) -> ()){
        let paramaters = [
            "name": name,
            "username": username,
            "password": password
        ]
        
        baseRequest(.post, paramaters: paramaters, headers: [:]) { (resopnse, error) in
            completionHandler(response, error)
        }
    }
    
    func baseRequest(_ method : HTTPMethod, paramaters : [String: Any]?, headers: [String: String], completionHandler:@escaping (NSDictionary?, NSError?) -> ()) {
        Alamofire.request(baseUrl, method: method, parameters: paramaters, encoding: JSONEncoding.default, headers: headers)
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
