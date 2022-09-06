//
//  NetworkRequest.swift
//  TestProject
//
//  Created by Богдан Стещенко on 03.09.2022.
//

import Foundation
import Alamofire

class NetworkRequest {
    
    static let shared = NetworkRequest()
    
    private init() {
    }
    
    func requestData(urlString: String, comlition: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        AF.request(url).responseData { response in
            DispatchQueue.main.async {
                guard let data = response.data else {
                    let error = NSError()
                    comlition(.failure(error))
                    return
                }
                comlition(.success(data))
            }
        }
    }
}
