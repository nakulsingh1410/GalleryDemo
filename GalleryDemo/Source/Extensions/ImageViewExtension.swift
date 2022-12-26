//
//  ImageViewExtension.swift
//  GalleryDemo
//
//  Created by Nakul Singh on 26/12/22.
//

import UIKit

extension UIImageView {
    // MARK: - Properties
    
    private static let imageCache = NSCache<NSString, UIImage>()
    
    // MARK: - Methods
    
    func loadImage(from urlString: String?) {
        guard let urlString = urlString else { return }
        // Check if the image is in the cache
        if let image = UIImageView.imageCache.object(forKey: urlString as NSString) {
            // Use the cached image
            self.image = image
            return
        }
        
        // Set the image URL
        guard let url = URL(string: urlString) else { return }
        
        // Create a request for the image
        let request = URLRequest(url: url)
        
        // Create a task to download the image
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            // Convert the data to an image
            if let data = data, let image = UIImage(data: data) {
                // Cache the image
                UIImageView.imageCache.setObject(image, forKey: urlString as NSString)
                
                // Update the image view on the main thread
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
        
        // Start the task
        task.resume()
    }
}

