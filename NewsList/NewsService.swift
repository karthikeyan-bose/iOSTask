//
//  NewsService.swift
//  NewsList
//
//  Created by Bose, Karthikeyan (Cognizant) on 11/09/23.
//

import Foundation

class NewsService {
    let apiKey = "RiTezICSAaZ5XpGZmatS198JEYwMiaBT"
    var mockedNews: [News]?


    func fetchNews(completion: @escaping ([News]?) -> Void) {
        guard let url = URL(string: "https://api.nytimes.com/svc/topstories/v2/world.json?api-key=\(apiKey)") else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }

            do {
                let decoder = JSONDecoder()
                let newsResponse = try decoder.decode(NewsResponse.self, from: data)
                let news = newsResponse.results
                completion(news)
            } catch {
                completion(nil)
            }
        }.resume()
    }
}


class NewsServiceMock: NewsService {
    
    override func fetchNews(completion: @escaping ([News]?) -> Void) {
        if let mockedNews = mockedNews {
            completion(mockedNews)
        } else {
            completion(nil)
        }
    }
}
