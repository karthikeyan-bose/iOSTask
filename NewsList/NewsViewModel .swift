//
//  NewsViewModel .swift
//  NewsList
//
//  Created by Bose, Karthikeyan (Cognizant) on 11/09/23.
//

import Foundation

class NewsViewModel {
    var news: [News] = []
    let newsService: NewsService
    
    init(newsService: NewsService) {
        self.newsService = newsService
    }
    
    func fetchNews(completion: @escaping () -> Void) {
        newsService.fetchNews { [weak self] fetchedNews in
            guard let fetchedNews = fetchedNews else {
                return
            }
            
            self?.news = fetchedNews
            completion()
        }
    }
    
}
