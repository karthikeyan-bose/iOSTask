//
//  News.swift
//  NewsList
//
//  Created by Bose, Karthikeyan (Cognizant) on 11/09/23.
//

import Foundation

struct News: Codable {
    let title: String
    let multimedia: [Multimedia]
    let author: String?
}

struct Multimedia: Codable {
    let url: String
}
