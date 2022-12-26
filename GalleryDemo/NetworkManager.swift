//
//  NetworkManager.swift
//  GalleryDemo
//
//  Created by Nakul Singh on 24/12/22.
//

import Foundation

protocol NetworkManagerProtocol {
    func request(path: String, method: String, parameters: [String: Any]?, headers: [String: String]?, completion: @escaping (Data?, URLResponse?, Error?) -> Void)
}

class NetworkManager: NetworkManagerProtocol {

    // MARK: - Properties

    let baseURL: URL

    // MARK: - Initialization

    init(baseURL: URL) {
        self.baseURL = baseURL
    }

    // MARK: - Request Methods

    func request(path: String, method: String, parameters: [String: Any]? = nil, headers: [String: String]? = nil, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        // Build the full URL for the request
        let url = baseURL.appendingPathComponent(path)

        // Build the request object
        var request = URLRequest(url: url)
        request.httpMethod = method
        if let parameters = parameters {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        }
        if let headers = headers {
            for (key, value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }

        // Send the request
        let task = URLSession.shared.dataTask(with: request, completionHandler: completion)
        task.resume()
    }

}
