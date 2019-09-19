//
//  NewsService.swift
//  SimpleMVVM
//
//  Created by Bhavesh Tandel on 16/09/19.
//  Copyright © 2019 Bhavesh Tandel. All rights reserved.
//

import Foundation

struct NewsService {
    static func fetchHeadlines(countryCode: String, callbacks: @escaping ([Article]?)-> Void) {
        let endPoint = "top-headlines?country=\(countryCode)&apiKey=\(AppConstant.apiKey)"
        guard let url = URL(string: "https://newsapi.org/v2/\(endPoint)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                let articlesJson = json["articles"] as! [Dictionary<String, AnyObject>]
                let articles = articlesJson.map{ Article(json: $0) }
                DispatchQueue.main.async {
                    callbacks(articles)
                }
            } catch {
                callbacks(nil)
            }
        })
        
        task.resume()
    }
}
