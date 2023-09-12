//
//  NewsCell.swift
//  NewsList
//
//  Created by Bose, Karthikeyan (Cognizant) on 11/09/23.
//

import UIKit

import Foundation
import UIKit

class NewsCell: UITableViewCell {
    
    @IBOutlet var newsImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configure(with news: News) {
        titleLabel.text = news.title
        authorLabel.text = "By \(news.author ?? "")"
        
        DispatchQueue.global().async { [weak self] in
            if let url = URL(string: news.multimedia.first?.url ?? ""),let imageData = try? Data(contentsOf: url),
               let image = UIImage(data: imageData) {
                
                DispatchQueue.main.async {
                    self?.newsImageView.image = image
                }
                
            }
        }
    }
    
    private func reset() {
        titleLabel.text = ""
        authorLabel.text = ""
        newsImageView.image = nil


    }
    
    override func prepareForReuse() {
        reset()
    }
    
}
