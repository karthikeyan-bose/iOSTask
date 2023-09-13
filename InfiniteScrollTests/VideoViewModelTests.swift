//
//  VideoViewModelTests.swift
//  InfiniteScrollTests
//
//  Created by Karthikeyan (Cognizant) on 13/09/23.
//

import XCTest
@testable import InfiniteScroll

class VideoViewModelTests: XCTestCase {

    func testFetchVideos() {
        // Arrange
        let mockService = MockVideoService()
        let viewModel = VideoViewModel(service: mockService)
        let expectation = XCTestExpectation(description: "Data fetched")

        // Act
        viewModel.fetchVideos {
            expectation.fulfill()
        }

        // Assert
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(viewModel.numberOfVideos, 3)  
    }

    func testLoadMoreVideos() {
        // Arrange
        let mockService = MockVideoService()
        let viewModel = VideoViewModel(service: mockService)
        let expectation = XCTestExpectation(description: "Data fetched")

        // Act
        viewModel.fetchVideos {
            viewModel.loadMoreVideos {
                expectation.fulfill()
            }
        }

        // Assert
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(viewModel.numberOfVideos, 3)
        viewModel.loadMoreVideos {
            XCTAssertEqual(viewModel.numberOfVideos, 3)
        }
    }

    func testGetVideoAtIndex() {
        // Arrange
        let mockService = MockVideoService()
        let viewModel = VideoViewModel(service: mockService)
        let expectation = XCTestExpectation(description: "Data fetched")

        // Act
        viewModel.fetchVideos {
            expectation.fulfill()
        }

        // Assert
        wait(for: [expectation], timeout: 1.0)
        let video = viewModel.getVideo(at: 0)
        XCTAssertNotEqual(video.videoURL.absoluteString, "https://example.com/video1")
    }
}

