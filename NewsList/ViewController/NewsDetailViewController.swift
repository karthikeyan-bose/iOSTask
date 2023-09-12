//
//  NewsDetailViewController.swift
//  NewsList
//
//  Created by Bose, Karthikeyan (Cognizant) on 11/09/23.
//

import UIKit

class NewsDetailViewController: UIViewController {
    var news: News?
    
    @IBOutlet var titleLabel: UILabel!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        if let news = news {
            titleLabel.text = news.title
        }
        
    }
}

