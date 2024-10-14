//
//  NetworkManager.swift
//  NykaaDemo
//
//  Created by Asif Khan on 01/10/2024.
//

import Foundation
enum NetworkError: Error {
    case badURL
    case requestFailed
    case invalidResponse
    case decodingError
}

class NetworkManager{
    init(){}
    static let shared = NetworkManager()
    /*
    func getDataFromServer<T: Decodable>(urlStr: String,_ completionHandler: @escaping (Result<T,Error>) -> Void){
        guard let url = URL(string: urlStr) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: urlRequest) { data, urlResponse, error in
            if let err =  error{
                completionHandler(.failure(err))
            }
            do {
                let products = try JSONDecoder().decode(T.self, from: data!)
                    print("products \(products)")
                    completionHandler(.success(products))
            }catch let error{
                completionHandler(.failure(error))
            }
        }
        task.resume()
    }
     */
    
    func get<T: Decodable>(urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw NetworkError.badURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.requestFailed
        }
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError
        }
    }
}

// Protocol
protocol ProductAPIServiceProviderProtocol {
    associatedtype T
    func fetchUsers(_ urlString:String?) async throws -> [T?]
}

// For Actual Service Manager
class ProductAPIServiceManager: ProductAPIServiceProviderProtocol {
    typealias T = Product
    func fetchUsers(_ urlString: String?) async throws -> [Product?] {
        do {
            let result:Products = try await NetworkManager.shared.get(urlString: urlString!)
            return result.products
        } catch {
            throw error
        }
    }
}

// For mock data Service Manager
class MockProductAPIServiceManager: ProductAPIServiceProviderProtocol {
    typealias T = Product
    func fetchUsers(_ urlString: String?) async throws -> [Product?] {
        return [Product(name: "Hero",price: 100,rating: 4.5),Product(name: "Hero",price: 100,rating: 4.5),Product(name: "Hero",price: 100,rating: 4.5)]
    }
}


