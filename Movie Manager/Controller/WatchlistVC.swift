//
//  WatchlistVC.swift
//  Movie Manager
//
//  Created by mahmoud mohamed on 2/27/19.
//  Copyright © 2019 mahmoud mohamed. All rights reserved.
//

import Foundation
import UIKit
class WatchlistVC: UITableViewController {
    
    @IBAction func dismissWatchlist(_ sender: Any) {
        Client.logout()
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }    }
}
