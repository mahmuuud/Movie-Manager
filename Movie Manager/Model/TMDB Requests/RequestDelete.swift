//
//  RequestDelete.swift
//  Movie Manager
//
//  Created by mahmoud mohamed on 3/5/19.
//  Copyright © 2019 mahmoud mohamed. All rights reserved.
//

import Foundation
struct RequestDelete:Codable {
    var sessionId:String
    
    enum CodingKeys:String,CodingKey {
        case sessionId="session_id"
    }
}
