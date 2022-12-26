//
//  NetworkManager.swift
//  GalleryDemo
//
//  Created by Nakul Singh on 24/12/22.
//

import Foundation

enum GaleryError: Error {
    case BadURL
    case NoData
    case DecodingError
}


class NetworkManager {
    let aPIHandler: APIHandlerDelegate
    let responseHandler: ResponseHandlerDelegate
    
    init(aPIHandler: APIHandlerDelegate = APIHandler(),
         responseHandler: ResponseHandlerDelegate = ResponseHandler()) {
        self.aPIHandler = aPIHandler
        self.responseHandler = responseHandler
    }
    
    func fetchRequest<T: Codable>(type: T.Type, request: URLRequest, completion: @escaping(Result<T, GaleryError>) -> Void) {
       
        aPIHandler.fetchData(request: request) { result in
            switch result {
            case .success(let data):
                self.responseHandler.fetchModel(type: type, data: data) { decodedResult in
                    switch decodedResult {
                    case .success(let model):
                        completion(.success(model))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
    
}

protocol APIHandlerDelegate {
    func fetchData(request: URLRequest, completion: @escaping(Result<Data, GaleryError>) -> Void)
}

class APIHandler: APIHandlerDelegate {
    func fetchData(request: URLRequest, completion: @escaping(Result<Data, GaleryError>) -> Void) {
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.NoData))
            }
            completion(.success(data))
           
        }.resume()
    }
    
}

protocol ResponseHandlerDelegate {
    func fetchModel<T: Codable>(type: T.Type, data: Data, completion: (Result<T, GaleryError>) -> Void)
}

class ResponseHandler: ResponseHandlerDelegate {
    func fetchModel<T: Codable>(type: T.Type, data: Data, completion: (Result<T, GaleryError>) -> Void) {
        /* use this code when want to print response
        let json = try? JSONSerialization.jsonObject(with: data)
        debugPrint(json ?? "No data")
        */
        let commentResponse = try? JSONDecoder().decode(type.self, from: data)
        if let commentResponse = commentResponse {
            return completion(.success(commentResponse))
        } else {
            completion(.failure(.DecodingError))
        }
    }
    
}
