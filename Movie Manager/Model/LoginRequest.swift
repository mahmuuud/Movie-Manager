//
//  LoginRequest.swift
//  Movie Manager
//
//  Created by mahmoud mohamed on 3/4/19.
//  Copyright © 2019 mahmoud mohamed. All rights reserved.
//

import Foundation
struct LoginRequest:Codable {
    var username:String
    var password:String
    var requestToken:String
    
    enum CodingKeys:String,CodingKey {
        case username
        case password
        case requestToken="request_token"
    }
}
