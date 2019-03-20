//
//  FavouritesVC.swift
//  Movie Manager
//
//  Created by mahmoud mohamed on 2/27/19.
//  Copyright © 2019 mahmoud mohamed. All rights reserved.
//

import Foundation
import UIKit

class FavouritesVC:UITableViewController{
    
    @IBOutlet var moviesTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesTable.delegate=self
        moviesTable.dataSource=self
        moviesTable.reloadData()
        self.tabBarController?.tabBar.isHidden=false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        Client.getFavouritesList { (movies, error) in
            guard let movies=movies else{
                return
            }
            MovieModel.favourites=movies
            let movie=MovieModel.favourites[0]
            print(movie.title)
            DispatchQueue.main.async {
                self.moviesTable.reloadData()
                self.tabBarController?.tabBar.isHidden=false
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieDetailsVC=self.storyboard?.instantiateViewController(withIdentifier: "movieDetails") as! MovieDetailsVC
        movieDetailsVC.currentMovie=MovieModel.favourites[indexPath.row]
        self.navigationController?.pushViewController(movieDetailsVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "favCell")
        let movie=MovieModel.favourites[indexPath.row]
        cell?.textLabel?.text=movie.title
        Client.getPoster(posterPath: movie.posterPath ?? "") { (image, error) in
            guard let image=image else{
                print (error as Any)
                return
            }
            DispatchQueue.main.async {
                cell?.imageView?.image=image
                cell?.setNeedsLayout()
            }
        }
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MovieModel.favourites.count
    }
    
    @IBAction func dismissFavs(_ sender: Any) {
        Client.logout()
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
        
    }
}
