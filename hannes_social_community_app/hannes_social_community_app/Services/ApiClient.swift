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
    
    let params = ["device": "main-gate-1",
                  "topic": "main-gate",
                  "value": 3] as [String : Any]
    
    func doTest(){
        Alamofire.request(baseUrl, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
            .responseString { response in
                switch response.result {
                case .success(let value):
                    print(value)
                    break
                    
                case .failure(let error):
                    print(error)
                    break
                }
        }
    }
    
    static func hannesTest(){
        
    }
    
    
    
    
    
}

