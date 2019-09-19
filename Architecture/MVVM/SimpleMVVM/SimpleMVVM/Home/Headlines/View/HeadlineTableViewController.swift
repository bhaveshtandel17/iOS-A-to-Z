//
//  HeadlineTableViewController.swift
//  SimpleMVVM
//
//  Created by Bhavesh Tandel on 16/09/19.
//  Copyright © 2019 Bhavesh Tandel. All rights reserved.
//

import UIKit
import SafariServices

class HeadlineTableViewController: UITableViewController {
    
    var viewModel = ArticleListViewModel()
    
    var countryCode: String = (Locale.current as NSLocale).object(forKey: .countryCode) as? String ?? "in"

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "newsCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        self.dataBinding()
        viewModel.fetchHeadlines(countryCode: countryCode)
    }
    
    private func dataBinding() {
        viewModel.articleViewModelList.bindAndFire { [unowned self] articleViewModelList in
            let numberOfCell = self.tableView.numberOfRows(inSection: 0)
            var indexPaths: [IndexPath] = []
            for index in numberOfCell..<articleViewModelList.count {
                indexPaths.append(IndexPath(row: index, section: 0))
            }
            self.tableView.insertRows(at: indexPaths, with: .automatic)
        }
    }
    
}

// MARK: - Table view data source
extension HeadlineTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.totalArticleCount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTableViewCell
        cell.articleViewModel = self.viewModel[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = self.viewModel[indexPath.row].url else { return }
        let safariViewController = SFSafariViewController(url: url)
        self.present(safariViewController, animated: true, completion: nil)
    }

}
