//
//  SessionIdRequest.swift
//  Movie Manager
//
//  Created by mahmoud mohamed on 3/4/19.
//  Copyright © 2019 mahmoud mohamed. All rights reserved.
//

import Foundation
struct sessionIdRequest:Codable {
    var requestToken:String
    
    enum CodingKeys:String,CodingKey {
        case requestToken="request_token"
    }
}
