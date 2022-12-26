//
//  GalleryViewModel.swift
//  GalleryDemo
//
//  Created by Nakul Singh on 24/12/22.
//

import UIKit

protocol GalleryViewModelProtocol {
    var imageCount: Int { get }
    func searchTopImagesOfTheWeek(completion: @escaping (GaleryError?) -> Void)
    func image(at index: Int) -> GalleryData?
}

class GalleryViewModel: GalleryViewModelProtocol {

    // MARK: - Properties
    var images: [GalleryData] = []
    var imageCount: Int {
        return images.count
    }
    
    // MARK: - API Calls

    func searchTopImagesOfTheWeek(completion: @escaping (GaleryError?) -> Void) {
        // Fetch the user list from the API
        
        guard let url = URL(string: "https://api.imgur.com/3/gallery/top/week/0?q=ram") else {
            return completion(.BadURL)
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("Client-ID 2c2263046817479", forHTTPHeaderField: "Authorization")
        
        NetworkManager().fetchRequest(type: ImageDataModel.self, request: urlRequest) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let imageData):
                    print("Fetched new images")
                    self.images = imageData.data
                    completion(nil)
                case .failure(let error):
                    print(error)
                    completion(.DecodingError)
                }
            }
            
        }
    }
    
    func image(at index: Int) -> GalleryData? {
        return self.images[index]
    }
}


