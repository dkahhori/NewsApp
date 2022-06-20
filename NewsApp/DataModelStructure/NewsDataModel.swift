//
//  NewsDataModel.swift
//  NewsApp
//
//  Created by Dilshodi Kahori on 6/19/22.
//

import Foundation

struct News: Decodable {
    let status: String?
    let totalResults: Int?
    let articles: [NewsDetails]?
    
    struct NewsDetails: Decodable {
        let title: String?
        let description: String?
        let image: String?
        let url: URL?
                
        enum CodingKeys: String, CodingKey {
            case title = "title"
            case description = "description"
            case image = "urlToImage"
            case url = "url"
        }
    }
        
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case totalResults = "totalResults"
        case articles = "articles"
    }
}

