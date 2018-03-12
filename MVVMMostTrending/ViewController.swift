//
//  ViewController.swift
//  MVVMMostTrending
//
//  Created by burak.ceylan on 01.03.18.
//  Copyright © 2018 burak.ceylan.dev.aperto.com. All rights reserved.
//

import UIKit
import Bond

class ViewController: UIViewController {
    
    let viewModel: ViewModel = ViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let apiAuthentification = APIAuthentifikation(consumerKey: "p3JJLoAw9NsIOVvu5w5GiNQjZ", consumerSecret: "1XS34O67qXpqCqMO59Ye3WY4zZkeAGXR8xz38kFonFtIFb15UG")
        viewModel.fetchTrends(restClient: APIRestClient(), apiAuth: apiAuthentification)
        viewModel.trends.bind(to: tableView, animated: true, createCell: { (trends, indexPath, tableView) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: "trendsCell", for: indexPath)
            cell.textLabel?.text = trends[indexPath.row].name
            cell.detailTextLabel?.text = "\(trends[indexPath.row].tweet_volume ?? 0)"
            return cell
        })
    }
        
}


