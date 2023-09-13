//
//  File.swift
//  InfiniteScroll
//
//  Created by Karthikeyan 
//

import Foundation


class VideoViewModel {

    private var allVideos: [Video] = []
    private var displayedVideos: [Video] = []

    private let itemsPerPage = 10
    private var currentPage = 1

    private let service: VideoService  // Injected dependency

    init(service: VideoService) {
        self.service = service
    }

    var numberOfVideos: Int {
        return displayedVideos.count
    }

    func fetchVideos(completion: @escaping () -> Void) {
        service.fetchData { [weak self] videoUrls in
            // Map video URLs to Video objects and update allVideos
            self?.allVideos = videoUrls.compactMap { urlStr in
                if let url = URL(string: urlStr) {
                    return Video(videoURL: url)
                }
                return nil
            }
            
            // Load the initial page
            self?.loadMoreVideos {
                completion()
            }
        }
    }

    func loadMoreVideos(completion: @escaping () -> Void) {
        let startIndex = (currentPage - 1) * itemsPerPage
        let endIndex = min(startIndex + itemsPerPage, allVideos.count)

        if startIndex < allVideos.count {
            let newVideos = Array(allVideos[startIndex..<endIndex])
            displayedVideos.append(contentsOf: newVideos)
            currentPage += 1
        }

        completion()
    }

    func getVideo(at index: Int) -> Video {
        guard index >= 0, index < displayedVideos.count else {
            return Video(videoURL: URL(string: "")!)
        }
        return displayedVideos[index]
    }
}

