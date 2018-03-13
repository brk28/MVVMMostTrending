//
//  ViewController.swift
//  MVVMMostTrending
//
//  Created by burak.ceylan on 01.03.18.
//  Copyright © 2018 burak.ceylan.dev.aperto.com. All rights reserved.
//

import UIKit
import Bond
import SafariServices

class ViewController: UIViewController {
    
    let viewModel: ViewModel = ViewModel()
    
    let tableViewCellIdentifier = "trendsCell"
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        viewModel.fetchTrends(restClient: AppProvider.restClient)
        viewModel.trends.bind(to: tableView, animated: true, createCell: { (trends, indexPath, tableView) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: self.tableViewCellIdentifier, for: indexPath)
            cell.textLabel?.text = trends[indexPath.row].name
            cell.detailTextLabel?.text = "\(trends[indexPath.row].tweetVolume ?? 0)"
            return cell
        })
    }
        
}

extension ViewController: UITableViewDelegate, SFSafariViewControllerDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = URL(string: viewModel.trends[indexPath.row].url) else { return }
        let safariVC = SFSafariViewController(url: url)
        safariVC.delegate = self
        present(safariVC, animated: true, completion: nil)
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}


