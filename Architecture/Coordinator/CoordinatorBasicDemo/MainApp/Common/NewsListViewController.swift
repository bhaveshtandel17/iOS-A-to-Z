//
//  NewsListViewController.swift
//  CoordinatorBasicDemo
//
//  Created by Bhavesh Tandel on 29/08/19.
//  Copyright © 2019 Bhavesh Tandel. All rights reserved.
//

import UIKit

class NewsListViewController: UITableViewController, ObjectLifeLogable {
    
    var articles: [Article] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    deinit {
        self.printObejectLifeEventChanges(state: .deinitialize)
    }
    
    internal var getEndPoint: (() -> String?) = {
        fatalError("End point is not set!")
    }
    internal var showArticleOnWebView: ((_ url: URL?) -> Void) = {_ in }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "newsCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        doFech()
    }
    
    private func doFech() {
        guard  let endPoint = self.getEndPoint(), let url = URL(string: "https://newsapi.org/v2/\(endPoint)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { [weak self] data, response, error -> Void in
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                let articlesJson = json["articles"] as! [Dictionary<String, AnyObject>]
                let articles = articlesJson.map{ Article(json: $0) }
                DispatchQueue.main.async {
                    self?.articles = articles
                }
            } catch {
                print("error while \(url.absoluteURL)")
            }
        })
        
        task.resume()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return self.articles.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTableViewCell
        cell.article = articles[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.showArticleOnWebView(articles[indexPath.row].url)
    }
}
