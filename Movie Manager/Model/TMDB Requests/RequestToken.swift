//
//  RequestToken.swift
//  Movie Manager
//
//  Created by mahmoud mohamed on 3/4/19.
//  Copyright © 2019 mahmoud mohamed. All rights reserved.
//

import Foundation
struct RequestToken:Codable{
    var success:Bool
    var expiresAt:String
    var requestToken:String
    
    enum CodingKeys:String, CodingKey {
        case success
        case expiresAt="expires_at"
        case requestToken="request_token"
    }
}
