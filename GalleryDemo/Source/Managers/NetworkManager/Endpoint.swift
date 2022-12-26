//
//  Endpoint.swift
//  GalleryDemo
//
//  Created by Nakul Singh on 26/12/22.
//


import Foundation

import Foundation

fileprivate let CLIENT_ID = "2c2263046817479"

struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]
}

extension Endpoint {
    static func searchImages(searchText: String) -> Endpoint {
        return Endpoint(
            path: "/3/gallery/top/week/0",
            queryItems: [URLQueryItem(name: "q", value: "\(searchText)")]
        )
    }
}

extension Endpoint {
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.imgur.com"
        components.path = path
        components.queryItems = queryItems

        return components.url
    }
    
    var request: URLRequest? {
        guard let url = url else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("Client-ID \(CLIENT_ID)", forHTTPHeaderField: "Authorization")
        return urlRequest
    }
}
