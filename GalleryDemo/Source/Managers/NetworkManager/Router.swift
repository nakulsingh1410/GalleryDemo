//
//  Router.swift
//  GalleryDemo
//
//  Created by Nakul Singh on 26/12/22.
//


import Foundation

enum Router {
    
    case getSources
//    case getProductIds(collectionId: String)
//    case getProductInfo(productId: String)
    
    
    var accessToken: String {
        return "c32313df0d0ef512ca64d5b336a0d7c6"
    }
    
    
    var scheme: String {
        switch self {
        case .getSources:
            return "https"
        }
    }
    
    var host: String {
        let base = "api.imgur.com" //https://api.imgur.com/3/gallery/top/week/0
        switch self {
        case .getSources:
            return base
        }
    }
    
    var path: String {
        switch self {
        case .getSources:
            return "/admin/custom_collections.json"
//        case .getProductIds:
//            return "/admin/collects.json"
//        case .getProductInfo:
//            return "/admin/products.json"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .getSources:
            return [URLQueryItem(name: "page", value: "1"),
                    URLQueryItem(name: "access_token", value: accessToken)]
//        case .getProductIds(let collectionId):
//            return [URLQueryItem(name: "page", value: "1"),
//                    URLQueryItem(name: "collection_id", value: collectionId),
//                    URLQueryItem(name: "access_token", value: accessToken)]
//        case .getProductInfo(let productId):
//            return [URLQueryItem(name: "ids", value: productId),
//                    URLQueryItem(name: "page", value: "1"),
//                    URLQueryItem(name: "access_token", value: accessToken)]
        }
    }
    
    var method: String {
        switch self {
        case .getSources:
            return "GET"
        }
    }
    
}
