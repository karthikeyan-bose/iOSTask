//
//  NewsListTests.swift
//  NewsListTests
//
//  Created by Bose, Karthikeyan (Cognizant) on 11/09/23.
//

import XCTest
@testable import NewsList

final class NewsListTests: XCTestCase {
    var newsViewModel: NewsViewModel!
    
    override func setUp() {
        super.setUp()
        let newsServiceMock = NewsServiceMock()
        newsViewModel = NewsViewModel(newsService: newsServiceMock)
    }
    
    override func tearDown() {
        newsViewModel = nil
        super.tearDown()
    }
    
    func testFetchNews() {
        // Prepare a mock response for the NewsService
        let testNews = [News(title: "Test News", multimedia: [], author: "Test Author")]
        newsViewModel.newsService.mockedNews = testNews
        
        let expectation = XCTestExpectation(description: "Fetch news data")
        
        newsViewModel.fetchNews {
            XCTAssertEqual(self.newsViewModel.news.count, 1, "News count should be 1")
            XCTAssertEqual(self.newsViewModel.news[0].title, "Test News", "News title should match")
            XCTAssertEqual(self.newsViewModel.news[0].author, "Test Author", "News author should match")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
}
