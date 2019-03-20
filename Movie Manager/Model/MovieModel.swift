//
//  MovieModel.swift
//  Movie Manager
//
//  Created by mahmoud mohamed on 3/6/19.
//  Copyright © 2019 mahmoud mohamed. All rights reserved.
//

import Foundation
struct MovieModel {
    static var watchList:[Movie]=[]
    static var favourites:[Movie]=[]
    
    static func isWatchlist(movie:Movie)->Bool{
        for m in watchList{
            if m.id==movie.id{
                return true
            }
        }
        return false
    }
    
    static func isFavourite(movie:Movie)->Bool{
        for m in favourites{
            if m.id==movie.id{
                return true
            }
        }
        return false
    }
}
