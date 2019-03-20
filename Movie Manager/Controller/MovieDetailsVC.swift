//
//  MovieDetailsVC.swift
//  Movie Manager
//
//  Created by mahmoud mohamed on 3/18/19.
//  Copyright © 2019 mahmoud mohamed. All rights reserved.
//

import Foundation
import UIKit
class MovieDetailsVC:UIViewController{
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var favBtn: UIBarButtonItem!
    @IBOutlet weak var watchlistBtn: UIBarButtonItem!
    var currentMovie:Movie!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        Client.getPoster(posterPath: currentMovie.posterPath ?? "", completionHandler: handlePoster(image:error:))
           
        
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden=true
    }
    
    @IBAction func favBtnTapped(_ sender: Any) {
        if !MovieModel.isFavourite(movie: currentMovie) {
            self.favBtn.tintColor=self.view.tintColor
            Client.addToFavourites(movieId: currentMovie.id,favorite: true)
            MovieModel.favourites.append(currentMovie)
        }
        else{
            self.favBtn.tintColor=UIColor.gray
            Client.addToFavourites(movieId: currentMovie.id,favorite: false)
            MovieModel.favourites=MovieModel.favourites.filter(){$0.id != self.currentMovie.id}
        }
    }
    
    @IBAction func watchlistBtnTapped(_ sender: Any) {
        if !MovieModel.isWatchlist(movie: currentMovie){
            Client.addToWatchlist(movieId: currentMovie.id,watchlist: true)
             self.watchlistBtn.tintColor=self.view.tintColor
            MovieModel.watchList.append(currentMovie)
        }
        else{
            Client.addToWatchlist(movieId: currentMovie.id, watchlist: false)
            self.watchlistBtn.tintColor=UIColor.gray
            MovieModel.watchList = MovieModel.watchList.filter(){$0.id != self.currentMovie.id}
        }
    }
    
    func configureUI(){
        if MovieModel.isWatchlist(movie: currentMovie) {
            watchlistBtn.tintColor=self.view.tintColor
        }
        else{
            watchlistBtn.tintColor=UIColor.gray
        }
        if MovieModel.isFavourite(movie: currentMovie){
            favBtn.tintColor=self.view.tintColor
        }
        else{
            favBtn.tintColor=UIColor.gray
        }
    }
    
     func handlePoster(image:UIImage?,error:Error?){
        guard let image=image else{
            print(error as Any)
            return
        }
        DispatchQueue.main.async {
            self.imageView.image=image
        }
    }
    
}
