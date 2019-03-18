//
//  Client.swift
//  Movie Manager
//
//  Created by mahmoud mohamed on 3/1/19.
//  Copyright © 2019 mahmoud mohamed. All rights reserved.
//

import Foundation

class Client{

    static let apiKey="97cf4fbadae43c0e1c7f6dad60616d96"
    struct Auth {
        static var accountId=0
        static var requestToken=""
        static var sessionId=""
    }
    
    enum Endpoint {
        static let apiKeyParam="/new?api_key=\(Client.apiKey)"
        case requestNewToken
        case authentication
        case requestSessionId
        case logout
        case getWatchList
        case getMovieDetails(id:Int)
        case searchMovie(movieName:String)
        case getFavList
        var stringValue:String{
            switch self {
            case .requestNewToken:
                return "https://api.themoviedb.org/3/authentication/token"+Endpoint.apiKeyParam
            
            case .authentication:
                return "https://api.themoviedb.org/3/authentication/token/validate_with_login?api_key="+apiKey
            
            case .requestSessionId:
                return "https://api.themoviedb.org/3/authentication/session/new?api_key="+apiKey
                
            case .logout:
                return "https://api.themoviedb.org/3/authentication/session?api_key="+apiKey
            
            case.getWatchList:
                return "https://api.themoviedb.org/3/account/\(Auth.accountId)/watchlist/movies?api_key=\(apiKey)&language=en-US&sort_by=created_at.asc&page=1&session_id=\(Auth.sessionId)"
            case .getMovieDetails(let id):
                return "https://api.themoviedb.org/3/movie/{\(id)}/images?api_key=\(apiKey)&language=en-US"
            case .searchMovie(let movieName):
                return "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&language=en-US&query=\(movieName)&page=1&include_adult=false"
            case .getFavList:
                return "https://api.themoviedb.org/3/account/\(Auth.accountId)/favorite/movies?api_key=\(apiKey)&language=en-US&sort_by=created_at.asc&page=1&session_id=\(Auth.sessionId)"
           
            }
        }
        var url:URL{
            return URL(string: stringValue)!
        }
    }
    
    class func getRequestToken(completionHandler:@escaping (Bool,Error?)->Void){
        let url=self.Endpoint.requestNewToken.url
        let task=URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data=data else{
                completionHandler(false,error)
                return
            }
            let decoder=JSONDecoder()
            do{
                let token=try decoder.decode(RequestToken.self, from: data)
                Auth.requestToken=token.requestToken
                completionHandler(token.success,nil)
            }
            catch{
                completionHandler(false,error)
            }
            
        }
        task.resume()
    }
    
    class func login(username:String,password:String,completionHandler:@escaping(Bool,Error?)->Void){
        let url=Endpoint.authentication.url
        var request=URLRequest(url: url)
        request.httpMethod="POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let loginRequest=LoginRequest(username:username,password:password,requestToken:Auth.requestToken)
        let encoder=JSONEncoder()
        request.httpBody=try!encoder.encode(loginRequest)
        let task=URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data=data else{
                completionHandler(false,error)
                return
            }
            let decoder=JSONDecoder()
            do{
                let response=try decoder.decode(RequestToken.self, from: data)
                self.Auth.requestToken=response.requestToken 
                completionHandler(true,nil)
            }
            catch{
                print(error)
                completionHandler(false,error)
            }
           
        }
        task.resume()
    }
    
    class func requestSessionId(completionHandler:@escaping (Bool,Error?)->Void){
        let url=Endpoint.requestSessionId.url
        var request=URLRequest(url: url)
        request.httpMethod="POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let idRequest=sessionIdRequest.init(requestToken: Auth.requestToken)
        let encoder=JSONEncoder()
        request.httpBody=try!encoder.encode(idRequest)
        let task=URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data=data else{
                completionHandler(false,error)
                return
            }
            let decoder=JSONDecoder()
            do{
                let response=try decoder.decode(SessionIdResponse.self, from: data)
                Auth.sessionId=response.sessionId
                completionHandler(true,nil)
            }
            catch{
                print(error)
                completionHandler(false,error)
            }
            
        }
        task.resume()
    }
    
    class func logout(){
        let url=Endpoint.logout.url
        var request=URLRequest(url: url)
        request.httpMethod="DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let deleteRequest=RequestDelete.init(sessionId: Auth.sessionId)
        let encoder=JSONEncoder()
        request.httpBody=try!encoder.encode(deleteRequest)
        let task=URLSession.shared.dataTask(with: request)
        task.resume()
    }
    
    class func getWatchList(completionHandler:@escaping([Movie]?,Error?)->Void){
        let url=Endpoint.getWatchList.url
        let task=URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data=data else{
                completionHandler(nil,error)
                return
            }
            let decoder=JSONDecoder()
            do{
                let response=try decoder.decode(MovieResultResponse.self, from: data)
                let movies=response.results
                completionHandler(movies,nil)
            }
            catch{
                completionHandler(nil,error)
                print(error)
            }
        }
        task.resume()
    }
    
    class func searchMovie(movieName:String,completionHandler:@escaping([Movie]?,Error?)->Void){
        let url=Endpoint.searchMovie(movieName: movieName).url
        let task=URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data=data else{
                completionHandler(nil,error)
                return
            }
            let decoder=JSONDecoder()
            do{
                let response=try decoder.decode(MovieResultResponse.self, from: data)
                let movies=response.results
                completionHandler(movies,nil)
            }
            catch{
                completionHandler(nil,error)
                print(error)
            }
        }
        task.resume()
    }
    
    class func getFavouritesList(completionHandler:@escaping([Movie]?,Error?)->Void){
        let url=self.Endpoint.getFavList.url
        let task=URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data=data else{
                completionHandler(nil,error)
                return
            }
            let decoder=JSONDecoder()
            do{
                let resultResponse=try decoder.decode(MovieResultResponse.self, from: data)
                let movies=resultResponse.results
                completionHandler(movies,nil)
            }
            catch{
                completionHandler(nil,error)
                print(error)
            }
        }
        task.resume()
    }
}
