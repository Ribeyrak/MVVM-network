//
//  Network.swift
//  Acrch
//
//  Created by Evhen Lukhtan on 22.02.2023.
//

import Foundation
import Alamofire

class NetworkManager {

    func fetchData(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        AF.request(url).validate().response { response in
            switch response.result {
            case .success(let data):
                if let data = data {
                    completion(.success(data))
                } else {
                    completion(.failure(NSError(domain: "Invalid data", code: 0, userInfo: nil)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

