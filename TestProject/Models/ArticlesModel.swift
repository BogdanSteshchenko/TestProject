//
//  ArticlesModel.swift
//  TestProject
//
//  Created by Богдан Стещенко on 03.09.2022.
//

import Foundation

struct ArticlesModel: Decodable {
    let results: [Article]
}

struct Article: Decodable {
    let published_date: String
    let section: String
    let byline: String
    let title: String
    let abstract: String
    let media: [Media]?
}

struct Media: Decodable {
    let media_metadata: [MediaMetadata]
    
    enum CodingKeys: String, CodingKey {
        case media_metadata = "media-metadata"
    }
}

struct MediaMetadata: Decodable {
    let url: String
}
