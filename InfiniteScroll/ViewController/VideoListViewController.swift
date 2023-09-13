//
//  VideoListViewController.swift
//  InfiniteScroll
//
//  Created by Karthikeyan
//

import UIKit

class VideoListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = VideoViewModel(service: VideoService())
    var isLoadingData = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchVideos()
        // Do any additional setup after loading the view.
    }
    
    
    func fetchVideos()  {
        viewModel.fetchVideos { [weak self]  in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    
    func loadMore()  {
        viewModel.fetchVideos { [weak self]  in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfVideos
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            // print("this is the last cell")
            let spinner = UIActivityIndicatorView(style: .medium)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            
            self.tableView.tableFooterView = spinner
            self.tableView.tableFooterView?.isHidden = false
        }
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as! VideoTableViewCell
        let video = viewModel.getVideo(at: indexPath.row)
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        cell.configure(with: video)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.frame.width+10
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contetHeight = scrollView.contentSize.height
        let screenHeight = scrollView.frame.height
        
        if !isLoadingData, offsetY > contetHeight - screenHeight {
            isLoadingData = true
            viewModel.loadMoreVideos { [weak self]  in
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.isLoadingData = false
                }
            }
        }
    }
    
}
