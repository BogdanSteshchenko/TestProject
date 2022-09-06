//
//  NetworkDataFetch.swift
//  TestProject
//
//  Created by Богдан Стещенко on 03.09.2022.
//

import Foundation

class NetworkDataFetch {
    
    static let shared = NetworkDataFetch()
    
    private init() {
    }
    
    func fetchArticles(urlString: String, responce: @escaping (ArticlesModel?, Error?) -> Void) {
        NetworkRequest.shared.requestData(urlString: urlString) { result in
            switch result {
            case .success(let data):
                do {
                    let articles = try JSONDecoder().decode(ArticlesModel.self, from: data)
                    responce(articles, nil )
                } catch let jsonError {
                    print("ERROR JSON = \(jsonError)")
                }
            case .failure(let error):
                responce(nil, error)
            }
        }
    }
}
