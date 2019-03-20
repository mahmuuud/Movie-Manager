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
    
    @IBOutlet weak var favBtn: UIBarButtonItem!
    @IBOutlet weak var watchlistBtn: UIBarButtonItem!
    var currentMovie:Movie!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden=true
    }
    
    @IBAction func favBtnTapped(_ sender: Any) {
        
    }
    
    @IBAction func watchlistBtnTapped(_ sender: Any) {
        configureUI()
        if !MovieModel.isWatchlist(movie: currentMovie){
            Client.addToWatchlist(movieId: currentMovie.id)
        }
        
        print(currentMovie.id)
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
    
}
