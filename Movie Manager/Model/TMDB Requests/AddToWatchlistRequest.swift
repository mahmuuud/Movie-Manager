//
//  AddToWatchlistRequest.swift
//  Movie Manager
//
//  Created by mahmoud mohamed on 3/20/19.
//  Copyright © 2019 mahmoud mohamed. All rights reserved.
//

import Foundation
struct AddToWatchlistRequest:Codable {
    var mediaType:String
    var mediaId:Int
    var watchlist:Bool
    
    enum CodingKeys:String,CodingKey{
        case mediaType="media_type"
        case mediaId="media_id"
        case watchlist
    }
}
