//
//  GalleryViewModel.swift
//  GalleryDemo
//
//  Created by Nakul Singh on 24/12/22.
//

import UIKit

protocol GalleryViewModelProtocol {
    var imageCount: Int { get }
    func searchTopImagesOfTheWeek(completion: @escaping (Error?) -> Void)
    func image(at index: Int) -> UIImage
}

class GalleryViewModel: GalleryViewModelProtocol {

    // MARK: - Properties
    let networkManager: NetworkManagerProtocol
    var images: [ImageDataModel] = []
    var imageCount: Int {
        return images.count
    }
    
    // MARK: - Initialization

    init(networkManager: NetworkManagerProtocol = NetworkManager(baseURL: URL(fileURLWithPath: ""))) {
        self.networkManager = networkManager
    }

    // MARK: - API Calls

    func searchTopImagesOfTheWeek(completion: @escaping (Error?) -> Void) {
        // Fetch the user list from the API
        
        networkManager.request(path: "https://dummyjson.com/products/1", method: "GET", parameters: nil, headers: nil) { [weak self] data, response, error in
            guard let self = self else { return }
            if let data = data {
                // Parse the response data
                let images = try? JSONDecoder().decode(ImageDataModel.self, from: data)
//                self.images = images ?? []
                completion(nil)
                // Reload the table view to display the new data
            }
            if let error = error {
                print(error)
                completion(error)
            }
        }
    }
    
    func image(at index: Int) -> UIImage {
        return UIImage()
    }
}

