//
//  SearchVC.swift
//  Movie Manager
//
//  Created by mahmoud mohamed on 2/27/19.
//  Copyright © 2019 mahmoud mohamed. All rights reserved.
//

import Foundation
import UIKit

class SearchVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate{
    var movies:[Movie]=[]
    @IBOutlet weak var moviesTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesTable.delegate=self
        moviesTable.dataSource=self
        searchBar.delegate=self
    }

    @IBAction func dismissSearchVC(_ sender: Any) {
        Client.logout()
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieDetailsVC=self.storyboard?.instantiateViewController(withIdentifier: "movieDetails")
        self.navigationController?.pushViewController(movieDetailsVC!, animated: true)
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "searchCell")
        let movie=movies[indexPath.row]
        cell?.textLabel?.text=movie.title
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Search bar ended editing")
        guard var movieName=self.searchBar.text else{
            return
        }
        if movieName.contains(" "){
          movieName = movieName.replacingOccurrences(of: " ", with: "%20")
        }
        Client.searchMovie(movieName: movieName) { (movies, error) in
            guard let movies=movies else{
                print(error ?? "error searching")
                return
            }
            self.movies=movies
            DispatchQueue.main.async {
                self.moviesTable.reloadData()
                searchBar.resignFirstResponder()
            }
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if searchBar.text==""{
            self.movies=[]
            self.moviesTable.reloadData()
        }
    }
}
