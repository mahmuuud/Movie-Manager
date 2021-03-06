//
//  WatchlistVC.swift
//  Movie Manager
//
//  Created by mahmoud mohamed on 2/27/19.
//  Copyright © 2019 mahmoud mohamed. All rights reserved.
//

import Foundation
import UIKit
class WatchlistVC: UITableViewController{
    
    @IBOutlet var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate=self
        table.dataSource=self
        table.reloadData()
        self.tabBarController?.tabBar.isHidden=false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        Client.getWatchList { (movies, error) in
            let movie=movies![0]
            MovieModel.watchList=movies!
            print(movie.title)
            DispatchQueue.main.async {
                self.tabBarController?.tabBar.isHidden=false
                self.table.reloadData()
            }
        }

    }
    
    @IBAction func dismissWatchlist(_ sender: Any) {
        Client.logout()
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    internal override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "watchlistCell")
        let movie=MovieModel.watchList[indexPath.row]
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
        return MovieModel.watchList.count
    }
    
    override func tableView(_ tableView: UITableView,
                            heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 100.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieDetailsVC=self.storyboard?.instantiateViewController(withIdentifier: "movieDetails") as! MovieDetailsVC
        movieDetailsVC.currentMovie=MovieModel.watchList[indexPath.row]
        self.navigationController?.pushViewController(movieDetailsVC, animated: true)
    }
}
