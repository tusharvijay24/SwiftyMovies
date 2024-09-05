//
//  WebServiceHelper.swift
//  SwiftyMovies
//
//  Created by Tushar on 05/09/24.
//

import Foundation
import Alamofire

class WebServiceHelper {

    // Singleton instance
    static let shared = WebServiceHelper()
    
    init() { }
    
    // Generic GET request for Decodable models
    func get<T: Decodable>(url: String, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, completion: @escaping (Result<T, Error>) -> Void) {
        request(url: url, method: .get, parameters: parameters, headers: headers, completion: completion)
    }
    
    // Generic POST request for Decodable models
    func post<T: Decodable>(url: String, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, completion: @escaping (Result<T, Error>) -> Void) {
        request(url: url, method: .post, parameters: parameters, headers: headers, completion: completion)
    }
    
    private func request<T: Decodable>(url: String, method: HTTPMethod, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, completion: @escaping (Result<T, Error>) -> Void) {
        AF.request(url, method: method, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
