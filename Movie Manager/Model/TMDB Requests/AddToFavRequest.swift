//
//  AddToFavRequest.swift
//  Movie Manager
//
//  Created by mahmoud mohamed on 3/20/19.
//  Copyright © 2019 mahmoud mohamed. All rights reserved.
//

import Foundation
struct AddToFavRequest:Codable {
    var mediaType:String
    var mediaId:Int
    var favorite:Bool
    
    enum CodingKeys:String,CodingKey{
        case mediaType="media_type"
        case mediaId="media_id"
        case favorite
    }
}
