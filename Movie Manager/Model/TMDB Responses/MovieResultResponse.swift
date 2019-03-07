//
//  MovieResultResponse.swift
//  Movie Manager
//
//  Created by mahmoud mohamed on 3/6/19.
//  Copyright © 2019 mahmoud mohamed. All rights reserved.
//

import Foundation
struct MovieResultResponse:Codable {
    var page:Int
    var results:[Movie]
    var totalPages:Int
    var totalResults:Int
    
    enum CodingKeys:String,CodingKey {
        case page
        case results
        case totalPages="total_pages"
        case totalResults="total_results"
    }
}
