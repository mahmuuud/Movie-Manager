//
//  SessionIdResponse.swift
//  Movie Manager
//
//  Created by mahmoud mohamed on 3/4/19.
//  Copyright © 2019 mahmoud mohamed. All rights reserved.
//

import Foundation
struct SessionIdResponse:Codable {
    var success:Bool
    var sessionId:String
    
    enum CodingKeys:String,CodingKey {
        case success
        case sessionId="session_id"
    }
    
}
